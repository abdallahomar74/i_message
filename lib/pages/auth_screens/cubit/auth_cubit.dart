import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in
  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});
      emit(AuthSignInSuccess());
      return userCredential;
    } on FirebaseException catch (e) {
      emit(AuthSignInFailed(errorMessage: e.code.toString()));
       throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});
      emit(AuthSignUpSuccess());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(AuthSignUpFailed(errorMessage: e.code.toString()));
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
    emit(AuthSignOutSuccess());
  }

  // Current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
