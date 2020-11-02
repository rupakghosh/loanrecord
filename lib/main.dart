import 'lnlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lnbl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LnBloc>(
      create: (context) => LnBloc(),
      child: MaterialApp(
        title: 'Loan Records',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: LnList(),
      ),
    );
  }
}