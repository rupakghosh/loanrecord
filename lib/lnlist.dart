import 'lndb.dart';
import 'deleteln.dart';
import 'setln.dart';
import 'lnform.dart';
import 'ln.dart';
import 'package:flutter/material.dart';
import 'lnbl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lnbl.dart';

class LnList extends StatefulWidget {
  const LnList({Key key}) : super(key: key);

  @override
  _LnListState createState() => _LnListState();
}

class _LnListState extends State<LnList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getLns().then(
          (lnList) {
        BlocProvider.of<LnBloc>(context).add(SetLns(lnList));
      },
    );
  }

  showLnDialog(BuildContext context, Ln ln, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ln.schname),
        content: Text("Sl No. ${ln.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LnForm(ln: ln, lnIndex: index),
              ),
            ),
            child: Text("Update Record"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(ln.id).then((_) {
              BlocProvider.of<LnBloc>(context).add(
                DeleteLn(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete Record"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Move Back"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Preparing");
    return Scaffold(
      appBar: AppBar(title: Text("Loan Records")),
      body: Container(
        child: BlocConsumer<LnBloc, List<Ln>>(
          builder: (context, lnList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                print("lnList: $lnList");

                Ln ln = lnList[index];
                return ListTile(
                    title: Text(ln.schname, style: TextStyle(fontSize: 30, color: Colors.brown)),
                    subtitle: Text(
                      "Loan Taken For: ${ln.type}\nLoan Amount: ${ln.amount}\nAmount to be Paid(Monthly): ${ln.amount2}\nDue Time Period(in years): ${ln.year}\n Issuing Date(i.e. 22nd June,2020): ${ln.date}\nMaturity: ${ln.isMatured}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showLnDialog(context, ln, index));
              },
              itemCount: lnList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.brown),
            );
          },
          listener: (BuildContext context, lnList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LnForm()),
        ),
      ),
    );
  }
}