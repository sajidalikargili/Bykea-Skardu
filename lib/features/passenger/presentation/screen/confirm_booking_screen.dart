import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  State<ConfirmBookingScreen> createState() =>
      _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState
    extends State<ConfirmBookingScreen> {
  final TextEditingController noteController =
  TextEditingController();
  Future<void> _callRider(String phone) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cannot open dialer"),
        ),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    context.read<PassegerBloc>().add(
      ListenRideEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Confirm Your Ride",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<PassegerBloc, PassengerState>(
        buildWhen: (previous, current) =>
        previous.ride != current.ride,
        builder: (context, state) {
          final ride = state.ride;

          if (ride == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Center(
                      child: Text(
                        "Confirm Your Ride",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// FROM
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade600,
                                ),
                              ),
                              Text(
                                ride.pickupStand,
                                style:
                                const TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                "Skardu",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// TO
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                "To",
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade600,
                                ),
                              ),
                              Text(
                                ride.distination,
                                style:
                                const TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Divider(
                      color:
                      Colors.grey.shade300,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Available Rider",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),
                if(ride.fare==null && ride.riderName==null && ride.riderPhone==null)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 15),
                          Text(
                            "Searching for nearby rider...",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) else
                    Column(
                      children: [
                        Row(
                          children: [

                            const CircleAvatar(
                              radius: 26,
                              child:
                              Icon(Icons.person),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    ride.riderName ??
                                        "Rider",
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 3),

                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors
                                            .orange,
                                      ),
                                      SizedBox(
                                          width: 4),
                                      Text("4.8"),
                                    ],
                                  ),

                                  const Text(
                                    "Bike",
                                    style:
                                    TextStyle(
                                      color:
                                      Colors
                                          .grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CircleAvatar(
                              backgroundColor:
                              Colors.green
                                  .shade100,
                              child: IconButton(
                                onPressed: () {
                                  _callRider(ride.riderPhone!);
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color:
                                  Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [

                            const Text(
                              "Fare (Est.)",
                              style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),

                            Text(
                              "PKR ${ride.fare}",
                              style:
                              const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width:
                          double.infinity,
                          height: 55,
                          child:
                          ElevatedButton(
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              Colors.green,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes
                                    .bookingConfirmed,
                              );
                            },
                            child:
                            const Text(
                              "Confirm Booking",
                              style:
                              TextStyle(
                                fontSize:
                                18,
                                color: Colors
                                    .white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}