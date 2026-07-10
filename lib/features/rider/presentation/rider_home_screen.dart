import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/rider/presentation/earning_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/online_screen.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavBloc.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavEvent.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavState.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_event.dart';
import 'package:bykea_skardu/features/rider/presentation/new_ride_request_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/profile_rider_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_accepted_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_earning_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_bookings_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/rider_stand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});
  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
 @override
  void initState() {
    super.initState();
    context.read<RiderBloc>().add(
      LoadRiderEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> screens=[
       RiderStandScreen(),
       NewRideRequestScreen(),
       RiderBookingsScreen(),
       RideEarningScreen(),
       ProfileRiderScreen()
    ];
    return BlocBuilder<BottomNavBloc,BottomNavState>(builder: (context,state){
      print("Selected Index: ${state.selectedIndex}");
      print("Items Length: ${screens.length}");
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:state.selectedIndex ,
              onTap: (index){
                context.read<BottomNavBloc>().add(SelectedIndexEvent(index));
              },
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:  "New Request"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:"bookings"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label:"Earning"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile"),
              ] ),
          body:screens[state.selectedIndex]
      );
    });
  }
}
