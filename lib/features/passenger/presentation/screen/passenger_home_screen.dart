import 'package:bykea_skardu/features/passenger/presentation/screen/booking_confirmed_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/load_stand_screen.dart';
import 'package:bykea_skardu/features/passenger/presentation/screen/passenger_ride_complete_screen.dart';
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
  BookingConfirmedScreen(),
  PassengerRideCompleteScreen()

];
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<BottomNavBloc,BottomNavState>(builder: (context,state){
      return Scaffold(

          bottomNavigationBar: BottomNavigationBar(
              currentIndex:state.selectedIndex ,
              onTap: (index){
                context.read<BottomNavBloc>().add(SelectedIndexEvent(index));
              },
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Rider Stand"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:  "booking Conform"),
                BottomNavigationBarItem(icon: Icon(Icons.home),label:"Ride Completed")
              ] ),
          body:screens[state.selectedIndex]
      );
    });;
  }
}
