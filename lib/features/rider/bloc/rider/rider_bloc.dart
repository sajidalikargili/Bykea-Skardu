import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_bookings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RiderBloc extends Bloc<RiderEvent,RiderState> {
      RiderBloc(): super(RiderState()){
        on<SelectStandEvent>(_selectStand);
        on<GoOnlineEvent>(_goOnline);
        on<GoOffLineEvent>(_goOffLine);
        on<LoadRideRequestsEvent>(_loadRideRequest);
        on<AcceptRideEvent>(_acceptRide);
        on<DeclineRideEvent>(_declineRide);
        on<StartRideEvent>(_startRide);
        on<CompleteRideEvent>(_completeRide);
        on<LoadEarningsEvent>(_loadEarnings);
        on<CancelRideEvent>(_cancelRide);
        on<LoadRiderEvent>(_loadRider);
        on<ClearCurrentRideEvent>(_clearCurrentRide);
        on<LoadRiderBookingsEvent>(_loadRiderBookings);
        on<LoadRideRatingEvent>(_loadRideRating);

      }
      void _selectStand(SelectStandEvent event,Emitter<RiderState> emit){
        emit(state.copyWith(selectStand: event.stand));
      }

      void _goOnline(GoOnlineEvent event,Emitter<RiderState> emit) async{
       final uid=FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({
          'isOnline': true,
          'stand': state.selectStand,
        });
        emit(state.copyWith(isOnline: true));
      }
     void _goOffLine(GoOffLineEvent event,Emitter<RiderState> emit)async {
       final uid=FirebaseAuth.instance.currentUser!.uid;
       await FirebaseFirestore.instance
           .collection('users')
           .doc(uid)
           .update({
         'isOnline': false,
       });
        emit(state.copyWith(isOnline: false));
     }
      void _loadRideRequest(
          LoadRideRequestsEvent event,
          Emitter<RiderState> emit,
          ) async {
        print("LoadRideRequestsEvent Called");
        print("Stand: ${event.standName}");

        final riderId = FirebaseAuth.instance.currentUser!.uid;

        await emit.forEach<QuerySnapshot<Map<String, dynamic>>>(
          FirebaseFirestore.instance
              .collection('rides')
              .where('pickupStand', isEqualTo: event.standName)
              .where('status', isEqualTo: 'pending')
              .snapshots(),
          onData: (snapshot) {
            final rides = snapshot.docs
                .map((doc) => RideModel.fromMap(doc.data()))
                .where(
                  (ride) =>
              !(ride.declinedRiders ?? []).contains(riderId),
            )
                .toList();

            print("Filtered rides: ${rides.length}");

            return state.copyWith(
              rides: rides,
              selectStand: event.standName,
            );
          },
        );
      }
      void _acceptRide(AcceptRideEvent event, Emitter<RiderState> emit) async {
        final rideId = event.ride.rideId;
        final passengerId=event.ride.passengerId;

        print("rideId : $rideId");
        print("passengerId: $passengerId");

        if (rideId == null || rideId.isEmpty) {
          print("ERROR: rideId is empty");
          return;
        }
        if(passengerId==null || passengerId.isEmpty){
          print("ERROR :passengerId is empty");
          return;
        }
      final riderDoc=  await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
       if(!riderDoc.exists){
         print("Rider not found");
         return;
       }

        final rider = UserModel.formMap(riderDoc.data()!);
    final passengerDoc= await FirebaseFirestore.instance
        .collection('users')
        .doc(passengerId).get();
    if(!passengerDoc.exists){
      print(" Passenger not found");
      return;
    }
    final passsenger=UserModel.formMap(passengerDoc.data()!);
        await FirebaseFirestore.instance
            .collection('rides')
            .doc(rideId) // ✅ now safe
            .update({
          'riderId': FirebaseAuth.instance.currentUser!.uid,
          'riderName':rider.name,
          'riderPhone':rider.phone,
          'fare':'200',
          'status': 'accepted',

        });
        final updatedRide = event.ride.copyWith(
          riderId: FirebaseAuth.instance.currentUser!.uid,
          fare: '200',
          status: 'accepted',
        );

        emit(
          state.copyWith(
            ride: updatedRide,
            passenger: passsenger,
          ),
        );
      }
      Future<void> _declineRide(
          DeclineRideEvent event,
          Emitter<RiderState> emit,
          ) async {

        await FirebaseFirestore.instance
            .collection('rides')
            .doc(event.ride.rideId)
            .update({
          'declinedRiders': FieldValue.arrayUnion([
            FirebaseAuth.instance.currentUser!.uid,
          ]),
        });

        final updatedRides = List<RideModel>.from(state.rides);

        updatedRides.removeWhere(
              (ride) => ride.rideId == event.ride.rideId,
        );

        emit(
          state.copyWith(
            rides: updatedRides,
          ),
        );
      }
   Future<void> _startRide(StartRideEvent event,Emitter<RiderState> emit)async{
     await FirebaseFirestore.instance
         .collection('rides')
         .doc(event.ride.rideId)   // ✅ Use rideId
         .update({
       'status': 'ongoing',
     });

     emit(
       state.copyWith(
         ride: event.ride.copyWith(
           status: 'ongoing',
         ),
       ),
     );
   }
   void _completeRide(CompleteRideEvent event, Emitter<RiderState> emit) async{
     await FirebaseFirestore.instance
         .collection('rides')
         .doc(event.ride.rideId)   // ✅ Use rideId
         .update({
       'status': 'completed',
     });

     emit(
       state.copyWith(
         ride: event.ride.copyWith(
           status: 'completed',
         ),
       ),
     );
   }
      Future<void> _loadEarnings(
          LoadEarningsEvent event,
          Emitter<RiderState> emit,
          ) async {

        final riderId = FirebaseAuth.instance.currentUser!.uid;

        final snapshot = await FirebaseFirestore.instance
            .collection('rides')
            .where('riderId', isEqualTo: riderId)
            .get();

        int completed = 0;
        int cancelled = 0;
        double earnings = 0;

        for (final doc in snapshot.docs) {

          final ride = RideModel.fromMap(doc.data());

          if (ride.status == "completed") {
            completed++;

            earnings += double.tryParse(ride.fare ?? "0") ?? 0;
          }

          if (ride.status == "cancelled") {
            cancelled++;
          }
        }

        emit(
          state.copyWith(
            totalRides: snapshot.docs.length,
            completedRides: completed,
            cancelledRides: cancelled,
            totalEarnings: earnings,
          ),
        );
      }
      void _cancelRide(CancelRideEvent event,Emitter<RiderState> emit)async{
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
      void _loadRider(LoadRiderEvent event,Emitter<RiderState> emit) async {
        final riderDoc=  await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        if(!riderDoc.exists){
          print("Rider not found");
          return;
        }

        final rider = UserModel.formMap(riderDoc.data()!);
        emit(state.copyWith(rider:rider,selectStand: rider.stand,isOnline: rider.isOnline ?? false));
      }
      void _clearCurrentRide(ClearCurrentRideEvent event,Emitter<RiderState> emit){
        emit(state.copyWith(ride: null,passenger: null));
      }
      void  _loadRiderBookings(LoadRiderBookingsEvent event,Emitter<RiderState> emit) async{
        final uid = FirebaseAuth.instance.currentUser!.uid;

        await emit.forEach(
          FirebaseFirestore.instance
              .collection('rides')
              .where('riderId', isEqualTo: uid)
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
      Future<void> _loadRideRating(
          LoadRideRatingEvent event,
          Emitter<RiderState> emit,
          ) async {
        try {
          debugPrint("========== LOAD RIDE RATING ==========");
          debugPrint("Ride ID: ${event.rideId}");

          final doc = await FirebaseFirestore.instance
              .collection("rides")
              .doc(event.rideId)
              .get();

          debugPrint("Document Exists: ${doc.exists}");

          if (!doc.exists) {
            debugPrint("Ride not found");
            return;
          }

          final data = doc.data()!;

          debugPrint("Firestore Data: $data");

          final updatedRide = state.ride?.copyWith(
            passengerRating: data["passengerRating"] ?? 0,
            passengerComment: data["passengerComment"] ?? "",
          );

          emit(
            state.copyWith(
              ride: updatedRide,
            ),
          );

          debugPrint("Rating Loaded Successfully");
          debugPrint("Rating: ${updatedRide?.passengerRating}");
          debugPrint("Comment: ${updatedRide?.passengerComment}");
        } catch (e, stackTrace) {
          debugPrint(e.toString());
          debugPrint(stackTrace.toString());
        }
      }
}
