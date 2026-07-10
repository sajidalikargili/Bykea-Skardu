import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RideEarningScreen extends StatefulWidget {
  const RideEarningScreen({super.key});

  @override
  State<RideEarningScreen> createState() => _RideEarningScreenState();
}

class _RideEarningScreenState extends State<RideEarningScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RiderBloc>().add(
      LoadEarningsEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: BlocBuilder<RiderBloc, RiderState>(
        builder: (context, state) {
      
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Performance Summary",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 20),

                      buildRow(
                        Icons.directions_bike,
                        "Total Rides",
                        state.totalRides.toString(),
                        Colors.blue,
                      ),

                      buildRow(
                        Icons.check_circle,
                        "Completed",
                        state.completedRides.toString(),
                        Colors.green,
                      ),

                      buildRow(
                        Icons.cancel,
                        "Cancelled",
                        state.cancelledRides.toString(),
                        Colors.red,
                      ),

                      buildRow(
                        Icons.account_balance_wallet,
                        "Earnings",
                        "PKR ${state.totalEarnings}",
                        Colors.orange,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),


                const Text(
                  "Completion Rate",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                LinearProgressIndicator(
                  value: state.totalRides == 0
                      ? 0
                      : state.completedRides / state.totalRides,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: Colors.grey.shade300,
                  valueColor:
                  const AlwaysStoppedAnimation(
                    Color(0xff0E9F6E),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "${((state.completedRides / (state.totalRides == 0 ? 1 : state.totalRides)) * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
Widget buildRow(
    IconData icon,
    String title,
    String value,
    Color color,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
    ),
    child: Row(
      children: [

        CircleAvatar(
          radius: 20,
          backgroundColor: color.withOpacity(.15),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}