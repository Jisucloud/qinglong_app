import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qinglong_app/base/ql_app_bar.dart';
import 'package:qinglong_app/module/others/subscription/subscription_bean.dart';
import 'package:qinglong_app/module/others/subscription/subscription_time_log_page.dart';

import '../../../base/http/api.dart';
import '../../../base/routes.dart';
import '../../../base/theme.dart';
import '../../task/task_viewmodel.dart';

class SubscriptionDetailPage extends StatefulWidget {
  final Subscription bean;
  final bool hideAppbar;

  const SubscriptionDetailPage(this.bean, {Key? key, this.hideAppbar = false})
      : super(key: key);

  @override
  State<SubscriptionDetailPage> createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {

  List<Widget> actions = [];


  @override
  void initState() {
    super.initState();
    //actions.clear();
    actions.addAll(
      [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            Navigator.of(context).pop();
            if (widget.bean.status! == 1) {
              await startCron(context);
            } else {
              await stopCron(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Text(
                widget.bean.status! == 1 ? "运行" : "停止运行",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
            showLog();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            alignment: Alignment.center,
            child: const Material(
              color: Colors.transparent,
              child: Text(
                "查看日志",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QlAppBar(
        title: "订阅管理",
        canBack: true,
        actions: [
          InkWell(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Container(
                        alignment: Alignment.center,
                        child: const Material(
                          color: Colors.transparent,
                          child: Text(
                            "更多操作",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      actions: actions,
                      cancelButton: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: const Material(
                            color: Colors.transparent,
                            child: Text(
                              "取消",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Center(
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskDetailCell(
              title: "名称",
              desc: widget.bean.name,
            ),
            TaskDetailCell(
              title: "仓库类型",
              desc: widget.bean.type == "public-repo"
                  ? "公开仓库"
                  : widget.bean.type == "private-repo"
                      ? "私有仓库"
                      : "单文件",
            ),
            TaskDetailCell(
              title: "链接",
              desc: widget.bean.url ?? "",
            ),
            TaskDetailCell(
              title: "分支",
              desc: widget.bean.branch ?? "",
            ),
            TaskDetailCell(
              title: "定时类型",
              desc: widget.bean.scheduleType ?? "",
            ),
            TaskDetailCell(
              title: "定时规则",
              desc: widget.bean.scheduleType == "crontab"
                  ? widget.bean.schedule ?? ""
                  : widget.bean.intervalSchedule!.type == "days"
                      ? "每" + widget.bean.intervalSchedule!.value.toString() + "天"
                      : widget.bean.intervalSchedule!.type == "hours"
                          ? "每" +
                              widget.bean.intervalSchedule!.value.toString() +
                              "小时"
                          : widget.bean.intervalSchedule!.type == "minutes"
                              ? "每" +
                                  widget.bean.intervalSchedule!.value.toString() +
                                  "分钟"
                              : "每" +
                                  widget.bean.intervalSchedule!.value.toString() +
                                  "秒",
            ),
            TaskDetailCell(
              title: "白名单",
              desc: widget.bean.whitelist ?? "",
            ),
            TaskDetailCell(
              title: "黑名单",
              desc: widget.bean.blacklist ?? "",
            ),
            TaskDetailCell(
              title: "依赖文件",
              desc: widget.bean.dependences ?? "",
            ),
            TaskDetailCell(
              title: "文件后缀",
              desc: widget.bean.extensions ?? "",
            ),
            TaskDetailCell(
              title: "执行前",
              desc: widget.bean.subAfter ?? "",
            ),
            TaskDetailCell(
              title: "执行后",
              desc: widget.bean.subBefore ?? "",
            ),
          ],
        ),
      ),
    );
  }

  startCron(BuildContext context) async {
    await Api.startSubscription([widget.bean.id!]);
    setState(() {});
    showLog();
  }

  stopCron(BuildContext context) async {
    await Api.stopSubscription([widget.bean.id!]);
    setState(() {});
  }

  void showLog() {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          SubscriptionTimeLogPage(
            widget.bean.id!,
            true,
            widget.bean.name ?? "",
          ),
    );
  }
}

class TaskDetailCell extends ConsumerWidget {
  final String title;
  final String? desc;
  final Widget? icon;
  final bool hideDivide;
  final Function? taped;

  const TaskDetailCell({
    Key? key,
    required this.title,
    this.desc,
    this.icon,
    this.hideDivide = false,
    this.taped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 15,
            right: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ref.watch(themeProvider).themeColor.titleColor(),
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              desc != null
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SelectableText(
                          desc!,
                          textAlign: TextAlign.right,
                          selectionHeightStyle: BoxHeightStyle.max,
                          selectionWidthStyle: BoxWidthStyle.max,
                          onTap: () {
                            if (taped != null) {
                              taped!();
                            }
                          },
                          style: TextStyle(
                            color:
                                ref.watch(themeProvider).themeColor.descColor(),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child:
                          Align(alignment: Alignment.centerRight, child: icon!),
                    ),
            ],
          ),
        ),
        hideDivide
            ? const SizedBox.shrink()
            : const Divider(
                indent: 15,
              ),
      ],
    );
  }


}
