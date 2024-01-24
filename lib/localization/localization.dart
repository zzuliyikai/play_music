import 'package:get/get.dart';
import 'en_strings.dart' as en;
import 'zh_hans_strings.dart' as zh_hans;

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en.strings,
        'zh_hans': zh_hans.strings,
      };
}
