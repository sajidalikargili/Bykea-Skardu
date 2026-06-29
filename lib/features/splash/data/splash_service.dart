import 'package:bykea_skardu/core/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/route/app_routes.dart';
import '../../auth/data/user_model.dart';

class SplashService {
  static void navigate(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 3), () async {
      if (currentUser == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
        return;
      }
      final data = await FirebaseService.getCurrentUser();
      print('data role:${data?.role}');
      if (data == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
        return;
      }

      if (data.role?.toLowerCase() == 'passenger') {
        Navigator.pushReplacementNamed(context, AppRoutes.passenger);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.rider);
      }
    });
  }
}