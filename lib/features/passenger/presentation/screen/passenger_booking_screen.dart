import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_booking_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerBookingScreen extends StatefulWidget {
  const PassengerBookingScreen({super.key});

  @override
  State<PassengerBookingScreen> createState() =>
      _PassengerBookingScreenState();
}

class _PassengerBookingScreenState
    extends State<PassengerBookingScreen> {

  @override
  void initState() {
    super.initState();

    context.read<PassegerBloc>().add(
      LoadPassengerBookingsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Bookings"),
      ),

      body: BlocBuilder<PassegerBloc, PassengerState>(
        builder: (context, state) {
          if (state.bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "No Bookings Yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Completed rides will appear here.",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.bookings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (_, index) {
              final ride = state.bookings[index];

              Color statusColor;

              switch (ride.status) {
                case "completed":
                  statusColor = Colors.green;
                  break;
                case "cancelled":
                  statusColor = Colors.red;
                  break;
                case "accepted":
                  statusColor = Colors.blue;
                  break;
                case "ongoing":
                  statusColor = Colors.orange;
                  break;
                default:
                  statusColor = Colors.grey;
              }

              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>PassengerBookingDetailScreen(
                        ride: ride,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.15),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      /// Status + Fare
                      Row(
                        children: [

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              ride.status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Spacer(),

                          Text(
                            "PKR ${ride.fare ?? '0'}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Column(
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Colors.green,
                              ),
                              Container(
                                width: 2,
                                height: 35,
                                color: Colors.grey.shade300,
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                            ],
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                const Text(
                                  "Pickup",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  ride.pickupStand,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  "Destination",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  ride.distination,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Divider(),

                      Row(
                        children: [

                          const Icon(
                            Icons.directions_bike,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            "View Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const Spacer(),

                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}