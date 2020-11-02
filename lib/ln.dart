import 'lndb.dart';

class Ln {
  int id;
  String schname;
  String amount;
  String amount2;
  String year;
  String date;
  String type;
  bool isMatured;

  Ln({this.id, this.schname, this.type, this.amount,this.amount2,this.year,this.date, this.isMatured});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_SCHNAME: schname,
      DatabaseProvider.COLUMN_TYPE: type,
      DatabaseProvider.COLUMN_AMOUNT: amount,
      DatabaseProvider.COLUMN_AMOUNT2: amount2,
      DatabaseProvider.COLUMN_YEAR: year,
      DatabaseProvider.COLUMN_DATE: date,
      DatabaseProvider.COLUMN_MATURED: isMatured ? 1 : 0
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Ln.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    schname = map[DatabaseProvider.COLUMN_SCHNAME];
    type = map[DatabaseProvider.COLUMN_TYPE];
    amount = map[DatabaseProvider.COLUMN_AMOUNT];
    amount2 = map[DatabaseProvider.COLUMN_AMOUNT2];
    year = map[DatabaseProvider.COLUMN_YEAR];
    date = map[DatabaseProvider.COLUMN_DATE];
    isMatured = map[DatabaseProvider.COLUMN_MATURED] == 1;
  }
}