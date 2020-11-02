import 'ln.dart';

import 'lnevent.dart';

class AddLn extends LnEvent {
  Ln newLn;

  AddLn(Ln ln) {
    newLn = ln;
  }
}