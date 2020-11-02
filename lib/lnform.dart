import 'lnbl.dart';
import 'lndb.dart';
import 'addln.dart';
import 'updateln.dart';
import 'ln.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LnForm extends StatefulWidget {
  final Ln ln;
  final int lnIndex;

  LnForm({this.ln, this.lnIndex});

  @override
  State<StatefulWidget> createState() {
    return LnFormState();
  }
}

class LnFormState extends State<LnForm> {
  String _schname;
  String _type;
  String _amount;
  String _amount2;
  String _year;
  String _date;
  bool _isMatured = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _schname,
      decoration: InputDecoration(labelText: 'Loan Taken From '),
      maxLength: 25,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Entry is Required as name';
        }

        return null;
      },
      onSaved: (String value) {
        _schname = value;
      },
    );
  }

  Widget _buildName2() {
    return TextFormField(
      initialValue: _type,
      decoration: InputDecoration(labelText: 'Reason For Loan'),
      maxLength: 25,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Entry is Required as name';
        }

        return null;
      },
      onSaved: (String value) {
        _type = value;
      },
    );
  }

  Widget _buildabc() {
    return TextFormField(
      initialValue: _amount,
      decoration: InputDecoration(labelText: 'Loan Amount'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        int amount = int.tryParse(value);

        if (amount == null || amount <= 0) {
          return 'Amount must be greater than 0 and Number';
        }

        return null;
      },
      onSaved: (String value) {
        _amount = value;
      },
    );
  }
  Widget _buildabc5() {
    return TextFormField(
      initialValue: _amount2,
      decoration: InputDecoration(labelText: 'Monthly Amount'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        int amount2 = int.tryParse(value);

        if (amount2 == null || amount2 <= 0) {
          return 'Amount must be greater than 0 and Number';
        }

        return null;
      },
      onSaved: (String value) {
        _amount2 = value;
      },
    );
  }

  Widget _buildabc2() {
    return TextFormField(
      initialValue: _year,
      decoration: InputDecoration(labelText: 'Due Time Period '),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        int year = int.tryParse(value);

        if (year == null || year <= 0) {
          return 'year must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _year = value;
      },
    );
  }
  Widget _buildabc4() {
    return TextFormField(
      initialValue: _date,
      decoration: InputDecoration(labelText: 'Issuing Date'),
      maxLength: 15,
      style: TextStyle(fontSize: 15),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date Entry Required i.e 25th June,2020';
        }

        return null;
      },
      onSaved: (String value) {
        _date = value;
      },
    );
  }

  Widget _buildabc3() {
    return SwitchListTile(
      title: Text("Completion Status?", style: TextStyle(fontSize: 14)),
      value: _isMatured,
      onChanged: (bool newValue) => setState(() {
        _isMatured = newValue;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.ln != null) {
      _schname = widget.ln.schname;
      _type = widget.ln.type;
      _amount = widget.ln.amount;
      _amount2 = widget.ln.amount2;
      _year = widget.ln.year;
      _date = widget.ln.date;

      _isMatured = widget.ln.isMatured;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loan Form")),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildName(),
              _buildName2(),
              _buildabc(),
              _buildabc5(),

              _buildabc2(),
              _buildabc4(),
              SizedBox(height: 2),
              _buildabc3(),
              SizedBox(height: 2),
              widget.ln == null
                  ? RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  Ln ln = Ln(
                    schname: _schname,
                    type: _type,
                    amount: _amount,
                    amount2: _amount2,
                    year: _year,
                    date: _date,
                    isMatured: _isMatured,
                  );

                  DatabaseProvider.db.insert(ln).then(
                        (storedLn) => BlocProvider.of<LnBloc>(context).add(
                      AddLn(storedLn),
                    ),
                  );

                  Navigator.pop(context);
                },
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        print("form");
                        return;
                      }

                      _formKey.currentState.save();

                      Ln ln = Ln(
                        schname: _schname,
                        type: _type,
                        amount: _amount,
                        amount2: _amount2,
                        year: _year,
                        date: _date,
                        isMatured: _isMatured,
                      );

                      DatabaseProvider.db.update(widget.ln).then(
                            (storedLn) => BlocProvider.of<LnBloc>(context).add(
                          UpdateLn(widget.lnIndex, ln),
                        ),
                      );

                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}