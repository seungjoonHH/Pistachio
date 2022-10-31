import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/exercises.dart';
import 'package:pistachio/model/enum/enum.dart';

abstract class Record {
  late double _amount;
  ActivityType? _type;
  DistanceUnit? _state;

  double get amount => _amount;
  ActivityType? get type => _type;
  DistanceUnit? get state => _state;
  set amount(double amount) => this.amount = amount;
  set type(ActivityType? type) => this.type = type;
  set state(DistanceUnit? state) => this.state = state;

  static Record init(
    ActivityType type, double amount,
    [DistanceUnit? unit]
  ) {
    assert(type != ActivityType.distance || unit != null);

    switch (type) {
      case ActivityType.calorie:
        return CalorieRecord(amount: amount);
      case ActivityType.distance:
        return DistanceRecord(
          amount: amount, state: unit!,
        );
      case ActivityType.height:
        return HeightRecord(amount: amount);
      case ActivityType.weight:
        return WeightRecord(amount: amount);
    }
  }

  double convert(DistanceUnit dst) => amount;
}

class DistanceRecord extends Record {
  @override
  double amount = 0;

  @override
  ActivityType? type = ActivityType.distance;

  @override
  DistanceUnit? state;

  double get step => convert(DistanceUnit.step);
  double get minute => convert(DistanceUnit.minute);
  double get kilometer => convert(DistanceUnit.kilometer);

  DistanceRecord({
    required this.amount,
    required this.state,
  });

  @override
  double convert(DistanceUnit dst) {
    double velocity = Walking.velocity * .8
        + Jogging.velocity * .1 + Running.velocity * .1;
    const double kilometerPerStep = 0.00074;

    double value = amount.toDouble();
    int direction = dst.index - state!.index;

    switch(direction) {
      case -2:
        value /= (velocity * kilometerPerStep); break;
      case -1:
        if (dst == DistanceUnit.step) value /= kilometerPerStep;
        if (dst == DistanceUnit.minute) value /= velocity;
        break;
      case 1:
        if (dst == DistanceUnit.kilometer) value *= kilometerPerStep;
        if (dst == DistanceUnit.step) value *= velocity;
        break;
      case 2:
        value *= (velocity * kilometerPerStep); break;
    }

    amount = value;
    state = dst;
    return amount;
  }
}

class HeightRecord extends Record {
  @override
  double amount = 0;

  @override
  ActivityType? type = ActivityType.height;

  int get lifeExtensionInSec => (amount * 100).ceil();
  String get lifeExtension => timeToString(lifeExtensionInSec);

  HeightRecord({required this.amount});

}

class CalorieRecord extends Record {
  @override
  double amount = 0;

  @override
  ActivityType? type = ActivityType.calorie;

  static double from(ActivityType type, double amount) {
    double velocity = velocities[type]!.toDouble();
    return calories[type]! * velocity * amount;
  }

  CalorieRecord({required this.amount});
}

class WeightRecord extends Record {
  @override
  double amount = 0;

  @override
  ActivityType? type = ActivityType.weight;

  WeightRecord({required this.amount});
}