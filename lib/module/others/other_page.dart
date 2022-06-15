import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qinglong_app/base/routes.dart';
import 'package:qinglong_app/base/sp_const.dart';
import 'package:qinglong_app/base/theme.dart';
import 'package:qinglong_app/base/userinfo_viewmodel.dart';
import 'package:qinglong_app/main.dart';
import 'package:qinglong_app/utils/extension.dart';
import 'package:qinglong_app/utils/sp_utils.dart';

class OtherPage extends ConsumerStatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends ConsumerState<OtherPage> {
  var toggleValue = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.routeScript,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 5,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "脚本管理",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  indent: 15,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.routeDependency,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "依赖管理",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  indent: 15,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.routeTaskLog,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "任务日志",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  indent: 15,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (getIt<UserInfoViewModel>().useSecretLogined) {
                      "使用client_id方式登录无法获取登录日志".toast();
                    } else {
                      Navigator.of(context).pushNamed(
                        Routes.routeLoginLog,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "登录日志",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  indent: 15,
                ),

                GestureDetector(
                  onTap: () {
                    if (getIt<UserInfoViewModel>().useSecretLogined) {
                      "使用client_id方式登录无法修改密码".toast();
                    } else {
                      Navigator.of(context).pushNamed(
                        Routes.routeUpdatePassword,
                      );
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "修改密码",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "夜间模式",
                        style: TextStyle(
                          color: ref.watch(themeProvider).themeColor.titleColor(),
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        value: ref.watch(themeProvider).isInDartMode(),
                        onChanged: (open) {
                          ref.watch(themeProvider).changeThemeReal(open);
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "查看代码是否显示行号",
                        style: TextStyle(
                          color: ref.watch(themeProvider).themeColor.titleColor(),
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        activeColor: ref.watch(themeProvider).primaryColor,
                        value: SpUtil.getBool(spShowLine, defValue: false),
                        onChanged: (open) async {
                          await SpUtil.putBool(spShowLine, open);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 15,
                  height: 1,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.routeTheme,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "主题设置",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  indent: 15,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.routeChangeAccount);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "切换账号",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  indent: 15,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.routeAbout,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 5,
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "关于",
                          style: TextStyle(
                            color: ref.watch(themeProvider).themeColor.titleColor(),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  color: ref.watch(themeProvider).themeColor.buttonBgColor(),
                  child: const Text(
                    "退出登录",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("确认退出登录吗?"),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(
                              "取消",
                              style: TextStyle(
                                color: Color(0xff999999),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text(
                              "确定",
                              style: TextStyle(
                                color: ref.watch(themeProvider).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              getIt<UserInfoViewModel>().updateToken("");
                              Navigator.of(context).pushReplacementNamed(Routes.routeLogin);
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
