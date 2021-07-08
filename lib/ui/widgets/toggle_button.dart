import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/logic/cubit/theam_cubit.dart';

class Toggle extends StatefulWidget {
  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 11),
      child: BlocBuilder<TheamCubit, TheamState>(
        builder: (context, state) {
          return IconButton(
            icon: const Icon(Icons.lightbulb),
            color: state.theam == true ? Colors.white : Colors.black,
            tooltip: 'Change Theam',
            onPressed: () {
              BlocProvider.of<TheamCubit>(context).theam();
            },
          );
        },
      ),
    );
  }
}
