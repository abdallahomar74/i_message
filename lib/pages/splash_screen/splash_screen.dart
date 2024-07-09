import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/pages/splash_screen/cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initSplash(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToLogin) {
            Navigator.pushReplacementNamed(context, "login");
          }
          if (state is SplashNavigateToLayout) {
            Navigator.pushReplacementNamed(context, "home");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 100, right: 100, bottom: 100),
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
          );
        },
      ),
    );
  }
}
