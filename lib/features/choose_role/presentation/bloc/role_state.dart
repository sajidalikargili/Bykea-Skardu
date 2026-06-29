import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  const RoleState();
  @override

  List<Object?> get props => throw UnimplementedError();
}
class RoleInitial extends RoleState{

}
class RoleLoading extends RoleState{
final String role;
RoleLoading(this.role);
}
class RoleSuccess extends RoleState{
  final String role;
  RoleSuccess(this.role);
}
class RoleFailure extends RoleState{
 final String message;
 RoleFailure(this.message);
}