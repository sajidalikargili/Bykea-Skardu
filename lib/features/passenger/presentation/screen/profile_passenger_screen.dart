import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_bloc.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passeger_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_state.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePassengerScreen extends StatefulWidget {
  const ProfilePassengerScreen({super.key});

  @override
  State<ProfilePassengerScreen> createState() => _ProfilePassengerScreenState();
}

class _ProfilePassengerScreenState extends State<ProfilePassengerScreen> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PassegerBloc>().add(LoadPassengerEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocBuilder<PassegerBloc, PassengerState>(
          builder: (context, state) {
            final passenger = state.passenger;

            if (passenger == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [

                  ///================ HEADER =================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 35,
                      bottom: 30,
                    ),
                    decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Color(0xff0E9F6E),
                      //     Color(0xff34D399),
                      //   ],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [

                        const Text(
                          "Passenger Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),

                        const SizedBox(height: 25),

                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.green.shade700,
                            size: 60,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          passenger.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          passenger.phone,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Icon(
                                Icons.circle,
                                size: 12,
                                color: Colors.green),

                              const SizedBox(width: 8),

                              Text("Online", style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),

                        _menuTile(
                          icon: Icons.history,
                          title: "My Bookings",
                          color: Colors.blue,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.bookings,
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        _menuTile(
                          icon: Icons.settings,
                          title: "Settings",
                          color: Colors.orange,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.settings,
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        _menuTile(
                          icon: Icons.info_outline,
                          title: "About Application",
                          color: Colors.purple,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.aboutApp,
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        _menuTile(
                          icon: Icons.logout,
                          title: "Logout",
                          color: Colors.red,
                          onTap: () {

                            context.read<AuthBloc>().add(
                              logOutEvent(),
                            );

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.login,
                                  (route) => false,
                            );
                          },
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ///================ MENU TILE =================
  Widget _menuTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(18),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: color.withOpacity(.15),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }

  ///================ STAT CARD =================
  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [

          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}