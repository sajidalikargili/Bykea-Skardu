import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocListener<
        PassegerBloc,
        PassengerState>(
      listenWhen: (previous, current) => previous.ride?.status != current.ride?.status,
      listener: (context, state) {

        // if (state.ride?.status == 'accepted') {
        //   Future.delayed(Duration(seconds: 3),(){
        //
        //   });
        //
        // }

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

            return Column(
              children: [

                const SizedBox(height: 50),

                Text(
                  ride.pickupStand,
                ),

                const SizedBox(height: 10),

                Text(
                  ride.distination,
                ),

                const SizedBox(height: 10),

                Text(
                  ride.status,
                ),

                Text(
                  ride.riderPhone.toString(),
                ),
                Text(
                  ride.riderName.toString(),
                ),
                Text(
                  ride.fare.toString(),
                ),

                const SizedBox(height: 10),
                ElevatedButton(onPressed: (){

                }, child: Text("Call Rider")),
                TextButton(onPressed: (){
                  Navigator.pushNamed(
                    context,
                    AppRoutes.rideDetails,
                  );
                }, child: Text('Check the detail Ride'))
              ],
            );
          },
        ),
      ),
    );
  }
}