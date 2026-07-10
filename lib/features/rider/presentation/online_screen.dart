import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_bloc.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OnlineScreen extends StatefulWidget {
  const OnlineScreen({super.key});

  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RiderBloc>().add(
      LoadRiderEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    final state=context.watch<RiderBloc>().state;
    final rider=context.watch<RiderBloc>().state.rider;
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             Expanded(child: Column(
               children: [
                 Text("your online"),
                 Text(
                   state.selectStand?.isNotEmpty == true
                       ? state.selectStand!
                       : rider?.stand ?? "",
                 ),
               ],
             )),
              ElevatedButton(
                onPressed: (){
                  context.read<RiderBloc>()
                      .add(
                    GoOffLineEvent(),
                  );
                  Navigator.pushNamed(context, AppRoutes.riderHome);
                },
                child: const Text(
                  'Go Offline',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){

                  Navigator.pushNamed(context, AppRoutes.riderHome);
                },
                child: const Text(
                  'Back to home',
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
