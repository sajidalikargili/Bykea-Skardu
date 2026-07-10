import 'package:bykea_skardu/core/constant/app_assets.dart';
import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/core/util/helper_method.dart';
import 'package:bykea_skardu/features/choose_role/presentation/bloc/role_bloc.dart';
import 'package:bykea_skardu/features/choose_role/presentation/bloc/role_event.dart';
import 'package:bykea_skardu/features/choose_role/presentation/bloc/role_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("built screen");
    return Scaffold(
      appBar:  AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Choose Your Role",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Select how you want to use Bykea Skardu",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),


            BlocConsumer<RoleBloc,RoleState>(listener: (context,state){
              if(state is RoleSuccess ){
                if (state.role == "passenger") {
                  Navigator.pushNamed(context, AppRoutes.passengerHome);
                } else {
                  Navigator.pushNamed(context, AppRoutes.riderHome);
                }
              }
              if(state is RoleFailure){
                HelperMethod.showMessage(state.message, context);
              }
            }, builder: (contex,state){

              return  Column(
                children: [

                  roleCard(
                  image: AppAssets.passenger,
                  title: "I am a Passenger",
                  subtitle: "Book a ride",
                  trailing: state is RoleLoading && state.role=="passenger" ? SizedBox(
                    height: 25,
                      width: 25,
                      child: CircularProgressIndicator(strokeWidth: 2)) :CircleAvatar(child:Icon(Icons.arrow_forward_ios)),
                  onTap:  state is RoleLoading
                      ? null
                      : () {
                    final uid =
                        FirebaseAuth.instance.currentUser!.uid;

                    context.read<RoleBloc>().add(
                      SelectRoleEvent(uid, "passenger"),
                    );
                  },
              ),
                  const SizedBox(height: 20),
                  roleCard(

                  image:AppAssets.rider,
                  title: "I am a Rider",
                  subtitle: "Provide bike rides",
              trailing: state is RoleLoading && state.role=="rider" ? SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(strokeWidth: 2)) :CircleAvatar(child:Icon(Icons.arrow_forward_ios)),
                  onTap: state is  RoleLoading ? null :(){
                    final uid=FirebaseAuth.instance.currentUser!.uid;
                    print("rider uid :${uid}");
                    context.read<RoleBloc>().add(SelectRoleEvent(uid, "rider"));
                  }
              ),
                ],
              );
            }),

          ],
        ),
      ),
    );
  }

  Widget roleCard({
    required String image,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback? onTap
  }) {
    return GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    image,
                    height: 80,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(subtitle),
                ],
              ),
            ),
         trailing ?? const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_forward_ios,color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}