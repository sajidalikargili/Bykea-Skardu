import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadStandScreen extends StatefulWidget {
  const LoadStandScreen({super.key});

  @override
  State<LoadStandScreen> createState() => _LoadStandScreenState();
}

class _LoadStandScreenState extends State<LoadStandScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PassegerBloc>().add(LoadStandEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select your Stand')),
      body:Column(
        children: [
          Expanded(child: BlocBuilder<PassegerBloc,PassengerState>(builder: (context,state){
            print("Stand Count: ${state.stands.length}");
            return ListView.builder(
              itemCount: state.stands.length,
              itemBuilder: (context, index) {
                final stand = state.stands[index];

                return ListTile(
                  title: Text(stand.standName),
                  trailing: Text("${stand.riderCount} Riders"),
                  onTap: () {
                    context.read<PassegerBloc>().add(
                      SelectStandEvent(stand),
                    );

                    Navigator.pushNamed(
                      context,
                      AppRoutes.distination,
                    );
                  },
                );
              },
            );

          }))
        ],
      ),
    );
  }
}
