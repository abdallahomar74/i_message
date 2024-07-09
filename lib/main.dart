import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_message/conf/theme/theme_cubit.dart';
import 'package:i_message/firebase_options.dart';
import 'package:i_message/conf/routing/routing.dart';
import 'package:i_message/pages/auth_screens/cubit/auth_cubit.dart';
import 'package:i_message/pages/home_screen/cubit/chat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: MyRouting.onGenrateRoute,
            onGenerateInitialRoutes: (_) => MyRouting.initRoutes,
            theme: theme,
          );
        },
      ),
    );
  }
}
