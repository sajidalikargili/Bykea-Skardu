import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiderStandScreen extends StatefulWidget {
  const RiderStandScreen({super.key});

  @override
  State<RiderStandScreen> createState() => _RiderStandScreenState();
}

class _RiderStandScreenState extends State<RiderStandScreen> {
  List<String> stands=[
    'Road Bazar',
    'Hussainabad',
    'Airport Stand',
    'College Road',
    'Main Market',
  ];
  @override
  Widget build(BuildContext context) {
    final state=context.watch<RiderBloc>().state;
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: stands.length,
            itemBuilder: (context,index){

              return RadioListTile(
                value: stands[index],
                groupValue:
                state.selectStand,
                title: Text(stands[index]),
                onChanged: (value){

                  context.read<RiderBloc>()
                      .add(
                      SelectStandEvent(value?? ""));
                },
              );
            },
          )),
          ElevatedButton(onPressed: (){
            context.read<RiderBloc>().add(
              GoOnlineEvent(),
            );

            context.read<RiderBloc>().add(
              LoadRideRequestsEvent(
                state.selectStand ?? "",
              ),
            );

            Navigator.pushNamed(
              context,
              AppRoutes.onlineScreen,
            );
          }, child: Text("goOnline"))
        ],
      ),
    );
  }
}
