import 'package:bykea_skardu/core/route/app_page.dart';
import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/core/theme/app_theme.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_bloc.dart';
import 'package:bykea_skardu/features/auth/data/auth_repository.dart';
import 'package:bykea_skardu/features/choose_role/presentation/bloc/role_bloc.dart';
import 'package:bykea_skardu/features/onboarding/presentation/bloc/Onboarding_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavBloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/splash/presentation/splash_screen.dart';
import 'package:bykea_skardu/features/theme/bloc/theme_bloc.dart';
import 'package:bykea_skardu/features/theme/bloc/theme_state.dart';
import 'package:bykea_skardu/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  final authRepository=AuthRepository(auth: auth, firestore: firestore);

  runApp(
   MultiBlocProvider(providers: [
     BlocProvider(create: (_)=>ThemeBloc()),
     BlocProvider(create: (_)=>OnboardingBloc()),
     BlocProvider(create: (_)=>AuthBloc(authRepository)),
     BlocProvider(create:(_)=>RoleBloc(authRepository)),
     BlocProvider(create: (_)=>PassegerBloc()),
     BlocProvider(create: (_)=>RiderBloc()),
     BlocProvider(create: (_)=>BottomNavBloc())
   ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(builder: (context,state){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
  title: 'Flutter Demo',
  themeMode: state.themeMode,
  darkTheme: AppTheme.darkTheme,
  theme:AppTheme.lightTheme,
  initialRoute: AppRoutes.splash,
  onGenerateRoute: AppPage().generateRoute,
  home: const SplashScreen(),
);
    });
  }
}

