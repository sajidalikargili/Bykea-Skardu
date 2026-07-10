import 'package:equatable/equatable.dart';
abstract class AuthState extends Equatable {
  const  AuthState();
@override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class AuthInitial extends AuthState{

}
class AuthLoading extends AuthState{

}
class AuthSuccess extends AuthState{

}
class AuthFailure extends AuthState{
  final String message;
  AuthFailure(this.message);
}

class AuthNeedRole extends AuthState {}

class AuthPassenger extends AuthState {}

class AuthRider extends AuthState {}