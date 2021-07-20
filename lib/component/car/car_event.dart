import 'car_model.dart';

enum EventType { add, edit, delete }

class CarEvent {
  Car car = Car();
  int carIndex = -1;
  EventType eventType = EventType.add;

  CarEvent.add({car}) {
    this.eventType = EventType.add;
    this.car = car;
  }

  CarEvent.delete({index}) {
    this.eventType = EventType.delete;
    this.carIndex = index;
  }

  CarEvent.edit({car, index}) {
    this.eventType = EventType.edit;
    this.car = car;
    this.carIndex = index;
  }
}
