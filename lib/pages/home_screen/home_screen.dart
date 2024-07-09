import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/components/my_drawer.dart';
import 'package:i_message/pages/auth_screens/cubit/auth_cubit.dart';
import 'package:i_message/pages/chat_screen/chat_screen.dart';
import 'package:i_message/pages/home_screen/cubit/chat_cubit.dart';

import '../../components/user_tile.dart';

class HomeSreen extends StatelessWidget {
  const HomeSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, "splash", (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.grey,
            title: const Text("Chats"),
            centerTitle: true,
          ),
          body: _buildUserList(context),
          drawer: const MyDrawer(),
        );
      },
    );
  }

  Widget _buildUserList(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: BlocProvider.of<ChatCubit>(context).getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("loading..."),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No users found"),
          );
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).getCurrentUser();
    if (user != null && userData["email"] != user.email) {
      return UserTile(
        text: userData["email"],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
                reciveEmail: userData["email"], receiverId: userData["uid"]),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
