import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/passenger/data/model/StandModel.dart';

class PassengerState {
  List<StandModel> stands;
  StandModel? standName;
  String? distinationName;
  final bool rideCreated;
  RideModel? ride;
  PassengerState({this.stands= const[],this.standName,this.distinationName,this.rideCreated=false,this.ride});
  PassengerState copyWith({List<StandModel>? stands,StandModel? standName,String? distinationName,bool? rideCreated,RideModel? ride}){
    return PassengerState(stands: stands ?? this.stands,standName: standName ?? this.standName,distinationName: distinationName ?? this.distinationName,rideCreated: rideCreated ?? this.rideCreated,ride: ride ?? this.ride);
  }
}