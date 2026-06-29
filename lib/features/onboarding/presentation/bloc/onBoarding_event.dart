import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable{
  const OnboardingEvent();
  @override
  List<Object?> get props => [];
}
class ChangPageEvent extends OnboardingEvent{
  final int pageIndex;
  ChangPageEvent(this.pageIndex);
  @override
  // TODO: implement props
  List<Object?> get props => [pageIndex];
}