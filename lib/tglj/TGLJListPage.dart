import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/NetUtils.dart';
import 'package:flutter_app/tglj/TGLJItemView.dart';

class TGLJListPage extends StatefulWidget {
  TGLJListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TGLJListPageStae();
  }
}

class TGLJListPageStae extends State<TGLJListPage> {
  final DEFAULT_REQUEST_NUM = 20;
  var listData;
  var listTotalSize = 0;
  var curPage = 1;
  //滚动监听
  ScrollController _controller = new ScrollController();

  TGLJListPageStae() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      //滑动到底部  触发上拉加载
      if (maxScroll == pixels) {
        // scroll to bottom, get next page data
        print("load more ... ");
        curPage++;
        getNewsList(true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getNewsList(false);
  }

  /**
   * 下拉刷新
   */
  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  getNewsList(bool isLoadMore) {
    String url =
        "https://tmall.stocke.com.cn:8602/hexinifs/rs/cms/discussion/getDiscussionList";
    Map<String, String> params = new Map();
    params['page.page'] = "$curPage";
    params['page.size'] = "$DEFAULT_REQUEST_NUM";

    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> dataMap = json.decode(data);
        print(dataMap.toString());
        if (dataMap['flag']) {
          var _listData = dataMap['data']['content'];
          setState(() {
            if (!isLoadMore) {
              listData = _listData;
            } else {
              listData.addAll(_listData);
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _bodyView;
    if (listData == null) {
      _bodyView = new EmptyView();
    } else {
      _bodyView = new RefreshIndicator(
          child: new ListView.builder(
            itemCount: listData.length * 2,
            controller: _controller,
            itemBuilder: (context, index) {
              index -= 1;
              if (index.isOdd) {
                // 在每一列之前，添加一个1像素高的分隔线widget
                return new Container(
                  height: 0.5,
                  color: Color(0xFFeeeeee),
                  margin: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                );
              }
              index = index ~/ 2;
              return new TGLJItemView(listData[index]);
            },
          ),
          onRefresh: _pullToRefresh);
      ;
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("谈股论金"),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: _bodyView,
    );
  }
}

/**
 * 空数据展位图
 */
class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Text("数据为空"),
    );
  }
}
