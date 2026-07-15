import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/passenger/data/model/StandModel.dart';
import 'package:equatable/equatable.dart';
abstract class PassengerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadStandEvent extends PassengerEvent{

}

class SelectStandEvent extends PassengerEvent{
  final StandModel standName;
  SelectStandEvent(this.standName);
}
class SelectDistinationEvent extends PassengerEvent{
 final String distinationName;
 SelectDistinationEvent(this.distinationName);
}
class  CreateRideEvent extends PassengerEvent{

}
class ListenRideEvent extends PassengerEvent{

}
class RideUpdatedEvent extends  PassengerEvent{
  RideModel ride;

  RideUpdatedEvent(this.ride);
}
class AcceptedRideEvent extends PassengerEvent{

}
class CancelRidePassengerEvent extends PassengerEvent{
  RideModel ride;
  CancelRidePassengerEvent(this.ride);
}
class StandUpdatedEvent extends PassengerEvent {
  final List<StandModel> stands;

  StandUpdatedEvent(this.stands);
}
class LoadPassengerBookingsEvent extends PassengerEvent {

}
class LoadPassengerEvent extends PassengerEvent{

}
class SubmitRideRatingEvent extends PassengerEvent{
  final String rideId;
  final int rating;
  final String comment;
  SubmitRideRatingEvent({required this.rideId,required this.rating,required this.comment});
}
class ChangeRatingEvent extends PassengerEvent{
  final int index;
  ChangeRatingEvent({required this.index});
}
class ResetRatingEvent extends PassengerEvent{

}
class ConformBooKingEvent extends PassengerEvent{
  RideModel ride;
  ConformBooKingEvent(this.ride);
}