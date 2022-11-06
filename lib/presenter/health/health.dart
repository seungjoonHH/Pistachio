import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/record.dart';
import 'package:pistachio/presenter/model/user.dart';

class HealthPresenter {
  // create a HealthFactory for use in the app
  /// Fetch steps from the health plugin and show them in the app.
  static Future fetchStepData() async {
    HealthFactory health = HealthFactory();
    int steps = 0;

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.
    await HealthFactory.hasPermissions(
      [HealthDataType.STEPS],
      permissions: [HealthDataAccess.WRITE],
    );
    await Permission.activityRecognition.request();
    await Permission.location.request();

    if (requested) {
      final userP = Get.find<UserPresenter>();
      steps = (await health.getTotalStepsInInterval(today, now)) ?? 0;
      DistanceRecord distance = DistanceRecord(
        amount: steps.toDouble(),
        state: DistanceUnit.step,
      );

      userP.setRecord(ActivityType.distance, distance);
      userP.save();
    }
  }

  /// Fetch flights from the health plugin and show them in the app.
  static Future fetchFlightsData() async {
    HealthFactory health = HealthFactory();
    final types = [
      HealthDataType.FLIGHTS_CLIMBED,
    ];
    List<HealthDataPoint> flightsData;
    int flights = 0;

    // get steps for today (i.e., since midnight)

    bool requested = await health.requestAuthorization(types);

    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.
    await HealthFactory.hasPermissions(
      [HealthDataType.FLIGHTS_CLIMBED],
      permissions: [HealthDataAccess.WRITE],
    );
    await Permission.activityRecognition.request();
    await Permission.location.request();

    if (requested) {
      final userP = Get.find<UserPresenter>();
      flightsData = (await health.getHealthDataFromTypes(today, now, types));
      flightsData = HealthFactory.removeDuplicates(flightsData);

      for (var flight in flightsData) {
        flights += double.parse(flight.value.toString()).round();
      }

      HeightRecord height = HeightRecord(amount: flights.toDouble());

      userP.setRecord(ActivityType.height, height);
      userP.save();
    }
  }

  /// Add some health data.
  static Future addStepsData(Record distance) async {
    HealthFactory health = HealthFactory();

    final startTime = today;
    final types = [HealthDataType.STEPS];
    final rights = [HealthDataAccess.WRITE];
    final permissions = [HealthDataAccess.READ_WRITE];

    bool? hasPermissions =
    await HealthFactory.hasPermissions(types, permissions: rights);
    if (!hasPermissions!) {
      await health.requestAuthorization(types, permissions: permissions);
    }

    distance.convert(DistanceUnit.step);

    print(startTime);
    print(now);

    // Store a count of steps taken
    await health.writeHealthData(
      distance.amount.toDouble(),
      HealthDataType.STEPS,
      startTime,
      now,
    );
  }

  /// Add some health data.
  static Future addFlightsData(Record height) async {
    HealthFactory health = HealthFactory();

    final types = [HealthDataType.FLIGHTS_CLIMBED];
    final rights = [HealthDataAccess.WRITE];
    final permissions = [HealthDataAccess.READ_WRITE];
    bool? hasPermissions =
    await HealthFactory.hasPermissions(types, permissions: rights);
    if (hasPermissions == false) {
      await health.requestAuthorization(types, permissions: permissions);
    }

    // Store a count of steps taken
    await health.writeHealthData(
      height.amount.toDouble(),
      HealthDataType.FLIGHTS_CLIMBED,
      now,
      now,
    );
  }
}
