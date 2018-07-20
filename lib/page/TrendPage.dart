import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/dao/ReposDao.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/NavigatorUtils.dart';
import 'package:gsy_github_app_flutter/widget/GSYCardItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYListState.dart';
import 'package:gsy_github_app_flutter/widget/GSYPullLoadWidget.dart';
import 'package:gsy_github_app_flutter/widget/ReposItem.dart';

/**
 * 主页趋势tab页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class TrendPage extends StatefulWidget {
  @override
  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends GSYListState<TrendPage> {
  _renderItem(ReposViewModel e) {
    return new ReposItem(e, onPressed: () {
      NavigatorUtils.goReposDetail(context, e.ownerName, e.repositoryName);
    });
  }

  _renderHeader() {
    return new GSYCardItem(
      color: Color(GSYColors.primaryValue),
      margin: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: new Padding(
        padding: new EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        child: new Row(
          children: <Widget>[
            _renderHeaderPopItem("aaa", [new TrendTypeModel("fff", "fff"), new TrendTypeModel("fff", "fff")], (TrendTypeModel result) {
              setState(() {});
            }),
            new Container(height: 10.0, width: 0.5, color: Colors.white),
            _renderHeaderPopItem("bbb", [new TrendTypeModel("fff", "fff"), new TrendTypeModel("fff", "fff")], (TrendTypeModel result) {
              setState(() {});
            }),
          ],
        ),
      ),
    );
  }

  _renderHeaderPopItem(String data, List<TrendTypeModel> list, PopupMenuItemSelected<TrendTypeModel> onSelected) {
    return new Expanded(
      child: new PopupMenuButton<TrendTypeModel>(
        child: new Center(child: new Text(data, style: GSYConstant.middleTextWhite)),
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return _renderHeaderPopItemChild(list);
        },
      ),
    );
  }

  _renderHeaderPopItemChild(List<TrendTypeModel> data) {
    List<PopupMenuEntry<TrendTypeModel>> list = new List();
    for (TrendTypeModel item in data) {
      list.add(PopupMenuItem<TrendTypeModel>(
        value: item,
        child: new Text(item.name),
      ));
    }
    return list;
  }

  @override
  requestRefresh() async {
    return await ReposDao.getTrendDao(since: 'daily');
  }

  @override
  requestLoadMore() async {
    return null;
  }

  @override
  bool get isRefreshFirst => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new Scaffold(
      backgroundColor: Color(GSYColors.mainBackgroundColor),
      appBar: new AppBar(
        flexibleSpace: _renderHeader(),
        backgroundColor: Color(GSYColors.mainBackgroundColor),
        leading: new Container(),
        elevation: 0.0,
      ),
      body: GSYPullLoadWidget(
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderItem(pullLoadWidgetControl.dataList[index]),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}

class TrendTypeModel {
  final String name;
  final String value;

  TrendTypeModel(this.name, this.value);
}
