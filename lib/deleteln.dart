import 'lnevent.dart';

class DeleteLn extends LnEvent {
  int lnIndex;

  DeleteLn(int index) {
    lnIndex = index;
  }
}