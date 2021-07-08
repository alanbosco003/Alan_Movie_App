import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/constants/enum.dart';
import 'package:movie_db/logic/cubit/internet_cubit.dart';

class Connect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          return Icon(
            Icons.wifi,
            color: Colors.red,
            size: 30.0,
          );
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          return Icon(
            Icons.network_check,
            color: Colors.red,
            size: 30.0,
          );
        } else if (state is InternetDisconnected) {
          return Icon(
            Icons.wifi_off,
            color: Colors.red,
            size: 30.0,
          );
        }
        return Icon(
          Icons.settings,
          color: Colors.red,
          size: 30.0,
        );
      },
    );
  }
}
