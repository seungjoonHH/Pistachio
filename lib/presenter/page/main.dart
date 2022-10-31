/* 메인 페이지 프리젠터 */
import 'package:get/get.dart';

/// class
class MainPresenter extends GetxController {
  /// static variables
  // 리프레시 컨트롤러

// // 리프레시 중 실행 함수
// static void onRefresh() async {
//   final crewPresenter = Get.find<CrewPresenter>();
//   await crewPresenter.load();
//   refreshCont.refreshCompleted();
// }
//
// // 로딩 중 실행 함수
// static void onLoading() async {
//   await Future.delayed(const Duration(milliseconds: 1000));
//   refreshCont.loadComplete();
// }
//
// /// attributes
// // 로딩 여부
// bool detailLoading = false;
//
// /// methods
// // 특정 크루 카드 클릭 시
// void crewCardPressed(Crew crew) async {
//   detailLoading = true; update();
//   await DetailPresenter.toDetail(crew);
//   detailLoading = false; update();
// }
}
