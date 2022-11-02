import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePresenter extends GetxController {
  static final refreshCont = RefreshController();

  static Future toHome() async {
    final homeP = Get.find<HomePresenter>();

    Get.offAllNamed('/home');
    await homeP.init();
  }

  Future init() async {
    final userP = Get.find<UserPresenter>();
    final loadingP = Get.find<LoadingPresenter>();

    loadingP.loadStart();

    graphStates = {
      ActivityType.calorie: false,
      ActivityType.distance: false,
      ActivityType.height: false,
      ActivityType.weight: false,
    };

    await userP.load();
    await userP.fetchData();

    loadingP.loadEnd();

    update();
  }

  Map<ActivityType, bool> graphStates = {
    ActivityType.calorie: false,
    ActivityType.distance: false,
    ActivityType.height: false,
    ActivityType.weight: false,
  };

  void showLaterGraph(ActivityType type) { graphStates[type] = true; update(); }

}