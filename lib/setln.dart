import 'ln.dart';

import 'lnevent.dart';

class SetLns extends LnEvent {
  List<Ln> lnList;

  SetLns(List<Ln> lns) {
    lnList = lns;
  }
}