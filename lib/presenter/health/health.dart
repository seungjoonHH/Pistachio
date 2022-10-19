import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';

class HealthPresenter {
  // create a HealthFactory for use in the app
  /// Fetch steps from the health plugin and show them in the app.
  static Future fetchStepData() async {
    HealthFactory health = HealthFactory();
    int steps = 0;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

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
      try {
        final userPresenter = Get.find<UserPresenter>();
        PUser user = userPresenter.loggedUser;
        steps = (await health.getTotalStepsInInterval(midnight, now))!;
        user.setRecord(ActivityType.distance, today, steps);
        userPresenter.save();
      } catch (error) {
        if (kDebugMode) {
          print("Caught exception in getTotalStepsInInterval: $error");
        }
      }

      if (kDebugMode) {
        print('Total number of steps: $steps');
      }
    } else {
      if (kDebugMode) {
        print("Authorization not granted - error in authorization");
      }
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
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

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
      try {
        final userPresenter = Get.find<UserPresenter>();
        PUser user = userPresenter.loggedUser;
        flightsData =
            (await health.getHealthDataFromTypes(midnight, now, types));
        flightsData = HealthFactory.removeDuplicates(flightsData);

        for (var f in flightsData) {
          flights += double.parse(f.value.toString()).round();
        }

        user.setRecord(ActivityType.height, today, flights);
        userPresenter.save();
      } catch (error) {
        if (kDebugMode) {
          print("Caught exception in getTotalFlightsInInterval: $error");
        }
      }

      if (kDebugMode) {
        print('Total number of flights: $flights');
      }
    } else {
      if (kDebugMode) {
        print("Authorization not granted - error in authorization");
      }
    }
  }

  /// Add some health data.
  static Future addStepsData(int minutes, int steps) async {
    HealthFactory health = HealthFactory();
    final now = DateTime.now();
    final earlier = now.subtract(Duration(minutes: minutes));

    final types = [HealthDataType.STEPS];
    final rights = [HealthDataAccess.WRITE];
    final permissions = [HealthDataAccess.READ_WRITE];
    bool? hasPermissions =
        await HealthFactory.hasPermissions(types, permissions: rights);
    if (hasPermissions == false) {
      await health.requestAuthorization(types, permissions: permissions);
    }

    // Store a count of steps taken
    await health.writeHealthData(
      steps.toDouble(),
      HealthDataType.STEPS,
      earlier,
      now,
    );
  }

  /// Add some health data.
  static Future addFlightsData(int flights) async {
    HealthFactory health = HealthFactory();
    final now = DateTime.now();

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
      flights.toDouble(),
      HealthDataType.FLIGHTS_CLIMBED,
      now,
      now,
    );
  }
}
