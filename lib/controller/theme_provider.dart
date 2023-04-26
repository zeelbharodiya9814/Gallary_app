



import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/theme_class.dart';


class ThemeProvider extends ChangeNotifier {

  ThemeModel tm1 = ThemeModel(isDark: false);

  void changetheme() {
    tm1.isDark = !tm1.isDark;
    notifyListeners();
  }
}
