import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16)
          ),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal:25),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [ 
              const Icon(Icons.person,color: Colors.white,),
              const SizedBox(width: 20,),
              Text(text,style: TextStyle(color: Colors.white,),),
            ],
          ),
        ),
      ),
    ) ;
  }
}