import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart' hide CancelRideEvent;
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RideProgressScreen extends StatefulWidget {
  const RideProgressScreen({super.key});

  @override
  State<RideProgressScreen> createState() => _RideProgressScreenState();
}

class _RideProgressScreenState extends State<RideProgressScreen> {
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
          child: Text("No ride in progress"),
        ),
      );
    }
    return BlocListener<RiderBloc, RiderState>(
      listener: (context, state) {
        print("status:${state.ride?.status}");
        if (state.ride?.status == 'completed') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RideCompletedScreen(),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            const SizedBox(height: 20),
        
            const Center(
              child: Text(
                "Ride In Progress",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        
            const SizedBox(height: 8),
        
        
        
            const SizedBox(height: 35),
        
            const Text(
              "From",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
        
            const SizedBox(height: 4),
        
            Text(
              ride.pickupStand,
              style: const TextStyle(
                fontSize: 18,
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
        
            const SizedBox(height: 4),
        
            Text(
              ride.distination,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            const SizedBox(height: 40),
        
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<RiderBloc>().add(
                    CancelRideEvent(ride),
                  );
                },
                child: const Text(
                  "Cancel Ride",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        
            const SizedBox(height: 15),
        
            /// Keep this only while testing.
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<RiderBloc>().add(
                    CompleteRideEvent(ride),
                  );
                },
                child: const Text(
                  "Ride Completed",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
            ),
        ),
      ),
    );
  }
}
