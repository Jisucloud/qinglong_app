import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qinglong_app/base/http/api.dart';
import 'package:qinglong_app/base/http/http.dart';
import 'package:qinglong_app/base/ql_app_bar.dart';
import 'package:qinglong_app/module/env/env_bean.dart';
import 'package:qinglong_app/module/env/env_viewmodel.dart';
import 'package:qinglong_app/utils/extension.dart';

class AddEnvPage extends ConsumerStatefulWidget {
  final EnvBean? envBean;

  const AddEnvPage({Key? key, this.envBean}) : super(key: key);

  @override
  ConsumerState<AddEnvPage> createState() => _AddEnvPageState();
}

class _AddEnvPageState extends ConsumerState<AddEnvPage> {
  late EnvBean envBean;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.envBean != null) {
      envBean = widget.envBean!;
      _nameController.text = envBean.name ?? "";
      _valueController.text = envBean.value ?? "";
      _remarkController.text = envBean.remarks ?? "";
    } else {
      envBean = EnvBean();
    }
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        focusNode.requestFocus();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QlAppBar(
        canBack: true,
        backCall: () {
          Navigator.of(context).pop();
        },
        title: envBean.name == null ? "新增环境变量" : "编辑环境变量",
        actions: [
          InkWell(
            onTap: () {
              submit();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Center(
                child: Text(
                  "提交",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "名称:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextField(
                    focusNode: focusNode,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "请输入名称",
                    ),
                    autofocus: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "值:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextField(
                    controller: _valueController,
                    maxLines: 8,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: "请输入值",
                    ),
                    autofocus: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "备注:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextField(
                    controller: _remarkController,
                    decoration: const InputDecoration(
                      hintText: "请输入备注",
                    ),
                    autofocus: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() async {
    if (_nameController.text.isEmpty) {
      "名称不能为空".toast();
      return;
    }
    if (_valueController.text.isEmpty) {
      "值不能为空".toast();
      return;
    }

    envBean.name = _nameController.text;
    envBean.value = _valueController.text;
    envBean.remarks = _remarkController.text;
    HttpResponse<NullResponse> response = await Api.addEnv(
        _nameController.text, _valueController.text, _remarkController.text,
        id: envBean.id,nId: envBean.nId,);

    if (response.success) {
      (envBean.sId == null) ? "新增成功" : "修改成功".toast();
      ref.read(envProvider).updateEnv(envBean);
      Navigator.of(context).pop();
    } else {
      (response.message ?? "").toast();
    }
  }
}
