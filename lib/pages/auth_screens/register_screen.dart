import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/components/my_button.dart';
import 'package:i_message/components/my_textfield.dart';
import 'package:i_message/pages/auth_screens/cubit/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (_confPasswordController.text == _passwordController.text) {
                 if (state is AuthSignUpSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, "home", (route) => false);
          }
          if (state is AuthSignUpFailed) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(state.errorMessage),
                    ));
          }
          }else{
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Passwords don't match"),
                    ));
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
                    "let's create an account for you",
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
                    height: 15,
                  ),
                  MyTextfield(
                    controller: _confPasswordController,
                    hinttext: 'Confirm Password',
                    obscure: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    onpressed: () => BlocProvider.of<AuthCubit>(context).signUp(
                        _emailController.text, _passwordController.text),
                    text: "Sign Up",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "have an account?  ",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, "login"),
                        child: const Text(
                          "Login Now",
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
