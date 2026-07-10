import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerRideCompleteScreen extends StatefulWidget {
  const PassengerRideCompleteScreen({super.key});

  @override
  State<PassengerRideCompleteScreen> createState() =>
      _PassengerRideCompleteScreenState();
}

class _PassengerRideCompleteScreenState
    extends State<PassengerRideCompleteScreen> {

  int selectedRating = 5;

  final TextEditingController commentController =
  TextEditingController(
    text: "Great ride!",
  );

  @override
  Widget build(BuildContext context) {
    final ride = context.watch<PassegerBloc>().state.ride;

    if (ride == null) {
      return const Scaffold(
        body: Center(
          child: Text("No completed ride found."),
        ),
      );
    }
 return   BlocListener<PassegerBloc, PassengerState>(
      listener: (context, state) {
      print("raring here:${state.ratingSubmitted}");
        if (state.ratingSubmitted) {
           commentController.clear();
           context.read<PassegerBloc>().add(ResetRatingEvent());
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.passengerHome,
                (route) => false,
          );

        }

      },

      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 18),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [

                    const SizedBox(height: 10),

                    Container(
                      height: 95,
                      width: 95,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Ride Completed",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Thank you for riding with Bykea!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 35),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        const Text(
                          "Fare",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),

                        Text(
                          "PKR ${ride.fare}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Paid",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),

                        Text(
                          "Cash",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Rate your ride",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    BlocBuilder<PassegerBloc, PassengerState>(
                      builder: (context, state) {

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                                (index) {
                              return IconButton(
                                onPressed: () {
                                  context.read<PassegerBloc>().add(
                                      ChangeRatingEvent(index: index+1)
                                  );
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 38,
                                  color: index < state.selectedRating
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                        "Write a comment (optional)",
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.green,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),
                        ),
                        onPressed: () {
                          context.read<PassegerBloc>().add(

                            SubmitRideRatingEvent(

                              rideId: ride.rideId,

                              rating: context.read<PassegerBloc>().state.selectedRating,

                              comment: commentController.text,

                            ),

                          );
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}