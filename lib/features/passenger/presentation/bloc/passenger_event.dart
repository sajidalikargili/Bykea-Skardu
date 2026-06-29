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
class StandUpdatedEvent extends PassengerEvent {
  final List<StandModel> stands;

  StandUpdatedEvent(this.stands);
}