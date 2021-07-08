import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/logic/cubit/internet_cubit.dart';

import 'package:movie_db/logic/cubit/theam_cubit.dart';
import 'package:movie_db/ui/screens/playvideo.dart';

import 'ui/screens/screens.dart';

void main() => runApp(MyApp(
      connectivity: Connectivity(),
    ));

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  const MyApp({
    Key key,
    @required this.connectivity,
  }) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TheamCubit>(
          create: (context) => TheamCubit(),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        )
      ],
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
