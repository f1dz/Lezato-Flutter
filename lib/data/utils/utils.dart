import 'dart:math';

import 'package:intl/intl.dart';

class Utils {
  static String generatePrice() {
    var rand = Random().nextInt(1000) * 100;
    var f = NumberFormat("#,000", "id_ID");
    return "Rp. " + f.format(rand);
  }
}
