import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_home_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_ride_complete_screen.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../rider/presentation/ride_completed_screen.dart';

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({super.key});

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RiderBloc>().add(
      ListenCurrentRideEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    Future<void> _callRider(String phone) async {
      final Uri uri = Uri.parse("tel:$phone");

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint("Cannot launch: $uri");
      }
    }
    return BlocListener<PassegerBloc, PassengerState>(
      listenWhen: (previous, current) {
        return previous.ride?.status != current.ride?.status;
      },
      listener: (context, state) {

        if (state.ride == null) return;

        if (state.ride!.status == "completed") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const PassengerRideCompleteScreen(),
            ),
          );
        }

        if (state.ride!.status == "cancelled") {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Rider cancelled the ride"),
            ),
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.passengerHome,
                (route) => false,
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<PassegerBloc, PassengerState>(
          buildWhen: (previous, current) => previous.ride != current.ride,
          builder: (context, state) {
            print("BookingConfirmedScreen rebuild");
            final ride = state.ride;

            if (ride == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [

                  /// Green Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [

                        Text(
                          "On The Way",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Your rider is on the way",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [

                        /// Rider Card
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                              )
                            ],
                          ),
                          child: Row(
                            children: [

                              GestureDetector(
                                onTap: (){
                              _callRider(ride.riderPhone!);
                                },
                                child: const CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),

                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      ride.riderName ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    const Row(
                                      children: [

                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 15,
                                        ),

                                        SizedBox(width: 3),

                                        Text("4.8"),
                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    const Text(
                                      "Bike",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              CircleAvatar(
                                backgroundColor:
                                Colors.green.shade100,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    // Call Rider
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// From
                        Row(
                          children: [

                            const Expanded(
                              child: Text(
                                "From",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(
                                ride.pickupStand,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// To
                        Row(
                          children: [

                            const Expanded(
                              child: Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(
                                ride.distination,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// Fare
                        Row(
                          children: [

                            const Expanded(
                              child: Text(
                                "Fare (Est.)",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(
                                "PKR ${ride.fare}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(height: 15),



                        /// Cancel Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              context.read<PassegerBloc>().add(
                                CancelRidePassengerEvent(ride),
                              );
                            //  Navigator.pushNamed(context, AppRoutes.riderHome);
                            },
                            child: const Text(
                              "Cancel Ride",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        if (ride.status == "cancelled") ...[
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.passengerHome,
                                      (route) => false,
                                );
                              },
                              child: const Text("Back Home"),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}
