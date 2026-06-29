import 'dart:math';
import 'package:bykea_skardu/features/auth/bloc/auth_event.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_state.dart';
import 'package:bykea_skardu/features/auth/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {
  final AuthRepository authRepository;
 AuthBloc(this.authRepository):super(AuthInitial()){
  on<RegisterEvent>(_register);
  on<LoginEvent>(_login);
  on<logOutEvent>(_logOut);
 }
 Future<void> _register(RegisterEvent event,Emitter<AuthState> emit) async{
   emit(AuthLoading());
   try {
     await authRepository.register(event.name, event.phone,event.password);
     emit(AuthSuccess());
   }catch(e){
     emit(AuthFailure(e.toString()));
   }

 }
 Future<void> _login(LoginEvent event,Emitter<AuthState> state)async{
   emit(AuthLoading());
   try{
       await authRepository.login(event.phone, event.password);
       emit(AuthSuccess());
   }catch(e){
       emit(AuthFailure(e.toString()));
   }
 }

 Future<void> _logOut(logOutEvent event,Emitter<AuthState> state) async{
   emit(AuthLoading());
   try{
    await authRepository.logout();
    emit(AuthSuccess());
   }catch(e){
     emit(AuthFailure(e.toString()));
   }
 }

}
