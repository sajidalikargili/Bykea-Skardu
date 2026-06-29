import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/core/util/helper_method.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_bloc.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_event.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 TextEditingController nameController=TextEditingController();
 TextEditingController phoneController=TextEditingController();
 TextEditingController passwordController=TextEditingController();
  bool obscure = false;
  bool obscure2=false;
  bool isCheck=false;
 @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text("Join Bykea Skardu"),

              const SizedBox(height: 30),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),


              const SizedBox(height: 16),
             Row(
               children: [
                 Checkbox(value: isCheck, onChanged: (c){
                   setState(() {
                     isCheck=c ?? false;
                   });
                 }),
                 RichText(
                   text: TextSpan(
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 16,
                     ),
                     children: [
                       const TextSpan(
                         text: 'I agree to ',
                       ),
                       TextSpan(
                         text: 'Terms & Conditions',
                         style: const TextStyle(
                           color:Colors.green,
                           fontWeight: FontWeight.bold,
                         ),
                         recognizer: TapGestureRecognizer()
                           ..onTap = () {
                            // Navigator.pushNamed(context, AppRoutes.login);
                           },
                       ),


                     ],
                   ),
                 ),
               ],
             ),
              const SizedBox(height: 20),
            //   ElevatedButton(onPressed: () async{
            //     try {
            //       final user = UserModel(
            //         name: nameController.text.trim(),
            //         phone: passwordController.text.trim(),
            //       );
            // final currebId=FirebaseAuth.instance.currentUser!.uid;
            //       await FirebaseFirestore.instance
            //           .collection('users')
            //           .doc(currebId)
            //           .set(user.toJson());
            //     } catch (e) {
            //       print(e);
            //     }
            //   }, child: Text('Registration')),
              BlocConsumer<AuthBloc,AuthState>(listener: (context,state){
                if(state is AuthSuccess){
                  nameController.clear();
                  phoneController.clear();
                  passwordController.clear();
                  Navigator.pushNamed(context, AppRoutes.login);
                }
                if(state is AuthFailure){
                  print('firebaser:${state.message}');
                  HelperMethod.showMessage(state.message, context);
                }
              },builder: (context,state){
                return   SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: state is AuthLoading ? null :(){
                      context.read<AuthBloc>().add(RegisterEvent(nameController.text.trim(), phoneController.text.trim(),passwordController.text.trim()));
                    },
                    child:state is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text("Register"),
                  ),
                );
              }),


              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                      ),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                      Navigator.pushNamed(context, AppRoutes.login);
                          },
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}