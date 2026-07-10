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
  RideModel ride;
  DeclineRideEvent(this.ride);
}
class  StartRideEvent extends RiderEvent{
 final RideModel ride;
 StartRideEvent(this.ride);
}
class CompleteRideEvent extends RiderEvent{
  final RideModel ride;
  CompleteRideEvent(this.ride);
}
class LoadEarningsEvent extends RiderEvent{

}
class CancelRideEvent extends RiderEvent{
  final RideModel ride;
  CancelRideEvent(this.ride);
}
class LoadRiderEvent extends RiderEvent{

}
class  ClearCurrentRideEvent extends RiderEvent{

}
class LoadRiderBookingsEvent extends RiderEvent{

}
class LoadRideRatingEvent extends RiderEvent {
  final String rideId;

  LoadRideRatingEvent(this.rideId);
}

