import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/logic/cubit/theam_cubit.dart';
import 'package:movie_db/ui/screens/playvideo.dart';

import 'ui/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TheamCubit>(
      create: (context) => TheamCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
        initialRoute: '/',
        routes: {
          '/': (ctx) => HomeScreen(),
          VideoPlayerApp.route: (ctx) => VideoPlayerApp(),
        },
      ),
    );
  }
}
