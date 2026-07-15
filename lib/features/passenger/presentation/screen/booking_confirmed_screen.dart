import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_home_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_ride_complete_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingConfirmedScreen extends StatefulWidget {
  const BookingConfirmedScreen({super.key});

  @override
  State<BookingConfirmedScreen> createState() =>
      _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState
    extends State<BookingConfirmedScreen> {

  @override
  void initState() {
    super.initState();

    context.read<PassegerBloc>()
        .add(ListenRideEvent());
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
    return BlocListener<
        PassegerBloc,
        PassengerState>(
      listenWhen: (previous, current) => previous.ride?.status != current.ride?.status,
      listener: (context, state) {

        if(state.ride == null) return;

        switch(state.ride!.status){
          case "accepted":
            break;
          case "ongoing":
            Navigator.pushNamed(
              context,
              AppRoutes.rideDetails,
            );
            break;
          case "completed":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_)=>PassengerRideCompleteScreen(),
              ),
            );

            break;

          case "cancel":
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Ride Cancelled"),
              ),
            );

            Navigator.pop(context);

            break;
        }

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Booking Confirmed",
          ),
        ),
        body: BlocBuilder<
            PassegerBloc,
            PassengerState>(
          buildWhen: (previous, current) => previous.ride != current.ride,
          builder: (context, state) {
            print("BookingConfirmedScreen rebuild");
            final ride = state.ride;

            if (ride == null) {
              return const Center(
                child:Text('Donot booked any ride right now'),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  const SizedBox(height: 10),

                  /// Success Icon
                  Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Ride Booked!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Your ride has been booked\nsuccessfully.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Rider Card
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
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
                                    size: 16,
                                    color: Colors.orange,
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
                            onPressed: () {
                             _callRider(ride.riderPhone!);
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
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
                        flex: 2,
                        child: Text(
                          "From",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Text(
                          ride.pickupStand,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// Destination
                  Row(
                    children: [

                      const Expanded(
                        flex: 2,
                        child: Text(
                          "To",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Text(
                          ride.distination,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// Fare
                  Row(
                    children: [

                      const Expanded(
                        flex: 2,
                        child: Text(
                          "Fare (Est.)",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Text(
                          "PKR ${ride.fare}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  /// Call Rider Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Call Rider
                      },
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Call Rider",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.bookings,
                      );
                    },
                    child: const Text(
                      "View My Bookings",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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