import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/core/util/helper_method.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_bloc.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_event.dart';
import 'package:bykea_skardu/features/auth/bloc/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 TextEditingController phoneController=TextEditingController();
 TextEditingController passwordController=TextEditingController();
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
    child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),



                          const Text(

                            "Welcome Back",

                            style: TextStyle(

                              fontSize: 28,

                              fontWeight: FontWeight.bold,

                            ),

                          ),



                          const Text("Login to your account"),



                          const SizedBox(height: 40),



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

                            obscureText: hide,

                            decoration: InputDecoration(

                              hintText: "Password",

                              suffixIcon: IconButton(

                                icon: Icon(

                                  hide

                                      ? Icons.visibility_off

                                      : Icons.visibility,

                                ),

                                onPressed: () {

                                  setState(() {

                                    hide = !hide;

                                  });

                                },

                              ),

                              border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(12),

                              ),

                            ),

                          ),



                          Align(

                            alignment: Alignment.centerRight,

                            child: TextButton(

                              onPressed: () {

                                HelperMethod.showMessage("Forget Password", context);

                              },

                              child: const Text("Forgot Password?"),

                            ),

                          ),



                          const SizedBox(height: 20),

                          BlocConsumer<AuthBloc, AuthState>(

                            listener: (context, state) {

                              if (state is AuthSuccess) {

                                phoneController.clear();

                                passwordController.clear();



                                Navigator.pushReplacementNamed(

                                  context,

                                  AppRoutes.splash,

                                );

                              }



                              if (state is AuthFailure) {

                                HelperMethod.showMessage(

                                  state.message,

                                  context,

                                );

                              }

                            },

                            builder: (context, state) {

                              return SizedBox(

                                width: double.infinity,

                                height: 55,

                                child: ElevatedButton(

                                  onPressed: state is AuthLoading

                                      ? null

                                      : () {

                                    context.read<AuthBloc>().add(

                                      LoginEvent(

                                        phoneController.text.trim(),

                                        passwordController.text.trim(),

                                      ),

                                    );

                                  },

                                  child: state is AuthLoading

                                      ? const CircularProgressIndicator()

                                      : const Text("Login"),

                                ),

                              );

                            },

                          ),



                          const Spacer(),

                          Center(child: Text("Don't have an account?")),

                          Center(

                            child: TextButton(

                              onPressed: () {



                                Navigator.pushNamed(context,AppRoutes.register);

                              },

                              child: const Text("Register"),

                            ),

                          )
                        ],
                      ),
                  ),
              ),
          ),
      );
    },
    ),
    ),
    );
  }
}