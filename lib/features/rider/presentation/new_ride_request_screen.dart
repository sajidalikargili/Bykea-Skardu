import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_accepted_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewRideRequestScreen extends StatefulWidget {
  const NewRideRequestScreen({super.key});

  @override
  State<NewRideRequestScreen> createState() =>
      _NewRideRequestScreenState();
}

class _NewRideRequestScreenState
    extends State<NewRideRequestScreen> {

  @override
  void initState() {
    super.initState();

    final stand =
        context.read<RiderBloc>().state.selectStand;

    if (stand != null && stand.isNotEmpty) {
      context.read<RiderBloc>().add(
        LoadRideRequestsEvent(stand),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<RiderBloc, RiderState>(
      listener: (context, state) {

        if (state.ride != null &&
            state.passenger != null) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const RideAcceptedScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text(
            "New Ride Requests",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: BlocBuilder<RiderBloc, RiderState>(
          builder: (context, state) {

            final rides = state.rides;

            if (rides.isEmpty) {
              return const Center(
                child: Text(
                  "No Ride Requests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rides.length,
              itemBuilder: (context, index) {

                final ride = rides[index];

                return Container(
                  margin:
                  const EdgeInsets.only(bottom: 20),

                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),

                  child: Column(
                    children: [

                      /// GREEN HEADER
                      Container(
                        width: double.infinity,
                        padding:
                        const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                          BorderRadius.only(
                            topLeft:
                            Radius.circular(22),
                            topRight:
                            Radius.circular(22),
                          ),
                        ),

                        child: const Column(
                          children: [

                            Text(
                              "New Ride Request",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "10 sec left",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// WHITE BODY
                      Container(
                        width: double.infinity,
                        padding:
                        const EdgeInsets.all(20),

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.only(
                            bottomLeft:
                            Radius.circular(22),
                            bottomRight:
                            Radius.circular(22),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              "From",
                              style: TextStyle(
                                color:
                                Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Row(
                              children: [

                                const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 20,
                                ),

                                const SizedBox(width: 6),

                                Expanded(
                                  child: Text(
                                    ride.pickupStand,
                                    style:
                                    const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 2),

                            const Padding(
                              padding:
                              EdgeInsets.only(
                                  left: 28),
                              child: Text(
                                "Skardu",
                                style: TextStyle(
                                  color:
                                  Colors.grey,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "To",
                              style: TextStyle(
                                color:
                                Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Row(
                              children: [

                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 20,
                                ),

                                const SizedBox(width: 6),

                                Expanded(
                                  child: Text(
                                    ride.distination,
                                    style:
                                    const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [

                                const Text(
                                  "Fare (Est.)",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),

                                Text(
                                  "PKR ${ride.fare ?? "200"}",
                                  style:
                                  const TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            Row(
                              children: [

                                Expanded(
                                  child: ElevatedButton(
                                    style:
                                    ElevatedButton
                                        .styleFrom(
                                      backgroundColor:
                                      Colors.red,
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10),
                                      ),
                                    ),

                                    onPressed: () {

                                      context
                                          .read<
                                          RiderBloc>()
                                          .add(
                                        DeclineRideEvent(
                                            ride),
                                      );
                                    },

                                    child: const Text(
                                      "Decline",
                                      style:
                                      TextStyle(
                                        color: Colors
                                            .white,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 15),

                                Expanded(
                                  child: ElevatedButton(
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
                                            10),
                                      ),
                                    ),

                                    onPressed: () {

                                      context
                                          .read<
                                          RiderBloc>()
                                          .add(
                                        AcceptRideEvent(
                                            ride),
                                      );
                                    },

                                    child: const Text(
                                      "Accept",
                                      style:
                                      TextStyle(
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
                      )

                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}