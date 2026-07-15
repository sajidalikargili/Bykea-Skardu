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

    return Scaffold(
      body: state.isOnline
          ? _onlineWidget(context, state)
          : _offlineWidget(context, state),
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
    return SingleChildScrollView(
      child: Column(
        children: [

          /// Header
          Stack(
            clipBehavior: Clip.none,
            children: [

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 120),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.green,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.18),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Icon(
                            Icons.circle,
                            color: Colors.greenAccent,
                            size: 12,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "ONLINE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Ready to Receive Rides",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            state.selectStand ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    Image.asset(
                      AppAssets.bgOne,
                      height: 160,
                    ),
                  ],
                ),
              ),

              Positioned(
                left: 20,
                right: 20,
                bottom: -55,
                child: BlocBuilder<RiderBloc, RiderState>(
                  builder: (context, state) {
                    return Row(
                      children: [

                        Expanded(
                          child: _statCard(
                            icon: Icons.attach_money,
                            title: "Today's Earnings",
                            value: "PKR ${state.totalEarnings}",
                            color: Colors.orange,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: _statCard(
                            icon: Icons.motorcycle,
                            title: "Total Rides",
                            value: state.totalRides.toString(),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 90),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  context.read<RiderBloc>().add(
                    GoOffLineEvent(),
                  );
                },
                icon: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                label: const Text(
                  "Go Offline",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}