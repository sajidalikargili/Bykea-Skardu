import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistinationScreen extends StatefulWidget {
  const DistinationScreen({super.key});

  @override
  State<DistinationScreen> createState() => _DistinationScreenState();
}

class _DistinationScreenState extends State<DistinationScreen> {
  final distinations=[
    'Airport',
    'Road Bazar',
    'College Road',
    'Hussainabad',
    'Ali Abad',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select the Distination"),),
      body: ListView.builder(
          itemCount: distinations.length,
          itemBuilder: (context,index){
            return ListTile(title:Text(distinations[index],),onTap:(){
              context.read<PassegerBloc>().add(SelectDistinationEvent(distinations[index]));
              context.read<PassegerBloc>().add(CreateRideEvent());
              Navigator.pushNamed(context, AppRoutes.confirmBooking);
            },);
          })
    );
  }
}
