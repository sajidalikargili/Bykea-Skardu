import 'package:bykea_skardu/core/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/route/app_routes.dart';
class SplashService {
  static Future<void> navigate(BuildContext context) async {

    await Future.delayed(const Duration(seconds: 2));

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
      return;
    }

    final user = await FirebaseService.getCurrentUser();

    if (user == null) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
      return;
    }

    if (user.role == null || user.role!.isEmpty) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.chooseRole,
      );
      return;
    }

    if (user.role == "passenger") {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.passengerHome,
      );
      return;
    }

    if (user.role == "rider") {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.riderHome,
      );
      // if (user.isOnline) {
      //   Navigator.pushReplacementNamed(
      //     context,
      //     AppRoutes.onlineScreen,
      //   );
      // } else {
      //
      // }

      return;
    }

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.onboarding,
    );
  }
  // static void navigate(BuildContext context) async {
  //   print("SplashService started");
  //
  //   final data = await FirebaseService.getCurrentUser();
  //
  //   print("Data: $data");
  //
  //   if (data == null) {
  //     print("Go to onboarding");
  //     Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  //     return;
  //   }
  //
  //   print("Role = ${data.role}");
  //   print("isOnline = ${data.isOnline}");
  //
  //   if (data.role == null || data.role!.isEmpty) {
  //     print("Go to chooseRole");
  //     Navigator.pushReplacementNamed(context, AppRoutes.chooseRole);
  //     return;
  //   }
  //
  //   if (data.role == 'passenger') {
  //     print("Go to passenger");
  //     Navigator.pushReplacementNamed(context, AppRoutes.passenger);
  //     return;
  //   }
  //
  //   if (data.role == 'rider') {
  //     print("Rider found");
  //
  //     if (data.isOnline) {
  //       print("Go to onlineScreen");
  //       Navigator.pushReplacementNamed(context, AppRoutes.onlineScreen);
  //     } else {
  //       print("Go to rider");
  //       Navigator.pushReplacementNamed(context, AppRoutes.rider);
  //     }
  //   }
  //
  //   print("End of navigate()");
  // }
}