import 'ln.dart';
import 'lnevent.dart';

class UpdateLn extends LnEvent {
  Ln newLn;
  int lnIndex;

  UpdateLn(int index, Ln ln) {
    newLn = ln;
    lnIndex = index;
  }
}