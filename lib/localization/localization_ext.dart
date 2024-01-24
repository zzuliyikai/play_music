import 'package:get/get.dart';
import 'package:play_music/main.dart';

extension TransString on String {
  String get t {
    String localStr = currentLanguage;
    if (Get.translations.containsKey(localStr) == false) return this;

    Map<String, String> map = Get.translations[localStr]!;
    String? value;
    value = map[this];
    return value ?? this;
  }
}
