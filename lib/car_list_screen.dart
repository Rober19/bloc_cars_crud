import 'package:bloc_app/car_list.dart';
import 'package:flutter/material.dart';

class CarListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cheetah Coding')),
      body: CarList(),
    );
  }
}