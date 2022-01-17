import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qinglong_app/base/base_viewmodel.dart';
import 'package:qinglong_app/base/http/api.dart';
import 'package:qinglong_app/base/http/http.dart';
import 'package:qinglong_app/base/http/url.dart';
import 'package:qinglong_app/base/userinfo_viewmodel.dart';
import 'package:qinglong_app/main.dart';

import 'login_bean.dart';

var loginProvider = ChangeNotifierProvider((ref) => LoginViewModel());

class LoginViewModel extends ViewModel {
  bool isLoading = false;
  String msg = "";

  Future<void> login(String userName, String password) async {
    isLoading = true;
    msg = "";

    notifyListeners();
    HttpResponse<LoginBean> response = await Api.login(userName, password);

    if (response.success) {
      getIt<UserInfoViewModel>().updateToken(response.bean?.token ?? "");
      isLoading = false;
    } else {
      isLoading = false;
      msg = response.message ?? "";
    }
    notifyListeners();
  }
}
