import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qinglong_app/base/http/api.dart';
import 'package:qinglong_app/base/ql_app_bar.dart';
import 'package:qinglong_app/json.jc.dart';
import 'package:qinglong_app/module/env/env_bean.dart';
import 'package:qinglong_app/utils/extension.dart';
import 'package:share_plus/share_plus.dart';

import '../../../base/theme.dart';
import '../../../base/userinfo_viewmodel.dart';
import '../../../main.dart';

class BackUpPage extends ConsumerStatefulWidget {
  const BackUpPage({Key? key}) : super(key: key);

  @override
  _BackUpPageState createState() => _BackUpPageState();
}

class _BackUpPageState extends ConsumerState<BackUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QlAppBar(
        canBack: true,
        title: '数据备份',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: ref.watch(themeProvider).themeColor.settingBordorColor(),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      getEnv();
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
                            "环境变量备份到本地",
                            style: TextStyle(
                              color: ref
                                  .watch(themeProvider)
                                  .themeColor
                                  .titleColor(),
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
                      uploadEnv(context);
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
                            "从本地导入环境变量",
                            style: TextStyle(
                              color: ref
                                  .watch(themeProvider)
                                  .themeColor
                                  .titleColor(),
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
                      uploadEnvFromFile();
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
                            "从文件导入环境变量",
                            style: TextStyle(
                              color: ref
                                  .watch(themeProvider)
                                  .themeColor
                                  .titleColor(),
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
                      shareEnvs();
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
                            "导出环境变量",
                            style: TextStyle(
                              color: ref
                                  .watch(themeProvider)
                                  .themeColor
                                  .titleColor(),
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
                ]),
          )
        ],
      ),
    );
  }

  Future<void> shareEnvs() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var dir = Directory("${appDocDir.path}/backup/");
    var fileList = await dir.list().toList();
    List<String> paths = [];
    for(var i=0;i<fileList.length;i++){
      paths.add(fileList[i].path);
    }
    await Share.shareFiles(paths);
  }

  void getEnv() async {
    var envs = await Api.envs("");
    var data = json.encode(envs.bean);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    // String? path = await FilePicker.platform.getDirectoryPath(initialDirectory:appDocDir.path,dialogTitle: "请选择保存的文件夹");
    Directory("${appDocDir.path}/backup/").create();
    Uri uri = Uri.parse(getIt<UserInfoViewModel>().host!);
    File file = File("${appDocDir.path}/backup/${uri.host}-${uri.port}.env");
    file = await file.writeAsString(data, flush: true);
    "备份成功".toast();
  }

  void uploadEnvFromFile()async{
    var result = await FilePicker.platform.pickFiles(dialogTitle: "请选择env文件");
    if (result == null)return;
    File f = File(result.paths[0]!);
    var data = await f.readAsString();
    var content = jsonDecode(data) as List<dynamic>;
    for (var j = 0; j < content.length; j++) {
      var bean = JsonConversion$Json.fromJson<EnvBean>(content[j]);
      var resp = await Api.addEnv(bean.name!, bean.value!, bean.remarks!);
      if (!resp.success){
        resp.message.toast();
      }
    }
    "备份完成".toast();
  }
  }

  void uploadEnv(BuildContext context) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<Widget> widgets = [];
    var dir = Directory("${appDocDir.path}/backup/");
    var fileList = await dir.list().toList();
    for (var i = 0; i < fileList.length; i++) {
      var paths = fileList[i].path.split("/");
      widgets.add(
          ListTile(
        title: Text(paths[paths.length - 1]),
        onTap: () async {
          File f = File(fileList[i].path);
          var data = await f.readAsString();
          var content = jsonDecode(data) as List<dynamic>;
          for (var j = 0; j < content.length; j++) {
            var bean = JsonConversion$Json.fromJson<EnvBean>(content[j]);
            var resp = await Api.addEnv(bean.name!, bean.value!, bean.remarks!);
            if (!resp.success){
              resp.message.toast();
            }
          }
          "备份完成".toast();


        },
      ));
    }
    var dialog = SimpleDialog(title: const Text("请选择备份文件"), children: widgets);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

