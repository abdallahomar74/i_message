import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/pages/auth_screens/cubit/auth_cubit.dart';
import 'package:i_message/pages/home_screen/cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  final String reciveEmail;
  final String receiverId;
  ChatScreen({super.key, required this.reciveEmail, required this.receiverId});
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(reciveEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList(context)),
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 10,bottom: 10,top: 15),
                    child: TextField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                      hintText: "Type your message here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none),
                      fillColor: Theme.of(context).colorScheme.tertiary,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none)),
                                  ),
                  )),
              IconButton(
                onPressed: () async {
                  if (messageController.text.isNotEmpty) {
                    await BlocProvider.of<ChatCubit>(context)
                        .sendMessage(receiverId, messageController.text);
                    messageController.clear();
                    _scrollToBottom();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    String senderId = BlocProvider.of<AuthCubit>(context).getCurrentUser()!.uid;
    return StreamBuilder(
      stream:
          BlocProvider.of<ChatCubit>(context).getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc, context))
                  .toList()),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          bool isSender = data["senderId"] ==
              BlocProvider.of<AuthCubit>(context).getCurrentUser()!.uid;
          return BubbleSpecialThree(
              text: data["message"],
              color: isSender
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
              tail: false,
              isSender: isSender,
              textStyle: const TextStyle(color: Colors.white, fontSize: 16));
        },
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }
}
