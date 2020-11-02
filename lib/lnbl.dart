import 'addln.dart';
import 'deleteln.dart';
import 'lnevent.dart';
import 'setln.dart';
import 'updateln.dart';
import 'ln.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LnBloc extends Bloc<LnEvent, List<Ln>> {
  @override
  List<Ln> get initialState => List<Ln>();

  @override
  Stream<List<Ln>> mapEventToState(LnEvent event) async* {
    if (event is SetLns) {
      yield event.lnList;
    } else if (event is AddLn) {
      List<Ln> newState = List.from(state);
      if (event.newLn != null) {
        newState.add(event.newLn);
      }
      yield newState;
    } else if (event is DeleteLn) {
      List<Ln> newState = List.from(state);
      newState.removeAt(event.lnIndex);
      yield newState;
    } else if (event is UpdateLn) {
      List<Ln> newState = List.from(state);
      newState[event.lnIndex] = event.newLn;
      yield newState;
    }
  }
}