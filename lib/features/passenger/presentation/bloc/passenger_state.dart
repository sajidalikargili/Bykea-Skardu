import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/passenger/data/model/StandModel.dart';

class PassengerState {
  List<StandModel> stands;
  StandModel? standName;
  String? distinationName;
  final bool rideCreated;
  RideModel? ride;
  final List<RideModel> bookings;
  final UserModel? passenger;
  final int selectedRating;
  final bool ratingSubmitting;
  final bool ratingSubmitted;
  PassengerState({this.stands= const[],this.standName,this.distinationName,this.rideCreated=false,this.ride,this.bookings = const [],  this.passenger,this.selectedRating=0,this.ratingSubmitting=false,this.ratingSubmitted=false});
  PassengerState copyWith({List<StandModel>? stands,StandModel? standName,String? distinationName,bool? rideCreated,RideModel? ride,List<RideModel>? bookings, UserModel? passenger,int? selectedRating,bool? ratingSubmitting,bool? ratingSubmitted}){
    return PassengerState(stands: stands ?? this.stands,standName: standName ?? this.standName,distinationName: distinationName ?? this.distinationName,rideCreated: rideCreated ?? this.rideCreated,ride: ride ?? this.ride,bookings: bookings ?? this.bookings,   passenger: passenger ?? this.passenger,selectedRating: selectedRating ?? this.selectedRating,ratingSubmitted: ratingSubmitted ?? this.ratingSubmitted,ratingSubmitting: ratingSubmitting ?? this.ratingSubmitting);
  }
}