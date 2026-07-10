import 'package:bykea_skardu/core/constant/app_assets.dart';
import 'package:bykea_skardu/core/util/helper_method.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../passenger/presentation/bloc/passenger_event.dart' hide SelectStandEvent;
import '../bloc/rider/rider_bloc.dart';

class RiderStandScreen extends StatefulWidget {
  RiderStandScreen({super.key});

  @override
  State<RiderStandScreen> createState() => _RiderStandScreenState();
}

class _RiderStandScreenState extends State<RiderStandScreen> {

  final List<String> stands = [
    "Road Bazar",
    "Hussainabad",
    "Airport Stand",
    "College Road",
    "Main Market",
  ];
  @override
  void initState() {
    // TODO: implement initState
    context.read<RiderBloc>().add(
      LoadEarningsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RiderBloc>().state;

    return SafeArea(
      child: Scaffold(
        body: state.isOnline
            ? _onlineWidget(context, state)
            : _offlineWidget(context, state),
      ),
    );
  }

  Widget _offlineWidget(
      BuildContext context,
      RiderState state,
      ) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Heading
              const Text(
                "Select Your Stand",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Choose where you are available",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: stands.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade200),
                  itemBuilder: (_, index) {

                    final stand = stands[index];

                    return InkWell(
                      onTap: () {
                        context.read<RiderBloc>().add(
                          SelectStandEvent(stand),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
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
                                    stand,
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

                            Radio<String>(
                              value: stand,
                              groupValue: state.selectStand,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                context.read<RiderBloc>().add(
                                  SelectStandEvent(value!),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {

                    if (state.selectStand == null ||
                        state.selectStand!.isEmpty) {
                      HelperMethod.showMessage(
                        "Please select stand",
                        context,
                      );
                      return;
                    }

                    context.read<RiderBloc>().add(
                      GoOnlineEvent(),
                    );

                    context.read<RiderBloc>().add(
                      LoadRideRequestsEvent(
                        state.selectStand!,
                      ),
                    );
                  },
                  child: const Text(
                    "Save & Go Online",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _onlineWidget(
      BuildContext context,
      RiderState state,
      ) {
    return Column(
      children: [

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [

              const Text(
                "You are Online",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                state.selectStand ?? "",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                AppAssets.bgOne,
                height: 150,
                width: double.infinity,
              ),
              Transform.translate( offset: const Offset(0, 70),child: Column(
                children: [
                  BlocBuilder<RiderBloc,RiderState>(builder: (context,state){
                    return Row(
                      children: [
                        Expanded(
                          child: _infoCard(
                            "Riders Available",
                            state.totalEarnings.toString(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _infoCard(
                            "Riders Available",
                            state.totalRides.toString(),
                          ),
                        ),
                      ],
                    );
                  }),

                ],
              ),)
            ],
          ),
        ),

        const SizedBox(height: 80),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {

              context.read<RiderBloc>().add(
                GoOffLineEvent(),
              );

            },
            child: const Text("Go Offline"),
          ),
        )
      ],
    );
  }
}
Widget _infoCard(String title, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 20,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.grey.shade300,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
        ),
      ],
    ),
    child: Column(
      children: [

        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}