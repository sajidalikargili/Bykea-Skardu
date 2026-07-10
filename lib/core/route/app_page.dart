import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/choose_role/presentation/presentation/choose_role_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/about_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/privacy_policy_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/terms_condition_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/online_screen.dart';
import 'package:bykea_skardu/features/onboarding/presentation/onboarding_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/booking_confirmed_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/confirm_booking_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/distination_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_home_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/ride_detail_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_completed_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_bookings_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_home_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/settings_screeen.dart';
import 'package:bykea_skardu/features/splash/presentation/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/login/login_screen.dart';
import '../../features/auth/presentation/registration/registration_screen.dart';

class AppPage {
Route<dynamic> generateRoute(RouteSettings setting){
  switch(setting.name){
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (context){
        return SplashScreen();
      });
    case AppRoutes.onboarding:
      return MaterialPageRoute(builder: (context){
        return  OnboardingScreen();
      });
    case AppRoutes.register:
      return MaterialPageRoute(builder: (context){
        return RegisterScreen();
      });
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context){
        return LoginScreen();
      });
    case AppRoutes.chooseRole:
      return MaterialPageRoute(builder: (contex){
        return ChooseRoleScreen();
      });
    case AppRoutes.passengerHome:
      return MaterialPageRoute(builder: (context){
        return PassengerHomeScreen();
      });
    case AppRoutes.riderHome:
      return MaterialPageRoute(builder: (context){
        return RiderHomeScreen();
      });
    case AppRoutes.confirmBooking:
      return MaterialPageRoute(builder: (context){
        return ConfirmBookingScreen();
      });
    case AppRoutes.bookingConfirmed:
     return MaterialPageRoute(builder: (context){
       return BookingConfirmedScreen();
     });
    case AppRoutes.bookingConfirmed:
      return MaterialPageRoute(builder: (context){
        return BookingConfirmedScreen();
      });
    case AppRoutes.distination:
      return MaterialPageRoute(builder: (context){
        return DistinationScreen();
      });
    case AppRoutes.onlineScreen:
      return MaterialPageRoute(builder: (contex){
        return OnlineScreen();
      });
    case AppRoutes.rideAccepted:
      return MaterialPageRoute(builder: (context){
        return RideCompletedScreen();
      });
    case AppRoutes.rideCompleted:
      return MaterialPageRoute(builder: (context){
        return RideCompletedScreen();
      });
    case AppRoutes.rideDetails:
      return MaterialPageRoute(builder: (context){
        return RideDetailsScreen();
      });
    case AppRoutes.settings:
      return MaterialPageRoute(builder: (context){
        return SettingsScreen();
      });
    case AppRoutes.privacyPolicy:
      return MaterialPageRoute(builder: (context){
        return PrivacyPolicyScreen();
      });
    case AppRoutes.termsAndCondition:
      return  MaterialPageRoute(builder: (context){
        return TermsConditionScreen();
      });
    case AppRoutes.aboutApp:
      return MaterialPageRoute(builder: (context){
        return AboutScreen();
      });
    case AppRoutes.bookings:
      return MaterialPageRoute(builder: (context){
        return RiderBookingsScreen();
      });
   default:
     return MaterialPageRoute(builder: (context){
       return Center(
         child:Center(
           child:Text("Route donot found")
         ) ,
       );
     });
  }
}
}