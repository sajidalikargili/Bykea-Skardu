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
            return  ListView.separated(
              itemCount: state.stands.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.grey.shade200),
              itemBuilder: (_, index) {
                final stand = state.stands[index];

                return InkWell(
                  onTap: () {
                    context.read<PassegerBloc>().add(
                      SelectStandEvent(stand),
                    );
                    Navigator.pushNamed(
                      context,
                      AppRoutes.distination,
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
                                stand.standName,
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

                     Column(
                       children: [
                         CircleAvatar(
                           radius: 18,
                           backgroundColor: Colors.grey.withOpacity(0.2),
                             child: Center(child: Text(stand.riderCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 22),))),
                         Text('Riders',style: TextStyle(color: Colors.grey.shade600),)
                       ],
                     )
                      ],
                    ),
                  ),
                );
              },
            );

          }))
        ],
      ),
    );
  }
}
