import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_bottom_nav/passenger_bottom_nav_bloc.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_bottom_nav/passenger_bottom_nav_state.dart';
import 'package:bykea_skardu/features/passenger/presentation/bloc/passenger_bottom_nav/passsenger_bottom_nav_event.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/booking_confirmed_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/load_stand_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_booking_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_ride_complete_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/profile_passenger_screen.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavBloc.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavEvent.dart';
import 'package:bykea_skardu/features/rider/bloc/bottomNav/BottomNavState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
List<Widget> screens=[
  LoadStandScreen(),
  PassengerBookingScreen(),
  ProfilePassengerScreen()

];
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<PassengerBottomNavBloc,PassengerBottomNavState>(builder: (context,state){
      return Scaffold(

          bottomNavigationBar: BottomNavigationBar(
              currentIndex:state.selectedIndex ,
              onTap: (index){
                context.read<PassengerBottomNavBloc>().add(PassengerSelectedIndexEvent(index));
              },
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Rider Stand"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:  "bookings"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:"profile")
              ] ),
          body:screens[state.selectedIndex]
      );
    });;
  }
}
