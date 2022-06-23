import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:highlight/languages/routeros.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qinglong_app/base/http/http.dart';
import 'package:qinglong_app/base/ql_app_bar.dart';
import 'package:qinglong_app/module/others/subscription/subscription_bean.dart';
import 'package:qinglong_app/module/others/subscription/subscription_time_log_page.dart';
import 'package:qinglong_app/utils/extension.dart';

import '../../../base/http/api.dart';
import '../../../base/routes.dart';
import '../../../base/theme.dart';
import '../../../base/ui/empty_widget.dart';
import '../../../base/ui/lazy_load_state.dart';

class SubscriptionPage extends ConsumerStatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _ScriptPageState createState() => _ScriptPageState();
}

class _ScriptPageState extends ConsumerState<SubscriptionPage> with LazyLoadState<SubscriptionPage> {
  List<Subscription> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QlAppBar(
        title: "订阅管理",
        canBack: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                Routes.routerSubscriptionAdd,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.add,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          return loadData();
        },
        child: list.isEmpty
            ? const EmptyWidget()
            : ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (context, index) {
                  Subscription item = list[index];
                  return SubscriptionCell(list[index], index, ref);
                },
                itemCount: list.length,
              ),
      ),
    );
  }

  Future<void> loadData() async {
    HttpResponse<List<Subscription>> response = await Api.getSubscription();

    if (response.success) {
      if (response.bean == null || response.bean!.isEmpty) {
        "暂无数据".toast();
      }
      list.clear();
      list.addAll(response.bean ?? []);
      setState(() {});
    } else {
      response.message?.toast();
    }
  }

  @override
  void onLazyLoad() {
    loadData();
  }
}

class SubscriptionCell extends StatelessWidget {
  final Subscription bean;
  final int index;
  final WidgetRef ref;

  const SubscriptionCell(this.bean, this.index, this.ref, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ref.watch(themeProvider).themeColor.settingBgColor(),
      child: Slidable(
          key: ValueKey(bean.id),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.7,
            children: [
              SlidableAction(
                backgroundColor: const Color(0xff5D5E70),
                onPressed: (_) {
                  WidgetsBinding.instance.endOfFrame.then((timeStamp) {
                    Navigator.of(context).pushNamed(Routes.routerSubscriptionAdd, arguments: bean);
                  });
                },
                foregroundColor: Colors.white,
                icon: CupertinoIcons.pencil_outline,
              ),
              SlidableAction(
                backgroundColor: const Color(0xffA356D6),
                onPressed: (_) {
                  changeSubscriptionEnable();
                },
                foregroundColor: Colors.white,
                icon: bean.isDisabled == null || bean.isDisabled == 0 ? Icons.dnd_forwardslash : Icons.check_circle_outline_sharp,
              ),
              SlidableAction(
                backgroundColor: const Color(0xffEA4D3E),
                onPressed: (_) {
                  Api.deleteSubscription([bean.id!]);
                },
                foregroundColor: Colors.white,
                icon: CupertinoIcons.delete,
              ),
            ],
          ),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                backgroundColor: const Color(0xffD25535),
                onPressed: (_) {
                  changeSubscriptionStatus();
                },
                foregroundColor: Colors.white,
                icon: bean.status! == 1 ? CupertinoIcons.memories : CupertinoIcons.stop_circle,
              ),
              SlidableAction(
                backgroundColor: const Color(0xff606467),
                onPressed: (_) {
                  Future.delayed(
                      const Duration(
                        milliseconds: 250,
                      ), () {
                    showLog(context);
                  });
                },
                foregroundColor: Colors.white,
                icon: CupertinoIcons.text_justifyleft,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.routerSubscriptionDetail, arguments: bean);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                bean.status == 1
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: ref.watch(themeProvider).primaryColor,
                                        ),
                                      ),
                                SizedBox(
                                  width: bean.status == 1 ? 0 : 5,
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      bean.name ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: ref.watch(themeProvider).themeColor.titleColor(),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Text(
                              bean.branch!,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: ref.watch(themeProvider).themeColor.descColor(),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bean.isDisabled == 1
                              ? const Icon(
                                  Icons.dnd_forwardslash,
                                  size: 12,
                                  color: Colors.red,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 5,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Text(
                              bean.schedule ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: ref.watch(themeProvider).themeColor.descColor(),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Text(
                          bean.url ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: ref.watch(themeProvider).themeColor.descColor(),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  indent: 15,
                ),
              ],
            ),
          )),
    );
  }

  void showLog(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SubscriptionTimeLogPage(
        bean.id!,
        true,
        bean.name ?? "",
      ),
    );
  }

  Future<void> changeSubscriptionStatus() async {
    if (bean.status == null || bean.status == 0) {
      await Api.stopSubscription([bean.id!]);
    } else {
      await Api.startSubscription([bean.id!]);
    }
  }

  Future<void> changeSubscriptionEnable() async {
    if (bean.isDisabled == null || bean.isDisabled == 0) {
      await Api.disableSubscription([bean.id!]);
    } else {
      await Api.enableSubscription([bean.id!]);
    }
  }
}
