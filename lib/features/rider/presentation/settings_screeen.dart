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

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(

        children: [

          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                subtitle: const Text("Enable Dark Theme"),
                value: state.themeMode == ThemeMode.dark,
                onChanged: (_) {
                  context.read<ThemeBloc>().add(
                    ThemeToggleEvent(),
                  );
                },
              );
            },
          ),

          const Divider(),


          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("English"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {

            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
               Navigator.pushNamed(context, AppRoutes.privacyPolicy);
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.article),
            title: const Text("Terms & Conditions"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context,AppRoutes.termsAndCondition);
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About App"),
            subtitle: const Text("Version 1.0.0"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
               Navigator.pushNamed(context, AppRoutes.aboutApp);

            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share App"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Share.share(
                "Download Bykea Skardu and book your ride easily!\nhttps://play.google.com/store/apps/details?id=com.example.bykea_skardu",
              );
            },
          ),

        ],
      ),
    );
  }
}