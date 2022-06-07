import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qinglong_app/base/sp_const.dart';
import 'package:qinglong_app/base/userinfo_viewmodel.dart';
import 'package:qinglong_app/main.dart';
import 'package:qinglong_app/utils/codeeditor_theme.dart';
import 'package:qinglong_app/utils/sp_utils.dart';

var themeProvider = ChangeNotifierProvider((ref) => ThemeViewModel());

Color commonColor = const Color(0xFF299343);
Color _primaryColor = commonColor;

class ThemeViewModel extends ChangeNotifier {
  late ThemeData currentTheme;

  bool _isInDarkMode = false;
  Color primaryColor = commonColor;

  ThemeColors themeColor = LightThemeColors();

  ThemeViewModel() {
    _primaryColor = Color(getIt<UserInfoViewModel>().primaryColor);
    primaryColor = Color(getIt<UserInfoViewModel>().primaryColor);
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    _isInDarkMode = brightness == Brightness.dark;
    changeThemeReal(_isInDarkMode, false);
  }

  bool isInDartMode() {
    return SpUtil.getBool(spTheme, defValue: false);
  }

  void changeThemeReal(bool dark, [bool notify = true]) {
    _isInDarkMode = dark;
    SpUtil.putBool(spTheme, dark);
    if (!dark) {
      currentTheme = getLightTheme();
      themeColor = LightThemeColors();
    } else {
      currentTheme = getDartTheme();
      themeColor = DartThemeColors();
    }
    if (notify) {
      notifyListeners();
    }
  }

  get darkMode => _isInDarkMode;

  void changePrimaryColor(Color color) {
    _primaryColor = color;
    primaryColor = color;
    getIt<UserInfoViewModel>().updateCustomColor(color.value);
    changeThemeReal(SpUtil.getBool(spTheme, defValue: false), true);
  }

  void changeTheme() {
    changeThemeReal(!SpUtil.getBool(spTheme, defValue: false), true);
  }

  ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: _primaryColor,
      colorScheme: ColorScheme.light(
        secondary: _primaryColor,
        primary: _primaryColor,
      ),
      scaffoldBackgroundColor: const Color(0xffffffff),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: _primaryColor,
          fontSize: 14,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _primaryColor,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff999999),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff999999),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _primaryColor,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _primaryColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _primaryColor,
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: const TextStyle(
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
        labelColor: _primaryColor,
        unselectedLabelColor: const Color(0xff999999),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: _primaryColor),
        ),
      ),
      toggleableActiveColor: _primaryColor,
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.black;
          },
        ),
      ),
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
      ),
    );
  }

  ThemeData getDartTheme() {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: const Color(0xffffffff),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: _primaryColor,
          fontSize: 14,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _primaryColor,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff999999),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff999999),
          ),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
        ),
        labelColor: Color(0xffffffff),
        unselectedLabelColor: Color(0xff999999),
      ),
      colorScheme: ColorScheme.light(
        secondary: _primaryColor,
        primary: _primaryColor,
      ),
      toggleableActiveColor: _primaryColor,
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.white;
          },
        ),
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xffffffff),
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

abstract class ThemeColors {
  Color settingBgColor();

  Color settingBordorColor();

  Color titleColor();

  Color descColor();

  Color tabBarColor();

  Color blackAndWhite();

  Color pinColor();

  Color buttonBgColor();

  Map<String, TextStyle> codeEditorTheme();
}

class LightThemeColors extends ThemeColors {
  @override
  Color titleColor() {
    return const Color(0xff333333);
  }

  @override
  Color pinColor() {
    return const Color(0xffF7F7F7);
  }

  @override
  Color blackAndWhite() {
    return Colors.white;
  }

  @override
  Map<String, TextStyle> codeEditorTheme() {
    return qinglongLightTheme;
  }

  @override
  Color descColor() {
    return const Color(0xff999999);
  }

  @override
  Color settingBgColor() {
    return Colors.white;
  }

  @override
  Color buttonBgColor() {
    return _primaryColor;
  }

  @override
  Color settingBordorColor() {
    return Colors.white;
  }

  @override
  Color tabBarColor() {
    return const Color(0xffF7F7F7);
  }
}

class DartThemeColors extends ThemeColors {
  @override
  Color titleColor() {
    return Colors.white;
  }

  @override
  Color pinColor() {
    return Colors.black12;
  }

  @override
  Map<String, TextStyle> codeEditorTheme() {
    return qinglongDarkTheme;
  }

  @override
  Color blackAndWhite() {
    return Colors.black;
  }

  @override
  Color descColor() {
    return const Color(0xff999999);
  }

  @override
  Color settingBgColor() {
    return Colors.black;
  }

  @override
  Color buttonBgColor() {
    return const Color(0xff333333);
  }

  @override
  Color settingBordorColor() {
    return Color(0xff333333);
  }

  @override
  Color tabBarColor() {
    return Colors.black;
  }
}
