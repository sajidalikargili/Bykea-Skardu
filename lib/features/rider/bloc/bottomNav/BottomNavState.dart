class BottomNavState {
  final int  selectedIndex;
  BottomNavState({required this.selectedIndex});
  BottomNavState copyWith(int? selectedIndex){
    return BottomNavState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}