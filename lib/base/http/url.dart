import 'package:qinglong_app/base/userinfo_viewmodel.dart';
import 'package:qinglong_app/main.dart';

class Url {
  static get login => "/api/user/login";

  static get system => "/api/system";

  static get loginOld => "/api/login";

  static get loginTwo => "/api/user/two-factor/login";
  static const loginByClientId = "/open/auth/token";
  static const user = "/api/user";

  static const updatePassword = "/api/user";

  static get tasks => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons"
      : "/api/crons";

  static get runTasks => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/run"
      : "/api/crons/run";

  static get stopTasks => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/stop"
      : "/api/crons/stop";

  static get taskDetail => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/"
      : "/api/crons/";

  static get addTask => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons"
      : "/api/crons";

  static get pinTask => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/pin"
      : "/api/crons/pin";

  static get unpinTask => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/unpin"
      : "/api/crons/unpin";

  static get enableTask => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/enable"
      : "/api/crons/enable";

  static get disableTask => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/crons/disable"
      : "/api/crons/disable";

  static get files => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/configs/files"
      : "/api/configs/files";

  static get configContent => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/configs/"
      : "/api/configs/";

  static get saveFile => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/configs/save"
      : "/api/configs/save";

  static get envs =>
      getIt<UserInfoViewModel>().useSecretLogined ? "/open/envs" : "/api/envs";

  static get addEnv =>
      getIt<UserInfoViewModel>().useSecretLogined ? "/open/envs" : "/api/envs";

  static get delEnv =>
      getIt<UserInfoViewModel>().useSecretLogined ? "/open/envs" : "/api/envs";

  static get disableEnvs => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/envs/disable"
      : "/api/envs/disable";

  static get enableEnvs => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/envs/enable"
      : "/api/envs/enable";

  static get loginLog => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/user/login-log"
      : "/api/user/login-log";

  static get taskLog =>
      getIt<UserInfoViewModel>().useSecretLogined ? "/open/logs" : "/api/logs";

  static get taskLogDetail => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/logs/"
      : "/api/logs/";

  static get scripts => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/scripts/files"
      : "/api/scripts/files";

  static get scripts2 => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/scripts"
      : "/api/scripts";

  static get scriptUpdate => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/scripts"
      : "/api/scripts";

  static get scriptDetail => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/scripts/"
      : "/api/scripts/";

  static get dependencies => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/dependencies"
      : "/api/dependencies";

  static get addScript => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/scripts"
      : "/api/scripts";

  static get dependencyReinstall => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/dependencies/reinstall"
      : "/api/dependencies/reinstall";

  static intimeLog(String cronId) {
    return getIt<UserInfoViewModel>().useSecretLogined
        ? "/open/crons/$cronId/log"
        : "/api/crons/$cronId/log";
  }

  static envMove(String envId) {
    return getIt<UserInfoViewModel>().useSecretLogined
        ? "/open/envs/$envId/move"
        : "/api/envs/$envId/move";
  }

  // 运行订阅
  static get runSubscriptions => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/subscriptions/run"
      : "/api/subscriptions/run";

  // 停止订阅
  static get stopSubscriptions => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/subscriptions/stop"
      : "/api/subscriptions/stop";

  // 启用订阅
  static get enableSubscriptions => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/subscriptions/enable"
      : "/api/subscriptions/enable";

  // 禁用订阅
  static get disableSubscriptions => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/subscriptions/disable"
      : "/api/subscriptions/disable";

  // GET 获取订阅 POST 提交订阅 PUT 修改订阅 DELETE 删除订阅
  static get subscriptions => getIt<UserInfoViewModel>().useSecretLogined
      ? "/open/subscriptions"
      : "/api/subscriptions";

  // 获取订阅日志
  static subtimeLog(int cronId) {
    return getIt<UserInfoViewModel>().useSecretLogined
        ? "/open/subscriptions/$cronId/log"
        : "/api/subscriptions/$cronId/log";
  }

  static bool inWhiteList(String path) {
    if (path == login ||
        path == loginByClientId ||
        path == loginTwo ||
        path == loginOld) {
      return true;
    }
    return false;
  }

  static bool inLoginList(String path) {
    if (path == login || path == loginByClientId || path == loginOld) {
      return true;
    }
    return false;
  }
}
