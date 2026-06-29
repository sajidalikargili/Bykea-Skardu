import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_completed_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_progress_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RideAcceptedScreen extends StatelessWidget {
  const RideAcceptedScreen({super.key});

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

    return BlocListener<RiderBloc, RiderState>(
      listener: (context, state) {
        if (state.ride?.status == 'ongoing') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RideProgressScreen()
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ride Accepted"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Contact Passenger",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(passenger.name),
                subtitle: Text(passenger.phone),
                trailing: const Icon(Icons.call),
              ),

              const Divider(),

              ListTile(
                title: const Text("From"),
                subtitle: Text(ride.pickupStand),
              ),

              ListTile(
                title: const Text("To"),
                subtitle: Text(ride.distination),
              ),

              ListTile(
                title: const Text("Fare"),
                subtitle: Text("PKR ${ride.fare ?? '0'}"),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RiderBloc>().add(
                      StartRideEvent(ride),
                    );
                  },
                  child: const Text("Start Ride"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}