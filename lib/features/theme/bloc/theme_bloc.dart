import 'package:bykea_skardu/features/theme/bloc/theme_event.dart';
import 'package:bykea_skardu/features/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc  extends Bloc<ThemeEvent,ThemeState>{
ThemeBloc():super(ThemeState(ThemeMode.light)){
  on<ThemeToggleEvent>((event,emit){
  if(state.themeMode==ThemeMode.light){
    emit(ThemeState(ThemeMode.dark));
  }else{
    emit(ThemeState(.light));
  }
 });
}

}