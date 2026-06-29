import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart' show RiderBloc;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RideCompletedScreen extends StatelessWidget {
  const RideCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ride =
        context.watch<RiderBloc>().state.ride;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            const Text(
              "Ride Completed",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Fare: PKR ${ride?.fare ?? '0'}",
            ),

            Text(
              "Earnings: PKR ${ride?.fare ?? '0'}",
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

             Navigator.pushNamed(context,AppRoutes.rider);

              },
              child: const Text(
                "Back To Home",
              ),
            )
          ],
        ),
      ),
    );
  }
}