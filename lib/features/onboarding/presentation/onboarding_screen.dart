import 'package:bykea_skardu/core/constant/app_assets.dart';
import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/onboarding/presentation/bloc/Onboarding_bloc.dart';
import 'package:bykea_skardu/features/onboarding/presentation/bloc/onBoarding_event.dart';
import 'package:bykea_skardu/features/onboarding/presentation/bloc/onBoarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppAssets.bgOne,
      "title": "Stand Based Booking",
      "desc": "Book rides easily from your nearest stand",
    },
    {
      "image":AppAssets.bgTwo,
      "title": "Fast Pickup",
      "desc": "Get picked up quickly without waiting",
    },
    {
      "image": AppAssets.bgThree,
      "title": "Safe Travel",
      "desc": "Travel safely with trusted drivers",
    },
  ];

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to next screen
      Navigator.pushNamed(context,AppRoutes.register);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<OnboardingBloc,OnboardingState>(builder: (context,state){
          if(state is ChangePageState){
            currentPage=state.currentPage;
          }
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) {
                    context.read<OnboardingBloc>().add(ChangPageEvent(index));
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Spacer(),

                          Image.asset(
                            onboardingData[index]["image"]!,
                            height: 220,
                          ),

                          const SizedBox(height: 40),

                          Text(
                            onboardingData[index]["title"]!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            onboardingData[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onboardingData.length,
                                  (i) => dot(i == currentPage),
                            ),
                          ),

                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context,AppRoutes.register);
                        },
                        child: const Text("Skip"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: nextPage,
                        child: Text(
                          currentPage == onboardingData.length - 1
                              ? "Get Started"
                              : "Next",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 10 : 8,
      height: active ? 10 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
