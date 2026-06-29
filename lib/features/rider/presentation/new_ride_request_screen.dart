import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_accepted_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewRideRequestScreen extends StatefulWidget {
  const NewRideRequestScreen({super.key});

  @override
  State<NewRideRequestScreen> createState() => _NewRideRequestScreenState();
}

class _NewRideRequestScreenState extends State<NewRideRequestScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Expanded(
        child: BlocListener<RiderBloc, RiderState>(
      listener: (context, state) {
        if (state.ride != null && state.passenger != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RideAcceptedScreen(),
            ),
          );
        }
      },
          child: BlocBuilder<RiderBloc, RiderState>(
            builder: (context, state) {
              final rides = state.rides ?? [];

              print("UI rides: ${rides.length}");

              if (rides.isEmpty) {
                return const Center(
                  child: Text('No Ride Requests'),
                );
              }

              return ListView.builder(
                itemCount: rides.length,
                itemBuilder: (context, index) {
                  final ride = rides[index];

                  return Card(
                    child: ListTile(
                      title: Text(ride.pickupStand ?? ""),
                      subtitle: Text(ride.distination ?? ""),
                      trailing: TextButton.icon(onPressed: (){
                        context.read<RiderBloc>().add(AcceptRideEvent(ride));
                      }, label: Text("Accepted")),
                    ),
                  );
                },
              );
            },
          ),
      ),
          ),
        ],
      ),
    );
  }
}
