import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/conf/theme/dark_mode.dart';
import 'package:i_message/conf/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode",style: TextStyle(color: Colors.white),),
              BlocBuilder<ThemeCubit, ThemeData>(
                builder: (context, theme) {
                  bool isDarkMode = theme == darkMode;
                  return CupertinoSwitch(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}
