import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams/utils/app_theme.dart';
import 'package:teams/utils/const.dart';
import 'package:teams/utils/utils.dart';

import 'bloc/theme_bloc/theme_cubit.dart';

void main() {
  runApp(TeamsApp());
}

class TeamsApp extends StatelessWidget {
  final MyRouter? router = MyRouter();
  TeamsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.system,
            title: "Teams",
            initialRoute: homeRoute,
            onGenerateRoute: router!.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
// return MaterialApp(
//       title: "Teams",
//       theme: ThemeData(primaryColor: const Color(0xff0CABDF)),
//       initialRoute: homeRoute,
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: router!.generateRoute,
//     );