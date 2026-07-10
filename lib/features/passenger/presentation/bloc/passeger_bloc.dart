import 'dart:async';

import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/passenger/data/model/StandModel.dart';
import 'package:bykea_skardu/features/passenger/data/repository/rating_repository.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassegerBloc extends Bloc<PassengerEvent, PassengerState> {
  StreamSubscription<DocumentSnapshot>? _rideSubscription;
  StreamSubscription? _standSubscription;
  PassegerBloc() : super(PassengerState()) {
    on<LoadStandEvent>(_loadEvent);
    on<SelectStandEvent>(_selectStand);
    on<SelectDistinationEvent>(_selectDistination);
    on<CreateRideEvent>(_createRide);
    on<ListenRideEvent>(_listRide);
    on<RideUpdatedEvent>(_rideUpdated);
    on<StandUpdatedEvent>(_standUpdated);
    on<CancelRidePassengerEvent>(_cancelRide);
    on<LoadPassengerBookingsEvent>(_loadPassengerBookings);
    on<LoadPassengerEvent>(_loadPassenger);
    on<SubmitRideRatingEvent>(_submitRating);
    on<ChangeRatingEvent>(_changRating);
    on<ResetRatingEvent>(_resetRating);
  }

  void _loadEvent(
      LoadStandEvent event,
      Emitter<PassengerState> emit,
      ) {
    print("LoadStandEvent Called");

    _standSubscription?.cancel();

    _standSubscription = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'rider')
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {

      print("Documents: ${snapshot.docs.length}");

      final Map<String, int> standCount = {};

      for (var doc in snapshot.docs) {
        final stand = doc['stand'] as String;

        standCount[stand] = (standCount[stand] ?? 0) + 1;
      }

      final stands = standCount.entries.map((e) {
        return StandModel(
          standName: e.key,
          riderCount: e.value,
        );
      }).toList();

      add(StandUpdatedEvent(stands));
    });
  }
  void _cancelRide(CancelRidePassengerEvent event,Emitter<PassengerState> emit)async{
    await FirebaseFirestore.instance
        .collection('rides')
        .doc(event.ride.rideId)   // ✅ Use rideId
        .update({
      'status': 'cancelled',
    });

    emit(
      state.copyWith(
        ride: event.ride.copyWith(
          status: 'cancelled',
        ),
      ),
    );
  }

  void _selectStand(SelectStandEvent event, Emitter<PassengerState> emit) {
    print("standName:${event.standName.standName}");
    emit(state.copyWith(standName: event.standName));
  }

  void _selectDistination(
    SelectDistinationEvent event,
    Emitter<PassengerState> emit,
  ) {
    print("distinationName:${event.distinationName}");
    emit(state.copyWith(distinationName: event.distinationName));
  }

  void _createRide(CreateRideEvent event, Emitter<PassengerState> emit) async {
    final rideId = FirebaseFirestore.instance.collection('rides').doc().id;
    final passengerId = FirebaseAuth.instance.currentUser!.uid;

    final ride = RideModel(
      rideId: rideId,
      passengerId: passengerId,
      pickupStand: state.standName!.standName,
      distination: state.distinationName ?? '',
      status: 'pending',
    );

    await FirebaseFirestore.instance
        .collection('rides')
        .doc(rideId)
        .set(ride.toJson());

    emit(state.copyWith(
      rideCreated: true,
      ride: ride,
    ));

    // 👇 Start listening immediately
    add(ListenRideEvent());
  }

  void _listRide(ListenRideEvent event, Emitter<PassengerState> emit) {
    print("ListenRideEvent called");

    final ride = state.ride;

    if (ride == null) {
      print("Ride is null");
      return;
    }

    print("Listening to ride: ${ride.rideId}");

    _rideSubscription?.cancel();

    _rideSubscription = FirebaseFirestore.instance
        .collection('rides')
        .doc(ride.rideId)
        .snapshots()
        .listen((doc) {

      print("Firestore updated");

      if (!doc.exists) {
        print("Document doesn't exist");
        return;
      }

      final updatedRide = RideModel.fromMap(doc.data()!);

      print("Status: ${updatedRide.status}");
      print("Rider: ${updatedRide.riderName}");

      add(RideUpdatedEvent(updatedRide));
    });
  }

  void _rideUpdated(
      RideUpdatedEvent event,
      Emitter<PassengerState> emit,
      ) {
    print("RideUpdatedEvent emitted");
    print(" state :${state.ride!.distination}");
    print(" state :${state.ride!.distination}");
    print(" event :${event.ride!.distination}");
    print(" event :${event.ride!.distination}");
    if (state.ride == event.ride) return;

    emit(state.copyWith(ride: event.ride));
  }
  void _standUpdated(
      StandUpdatedEvent event,
      Emitter<PassengerState> emit,
      ) {
    emit(
      state.copyWith(
        stands: event.stands,
      ),
    );
  }
  @override
  Future<void> close() {
    _rideSubscription?.cancel();
    _standSubscription?.cancel();
    return super.close();
  }
  Future<void> _loadPassengerBookings(
      LoadPassengerBookingsEvent event,
      Emitter<PassengerState> emit,
      ) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await emit.forEach(
      FirebaseFirestore.instance
          .collection('rides')
          .where('passengerId', isEqualTo: uid)
          .snapshots(),
      onData: (snapshot) {
        final rides = snapshot.docs
            .map((e) => RideModel.fromMap(e.data()))
            .toList();

        rides.sort((a, b) => b.rideId.compareTo(a.rideId));

        return state.copyWith(
          bookings: rides,
        );
      },
    );
  }
  void _loadPassenger(LoadPassengerEvent event,Emitter<PassengerState> emit) async{

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (!doc.exists) return;

    final passenger = UserModel.formMap(doc.data()!);
    print("passenger:${passenger}");

    emit(
      state.copyWith(
        passenger: passenger,
      ),
    );
  }
  void _submitRating(SubmitRideRatingEvent event,Emitter<PassengerState> emit) async{
     await RatingRepository.submitRideRating(rideId: event.rideId, rating: event.rating, comment: event.comment);
     emit(state.copyWith(ratingSubmitted: true));
  }
 void _changRating(ChangeRatingEvent event,Emitter<PassengerState> emit){
     emit(state.copyWith(selectedRating: event.index));
 }
 void _resetRating(ResetRatingEvent event ,Emitter<PassengerState> emit){
    emit(state.copyWith(selectedRating: 0,ratingSubmitted: false,ratingSubmitting: false));
 }

}
