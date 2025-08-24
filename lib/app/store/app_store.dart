import 'package:chat_gui/utils/rx_persist.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppStore extends GetxService {
  final RxInt globalCounter = 0.obs;

  Future<AppStore> init() async {
    globalCounter.persist('globalCounter');

    return this;
  }

  void incGlobal() => globalCounter.value++;
}
