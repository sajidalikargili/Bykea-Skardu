import 'package:bykea_skardu/core/route/app_routes.dart';
import 'package:bykea_skardu/features/theme/bloc/theme_bloc.dart';
import 'package:bykea_skardu/features/theme/bloc/theme_event.dart';
import 'package:bykea_skardu/features/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool darkMode = false;

  bool notification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(
        "Settings",
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [

                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return _settingTile(
                      icon: Icons.dark_mode,
                      title: "Dark Mode",
                      subtitle: "Enable dark theme",
                      trailing: Switch(
                        value: state.themeMode == ThemeMode.dark,
                        activeColor: Colors.green,
                        onChanged: (_) {
                          context.read<ThemeBloc>().add(
                            ThemeToggleEvent(),
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                _settingTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                  onTap: () {},
                ),

                const SizedBox(height: 15),

                _settingTile(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.privacyPolicy,
                    );
                  },
                ),

                const SizedBox(height: 15),

                _settingTile(
                  icon: Icons.article,
                  title: "Terms & Conditions",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.termsAndCondition,
                    );
                  },
                ),

                const SizedBox(height: 15),

                _settingTile(
                  icon: Icons.info,
                  title: "About App",
                  subtitle: "Version 1.0.0",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.aboutApp,
                    );
                  },
                ),

                const SizedBox(height: 15),

                _settingTile(
                  icon: Icons.share,
                  title: "Share App",
                  onTap: () {
                    Share.share(
                      "Download Bykea Skardu and book your ride easily!\nhttps://play.google.com/store/apps/details?id=com.example.bykea_skardu",
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
  }
}
Widget _settingTile({
  required IconData icon,
  required String title,
  String? subtitle,
  Widget? trailing,
  VoidCallback? onTap,
}) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    elevation: 2,
    shadowColor: Colors.black12,
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor:  Colors.green.withOpacity(.12),
        child: Icon(
          icon,
          color:  Colors.green,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey,
          ),
      onTap: onTap,
    ),
  );
}