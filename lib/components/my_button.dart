import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onpressed;
  final String text;
  const MyButton({super.key, required this.onpressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      minWidth: double.infinity,
      child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 16),),
    );
  }
}