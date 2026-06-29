import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
     void _loadRideRequest(LoadRideRequestsEvent event,Emitter<RiderState> emit) async{
       print("LoadRideRequestsEvent Called");
       print("Stand: ${event.standName}");
       await emit.forEach(
         FirebaseFirestore.instance
             .collection('rides')
             .where('pickupStand', isEqualTo: event.standName)
             .where('status', isEqualTo: 'pending')
             .snapshots(),
         onData: (snapshot) {
           final rides = snapshot.docs
               .map((doc) => RideModel.fromMap(doc.data()))
               .toList();
           print("load ride:${rides.length}");
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
   void _declineRide(DeclineRideEvent event,Emitter<RiderState> emit) async{
     await FirebaseFirestore.instance
         .collection('rides')
         .doc(state.ride!.riderId)
         .update({
       'declinedRiders': FieldValue.arrayUnion(
         [FirebaseAuth.instance.currentUser!.uid],
       ),
     });
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

}