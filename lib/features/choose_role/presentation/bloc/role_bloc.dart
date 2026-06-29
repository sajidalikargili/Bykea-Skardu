import 'dart:core';
import 'dart:core' as e;
import 'package:bykea_skardu/features/auth/data/auth_repository.dart';
import 'package:bykea_skardu/features/choose_role/presentation/bloc/role_event.dart';
import 'package:bykea_skardu/features/choose_role/presentation/bloc/role_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RoleBloc extends Bloc<RoleEvent,RoleState> {
  AuthRepository authRepository;
  RoleBloc(this.authRepository):super(RoleInitial()){
    on<SelectRoleEvent>(_selectRole);
  }
   Future<void>  _selectRole(SelectRoleEvent event,Emitter<RoleState> emit) async {
     print("SelectRoleEvent received");
    emit (RoleLoading(event.role));

   try{
     await authRepository.saveRole(event.uid,event.role);
     emit(RoleSuccess(event.role));
   }catch(e){
      emit(RoleFailure(e.toString()));
   }

  }

}