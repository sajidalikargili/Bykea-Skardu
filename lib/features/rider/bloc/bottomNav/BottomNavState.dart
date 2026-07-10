import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int  selectedIndex;
  BottomNavState({required this.selectedIndex});
  BottomNavState copyWith(int? selectedIndex){
    return BottomNavState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedIndex];
}