import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TGLJDetailPage extends StatefulWidget {
  String url;

  TGLJDetailPage({Key key, @required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TGLJDetailPageState(url);
}

class TGLJDetailPageState extends State<TGLJDetailPage> {
  String _url;
  bool loaded = false;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  TGLJDetailPageState(@required this._url);

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("_url:"+_url);
    List<Widget> titleContent = [];
    titleContent.add(new Text(
      "谈股论金",
      style: new TextStyle(color: Colors.white),
    ));
    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0));
    return new WebviewScaffold(
      url: this._url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
