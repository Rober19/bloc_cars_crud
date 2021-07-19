import 'package:bloc_app/component/car/car_event.dart';
import 'package:bloc_app/model/car.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarBloc extends Bloc<CarEvent, List<Car>> {
  CarBloc() : super([]);

  @override
  Stream<List<Car>> mapEventToState(CarEvent event) async* {
    switch (event.eventType) {
      case EventType.add:
        List<Car> newState = List.from(state);
        // if (event.car != null) {
        newState.add(event.car);
        // }
        yield newState;
        break;
      case EventType.delete:
        List<Car> newState = List.from(state);
        print(newState.length);
        newState.removeAt(event.carIndex);
        yield newState;
        break;

      case EventType.edit:
        List<Car> newState = List.from(state);
        print(newState.length);
        newState[event.carIndex] = event.car;
        yield newState;
        break;
      default:
        print('Event not found $event');
        throw Exception('Event not found $event');
    }
  }
}
