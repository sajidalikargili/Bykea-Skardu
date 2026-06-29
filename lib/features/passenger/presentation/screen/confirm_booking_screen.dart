import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}
class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<PassegerBloc>().add(ListenRideEvent());
  }
  @override
  Widget build(BuildContext context) {
    final state=context.watch<PassegerBloc>().state;
    return BlocListener<PassegerBloc,PassengerState>(
      listener: ( context, state) {
          if(state.rideCreated){

          }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Confirm Booking'),),
        body: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(state.standName?.standName ?? ''),
                  Text(state?.distinationName ?? ''),
                ],
              ),
            )),
         Expanded(child: BlocBuilder<
             PassegerBloc,
             PassengerState>(
           buildWhen: (previous, current) => previous.ride != current.ride,
           builder: (context, state) {
             print("BookingConfirmedScreen rebuild");
             final ride = state.ride;

             if (ride == null) {
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }

             return Column(
               children: [
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
                   Navigator.pushNamed(context, AppRoutes.bookingConfirmed);
                 }, child: Text("Conform Booking"))
               ],
             );
           },
         ))

          ],
        ),
      ),
    );
  }
}
