import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/components/my_button.dart';
import 'package:i_message/components/my_textfield.dart';
import 'package:i_message/pages/auth_screens/cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignInSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
        }
        if (state is AuthSignInFailed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo2.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "welecome back, you've been missed!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextfield(
                  controller: _emailController,
                  hinttext: 'Email',
                  obscure: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextfield(
                  controller: _passwordController,
                  hinttext: 'Password',
                  obscure: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    onpressed: () => BlocProvider.of<AuthCubit>(context).signIn(
                        _emailController.text, _passwordController.text),
                    text: "Login"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "not a member?  ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, "register"),
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
