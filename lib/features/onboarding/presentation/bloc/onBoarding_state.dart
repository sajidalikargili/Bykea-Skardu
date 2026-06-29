import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
@override
  List<Object?> get props => [];
}
class OnboardingInitial extends OnboardingState{

}
class ChangePageState extends OnboardingState{
  final int currentPage;
  ChangePageState(this.currentPage);
  @override
  // TODO: implement props
  List<Object?> get props => [currentPage];
}