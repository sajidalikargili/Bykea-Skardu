import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_ride_complete_screen.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../rider/presentation/ride_completed_screen.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PassegerBloc, PassengerState>(
      listener: (context, state) {
        if (state.ride?.status == 'completed') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PassengerRideCompleteScreen(),
            ),
          );
        }
    },
      child: Scaffold(
        appBar: AppBar(title: const Text(" Passenger Ride Details")),
        body: BlocBuilder<PassegerBloc, PassengerState>(
          buildWhen: (previous, current) => previous.ride != current.ride,
          builder: (context, state) {
            print("BookingConfirmedScreen rebuild");
            final ride = state.ride;

            if (ride == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(ride?.status ?? "")],
                ),
                ListTile(
                  title: Text(ride?.riderName ?? ""),

                  subtitle: Text(ride?.riderPhone ?? ""),
                ),
                const Divider(),

                ListTile(
                  title: const Text("From"),
                  subtitle: Text(ride?.pickupStand ?? ""),
                ),

                ListTile(
                  title: const Text("To"),
                  subtitle: Text(ride?.distination ?? ""),
                ),

                ListTile(
                  title: const Text("Fare"),
                  subtitle: Text("PKR ${ride?.fare ?? ""}"),
                ),

                ListTile(
                  title: const Text("Booking ID"),
                  subtitle: Text(ride?.rideId ?? ""),
                ),

              ],
            );
          },
        ),
      ),

    );
  }
}
