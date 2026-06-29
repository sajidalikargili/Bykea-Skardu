import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
@override
  List<Object?> get props => throw UnimplementedError();
}
class RegisterEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  RegisterEvent(this.name, this.phone, this.password);
}
class LoginEvent extends AuthEvent {
  final String phone;
  final String password;
  LoginEvent( this.phone,this.password);
}
class logOutEvent extends AuthEvent{

}

