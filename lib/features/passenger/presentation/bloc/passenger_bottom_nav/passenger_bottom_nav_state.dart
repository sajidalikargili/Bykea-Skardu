import 'package:equatable/equatable.dart';

class PassengerBottomNavState  extends  Equatable{
  final int selectedIndex;
  PassengerBottomNavState({required this.selectedIndex});
 PassengerBottomNavState  copyWith(int? selectedIndex){
   return PassengerBottomNavState(selectedIndex :selectedIndex ?? this.selectedIndex);
 }
  @override
  List<Object?> get props => [selectedIndex];
}