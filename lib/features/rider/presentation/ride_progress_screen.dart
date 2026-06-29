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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ride Progress Screen"),
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
                title: Text(passenger!.name),
                subtitle: Text(passenger!.phone),
                trailing: const Icon(Icons.call),
              ),

              const Divider(),

              ListTile(
                title: const Text("From"),
                subtitle: Text(ride!.pickupStand),
              ),

              ListTile(
                title: const Text("To"),
                subtitle: Text(ride.distination),
              ),

              ListTile(
                title: const Text("Fare"),
                subtitle: Text("PKR ${ride.fare ?? '0'}"),
              ),
              ListTile(
                title: const Text("status"),
                subtitle: Text(" ${ride.status ?? ''}"),
              ),
              ElevatedButton(onPressed: (){
                print("status:${state.ride?.status}");
                context.read<RiderBloc>().add(CompleteRideEvent(ride));
              }, child: Text("Ride Completed"))

            ],
          ),
        ),
      ),
    );
  }
}
