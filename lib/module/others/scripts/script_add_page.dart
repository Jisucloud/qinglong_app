import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/json.dart';
import 'package:highlight/languages/powershell.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/vbscript-html.dart';
import 'package:highlight/languages/yaml.dart';
import 'package:qinglong_app/base/http/api.dart';
import 'package:qinglong_app/base/http/http.dart';
import 'package:qinglong_app/base/ql_app_bar.dart';
import 'package:qinglong_app/base/sp_const.dart';
import 'package:qinglong_app/base/theme.dart';
import 'package:qinglong_app/utils/extension.dart';
import 'package:qinglong_app/utils/sp_utils.dart';

class ScriptAddPage extends ConsumerStatefulWidget {
  final String title;
  final String path;

  const ScriptAddPage(this.title, this.path, {Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ScriptAddPageState();
}

class _ScriptAddPageState extends ConsumerState<ScriptAddPage> {
  CodeController? _codeController;
  late String result;
  FocusNode focusNode = FocusNode();
  late String preResult;

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    result = "## created by 青龙客户端 ${DateTime.now().toString()}\n\n";
    preResult = result;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
  }

  getLanguageType(String title) {
    if (title.endsWith(".js")) {
      return javascript;
    }

    if (title.endsWith(".sh")) {
      return powershell;
    }

    if (title.endsWith(".py")) {
      return python;
    }
    if (title.endsWith(".json")) {
      return json;
    }
    if (title.endsWith(".yaml")) {
      return yaml;
    }
    return vbscriptHtml;
  }

  @override
  Widget build(BuildContext context) {
    _codeController ??= CodeController(
      text: result,
      language: getLanguageType(widget.title),
      onChange: (value) {
        result = value;
      },
      theme: ref.watch(themeProvider).themeColor.codeEditorTheme(),
      stringMap: {
        "export": const TextStyle(fontWeight: FontWeight.normal, color: Color(0xff6B2375)),
      },
    );
    return Scaffold(
      appBar: QlAppBar(
        canBack: true,
        backCall: () {
          FocusManager.instance.primaryFocus?.unfocus();

          if (preResult == result) {
            Navigator.of(context).pop();
          } else {
            showCupertinoDialog(
              context: context,
              useRootNavigator: false,
              builder: (childContext) => CupertinoAlertDialog(
                title: const Text("温馨提示"),
                content: const Text("你新增的内容还没用提交,确定退出吗?"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text(
                      "取消",
                      style: TextStyle(
                        color: Color(0xff999999),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(childContext).pop();
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
                      Navigator.of(childContext).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        },
        title: '新增${widget.title}',
        actions: [
          InkWell(
            onTap: () async {
              try {
                HttpResponse<NullResponse> response = await Api.addScript(
                  widget.title,
                  widget.path,
                  result,
                );
                if (response.success) {
                  "提交成功".toast();
                  Navigator.of(context).pop(true);
                } else {
                  (response.message ?? "").toast();
                }
              } catch (e) {}
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Center(
                child: Text(
                  "提交",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SpUtil.getBool(spShowLine, defValue: false) ? 0 : 10,
          ),
          child: CodeField(
            controller: _codeController!,
            expands: true,
            wrap: SpUtil.getBool(spShowLine, defValue: false) ? false : true,
            hideColumn: !SpUtil.getBool(spShowLine, defValue: false),
            lineNumberStyle: LineNumberStyle(
              textStyle: TextStyle(
                color: ref.watch(themeProvider).themeColor.descColor(),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
