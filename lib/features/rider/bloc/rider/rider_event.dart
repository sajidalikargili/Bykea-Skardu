import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:equatable/equatable.dart';

abstract class RiderEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SelectStandEvent extends RiderEvent {
  final String stand;
  SelectStandEvent(this.stand);
}
class GoOnlineEvent extends RiderEvent{

}
class GoOffLineEvent extends RiderEvent{

}
class LoadRideRequestsEvent extends RiderEvent{
 final String  standName;
 LoadRideRequestsEvent(this.standName);
 @override
  // TODO: implement props
  List<Object?> get props => [standName];
}
class AcceptRideEvent extends RiderEvent{
 RideModel ride;
 AcceptRideEvent(this.ride);
 @override
  // TODO: implement props
  List<Object?> get props => [ride];
}

class DeclineRideEvent extends RiderEvent{

}
class  StartRideEvent extends RiderEvent{
 final RideModel ride;
 StartRideEvent(this.ride);
}
class CompleteRideEvent extends RiderEvent{
  final RideModel ride;
  CompleteRideEvent(this.ride);
}
