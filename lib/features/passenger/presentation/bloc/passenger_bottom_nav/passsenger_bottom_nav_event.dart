import 'package:equatable/equatable.dart';

abstract class PasssengerBottomNavEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class PassengerSelectedIndexEvent extends PasssengerBottomNavEvent{
  final int selectedIndex;
  PassengerSelectedIndexEvent(this.selectedIndex);
  @override
  // TODO: implement props
  List<Object?> get props => [selectedIndex];
}