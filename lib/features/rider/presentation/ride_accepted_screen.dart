import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_completed_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_progress_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class RideAcceptedScreen extends StatefulWidget {
  const RideAcceptedScreen({super.key});

  @override
  State<RideAcceptedScreen> createState() => _RideAcceptedScreenState();
}

class _RideAcceptedScreenState extends State<RideAcceptedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RiderBloc>().add(
      ListenCurrentRideEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    final state = context
        .watch<RiderBloc>()
        .state;

    final passenger = state.passenger;
    final ride = state.ride;

    if (ride == null || passenger == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "There is no accepted ride yet.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
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
    return BlocListener<RiderBloc, RiderState>(
      listenWhen: (previous, current) {
        return previous.ride?.status != current.ride?.status;
      },
      listener: (context, state) {
        print("status accepted:${state.ride?.status}");
       // if (state.ride == null) return;
        if (state.ride?.status == 'ongoing') {
          print("Navigate Now");
          Navigator.pushNamedAndRemoveUntil(context,  AppRoutes.rideProgress, (route)=>false);
          // Navigator.pushReplacementNamed(
          //   context,
          //   AppRoutes.rideProgress,
          // );

        }
      },
      child: SafeArea(
        child: Scaffold(

          body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text(
                "Ride Accepted",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Contact Passenger",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),

            /// Passenger Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [

                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          passenger.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Row(
                          children: [

                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),

                            SizedBox(width: 4),

                            Text("4.8"),

                          ],
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          "Passenger",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.green.shade100,
                    child: IconButton(
                      icon: const Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print("rider accepted :${ride.riderPhone!}");
                       _callRider(passenger.phone);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Divider(),

            const SizedBox(height: 20),

            const Text(
              "From",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              ride.pickupStand,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "To",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              ride.distination,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  "Fare (Est.)",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                Text(
                  "PKR ${ride.fare}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Spacer(),
            if (state.ride?.status == 'conform Booking' || state.ride?.status=='ongoing')
        SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            context.read<RiderBloc>().add(
              StartRideEvent(ride),
            );
          },
          child: const Text(
            "Start Ride",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      )
      else
        Center(child: CircularProgressIndicator()),
            const SizedBox(height: 20),
          ],
        ),
            ),
        ),
      ),
    );
  }
}