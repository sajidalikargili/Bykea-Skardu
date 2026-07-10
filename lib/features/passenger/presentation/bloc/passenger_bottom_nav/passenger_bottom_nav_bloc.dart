import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_bottom_nav/passenger_bottom_nav_state.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_bottom_nav/passsenger_bottom_nav_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerBottomNavBloc  extends Bloc<PasssengerBottomNavEvent,PassengerBottomNavState>{
  PassengerBottomNavBloc():super(PassengerBottomNavState(selectedIndex: 0)){
    on<PassengerSelectedIndexEvent>(_passengerSelectedIndexEvent);
  }
 void _passengerSelectedIndexEvent(PassengerSelectedIndexEvent event,Emitter<PassengerBottomNavState> emit){
    print("passengerSelectedIndex:${event.selectedIndex}");
     emit(state.copyWith(event.selectedIndex));
 }
}