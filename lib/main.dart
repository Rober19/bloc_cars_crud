import 'package:bloc_app/component/car/bloc/car_bloc.dart';
// import 'package:bloc_app/bloc/car_bloc_delegate.dart';
import 'package:bloc_app/component/car/car_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/car/bloc/car_bloc_delegate.dart';

void main() {
  //logger
  Bloc.observer = CarBlocDelegate();
  // Bloc.observer = StockDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarBloc>(
      create: (context) => CarBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          secondaryHeaderColor: Colors.red,
        ),
        home: CarForm(),
      ),
    );
  }
}
