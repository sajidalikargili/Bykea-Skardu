import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/auth/presentation/login/login_screen.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart'
    show RiderBloc;
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_home_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_stand_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RideCompletedScreen extends StatefulWidget {
  const RideCompletedScreen({super.key});

  @override
  State<RideCompletedScreen> createState() =>
      _RideCompletedScreenState();
}

class _RideCompletedScreenState
    extends State<RideCompletedScreen> {

  @override
  void initState() {
    super.initState();

    final ride = context.read<RiderBloc>().state.ride;

    if (ride != null) {
      context.read<RiderBloc>().add(
        LoadRideRatingEvent(
          ride.rideId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<RiderBloc, RiderState>(
      builder: (context, state) {

        final ride = state.ride;

        if (ride == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [

                  const Spacer(),

                  Container(
                    height: 110,
                    width: 110,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Ride Completed",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Divider(),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        "Fare",
                        style: TextStyle(fontSize: 18),
                      ),

                      Text(
                        "PKR ${ride.fare}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        "Earnings",
                        style: TextStyle(fontSize: 18),
                      ),

                      Text(
                        "PKR ${ride.fare}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 25),

                  const Divider(),

                  const SizedBox(height: 25),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Passenger Rating",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) {

                        return Icon(
                          Icons.star,
                          size: 34,
                          color: index <
                              (ride.passengerRating ?? 0)
                              ? Colors.green
                              : Colors.grey.shade300,
                        );

                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  if ((ride.passengerComment ?? "")
                      .isNotEmpty)

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: Text(
                        ride.passengerComment!,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {

                        context.read<RiderBloc>().add(
                          ClearCurrentRideEvent(),
                        );

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.riderHome,
                              (route) => false,
                        );

                      },
                      child: const Text(
                        "Complete",
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}