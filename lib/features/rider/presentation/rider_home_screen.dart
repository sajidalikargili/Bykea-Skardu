import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/choose_role/presentation/presentation/online_screen.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavBloc.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavEvent.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavState.dart';
import 'package:bykea_skardu/features/rider/bloc/rider/rider_bloc.dart';
import 'package:bykea_skardu/features/rider/presentation/new_ride_request_screen.dart';
import 'package:bykea_skardu/features/rider/presentation/ride_accepted_screen.dart';
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
  Widget build(BuildContext context) {
    List<Widget> screens=[
      RiderStandScreen(),
     NewRideRequestScreen(),
      RideAcceptedScreen(),
    ];
    return BlocBuilder<BottomNavBloc,BottomNavState>(builder: (context,state){
      return Scaffold(
          appBar: AppBar(title: Text('Select your Stand'),),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex:state.selectedIndex ,
              onTap: (index){
                context.read<BottomNavBloc>().add(SelectedIndexEvent(index));
              },
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Rider Stand"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:  "New Request"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:"Ride Accepted")
              ] ),
          body:screens[state.selectedIndex]
      );
    });
  }
}
