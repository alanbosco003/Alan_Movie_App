import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theam_state.dart';

class TheamCubit extends Cubit<TheamState> {
  TheamCubit() : super(TheamState(theam: true));

  void theam() =>
      emit(TheamState(theam: state.theam = state.theam == true ? false : true));
}
