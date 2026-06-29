import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SelectedIndexEvent extends BottomNavEvent{
   final int selectedIndex;
   SelectedIndexEvent(this.selectedIndex);
}