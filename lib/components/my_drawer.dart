import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/pages/auth_screens/cubit/auth_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [ 
              Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 50),
            child: SizedBox(
                height: 70,
                width: 60,
                child: Image.asset("assets/images/logo2.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text("HOME",),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text("SETTINGS"),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pushNamed(context, "settings");
              },
            ),
          ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 10),
            child: ListTile(
              title: const Text("LOGOUT"),
              leading: const Icon(Icons.logout),
              onTap: () {
                 BlocProvider.of<AuthCubit>(context).signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
