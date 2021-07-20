import 'package:bloc_app/component/car/car_list.dart';
import 'package:bloc_app/component/car/car_list_screen.dart';
import 'package:bloc_app/component/stock/cubit/stock_cubit.dart';
import 'package:bloc_app/component/stock/stock_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/car_bloc.dart';
import 'car_event.dart';
import 'car_model.dart';

class CarForm extends StatefulWidget {
  @override
  _CarFormState createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  String _carname = '';
  FocusNode myFocusNode = FocusNode();
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(title: Text('Multiplatform App')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(36),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cars CRUD',
                style: TextStyle(fontSize: 42),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Car'),
                focusNode: myFocusNode,
                controller: myController,
                style: TextStyle(fontSize: 22),
                onSubmitted: (value) {
                  addCar(context, Car(name: _carname));

                  myController.clear();
                  myFocusNode.requestFocus();
                },
                onChanged: (text) {
                  setState(() {
                    _carname = text;
                  });
                },
              ),
              CarList(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 'button1',
              child: Icon(Icons.save),
              onPressed: () => addCar(context, Car(name: _carname))),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'button2',
            child: Icon(Icons.navigate_next),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CarListScreen()),
            ),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'button3',
            backgroundColor: Colors.red,
            child: Icon(Icons.navigate_next),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(                
                  builder: (_) => BlocProvider<StockCubit>(
                        create: (context) => StockCubit(),
                        child: StockUI(title: 'Flutter Demo Home Page'),
                      )),
            ),
          ),
        ],
      ),
    );
  }

  void addCar(context, Car car) {
    BlocProvider.of<CarBloc>(context).add(CarEvent.add(car: car));
  }
}
