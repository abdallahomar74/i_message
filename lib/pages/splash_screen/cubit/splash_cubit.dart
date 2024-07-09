import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  void initSplash() {
    // Listen to the authStateChanges stream

    Future.delayed(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          emit(SplashNavigateToLayout());
        } else {
          emit(SplashNavigateToLogin());
        }
      });
    });
  }
}
