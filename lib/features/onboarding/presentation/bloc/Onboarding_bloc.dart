import 'package:bykea_skardu/features/onboarding/presentation/bloc/onBoarding_event.dart';
import 'package:bykea_skardu/features/onboarding/presentation/bloc/onBoarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent,OnboardingState>{
  OnboardingBloc():super(OnboardingInitial()){
    on<ChangPageEvent>(_changPage);
  }
  void _changPage(ChangPageEvent event,Emitter<OnboardingState> emit){
    emit(ChangePageState(event.pageIndex));
  }
}