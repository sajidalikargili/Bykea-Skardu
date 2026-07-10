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
      body:ListView.separated(
        itemCount:distinations.length,
        separatorBuilder: (_, __) =>
            Divider(color: Colors.grey.shade200),
        itemBuilder: (_, index) {
          final distination = distinations[index];

          return InkWell(
            onTap: () {
              context.read<PassegerBloc>().add(SelectDistinationEvent(distinations[index]));
              context.read<PassegerBloc>().add(CreateRideEvent());
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.confirmBooking,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Row(
                children: [

                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.storefront,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          distination,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Skardu",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),


                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 16,
                      child: Icon(Icons.arrow_forward))

                ],
              ),
            ),
          );
        },
      ));
  }
}
