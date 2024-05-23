import 'package:flutter/foundation.dart' show kIsWeb;

class Plateforme {
  static bool isWeb() => kIsWeb ? true : false;
  static bool isMobile() => !isWeb();
}
