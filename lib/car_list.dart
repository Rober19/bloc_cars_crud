import 'package:bloc_app/bloc/car_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/car_event.dart';
import 'model/car.dart';

class CarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: BlocConsumer<CarBloc, List<Car>>(
          buildWhen: (List<Car> previous, List<Car> current) {
            return true;
          },
          listenWhen: (List<Car> previous, List<Car> current) {
            // condition
            return current.length > previous.length;
          },
          builder: (context, carList) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(carList[index].name),
                    // trailing: PopUpMenu(onDelete: () {
                    //   BlocProvider.of<CarBloc>(context)
                    //       .add(CarEvent.delete(index: index));
                    // }),
                    trailing: PopupMenuButton(
                      itemBuilder: (context_trailing) {
                        return [
                          PopupMenuItem(
                            value: {
                              'value': 'edit',
                              'data': CarEvent.edit(
                                  car: Car(name: 'EDIT'), index: index)
                            },
                            child: Text('Edit'),
                          ),
                          PopupMenuItem(
                            value: {
                              'value': 'delete',
                              'data': CarEvent.delete(index: index)
                            },
                            child: Text('Delete'),
                          )
                        ];
                      },
                      onSelected: (selValue) {
                        dynamic complex = selValue;

                        var value = complex['value'];
                        var data = complex['data'];

                        actionPopUpItemSelected(value, context, data);
                      },
                    ),
                    isThreeLine: true,
                    leading: FlutterLogo(size: 72.0),
                    subtitle: Text('Model ...'),
                    // onTap: () => BlocProvider.of<CarBloc>(context).add(
                    //   CarEvent.delete(index: index),
                    // ),
                  ),
                );
              },
            );
          },
          listener: (BuildContext context, carList) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added!')),
            );
          },
        ));
  }

  void actionPopUpItemSelected(String value, context, event) {
    //
    BlocProvider.of<CarBloc>(context).add(event);
  }
}
