import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
 const RoleEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}
class SelectRoleEvent extends RoleEvent{
  final String uid;
  final String role;
  SelectRoleEvent(this.uid,this.role);
}