import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavEvent.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent,BottomNavState> {
     BottomNavBloc():super(BottomNavState(selectedIndex: 0)){
       on<SelectedIndexEvent>(_selectedIndex);
     }
     void _selectedIndex(SelectedIndexEvent event,Emitter<BottomNavState> emit){
        emit(state.copyWith(event.selectedIndex));
     }
}