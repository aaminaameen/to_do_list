import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/to_do_bloc.dart';
import 'package:to_do_list/screen/splash/splash_screen.dart';
import 'package:to_do_list/style/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc(),
      child: MaterialApp(
        title: 'TO DO LIST',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const SplashScreen(),
      ),
    );
  }
}
