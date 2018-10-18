import 'package:flutter/material.dart';
import 'package:flutter_app/tglj/TGLJDetailPage.dart';
import 'package:flutter_app/utils/Utils.dart';

/**
 * item view
 */
class TGLJItemView extends StatelessWidget {
  var dataItem;

  TGLJItemView(@required this.dataItem) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new TGLJDetailPage(
                    url: dataItem['newattactPath'] +"?id="+
                        dataItem['id'].toString())));
      },
      child: new Container(
        margin: EdgeInsets.fromLTRB(17.0, 12.0, 17.0, 12.0),
        height: 66.0,
        child: new Row(
          children: <Widget>[
            new Image.network(
              dataItem['imgUrl'],
              width: 100.0,
              height: 66.0,
              fit: BoxFit.fill,
            ),
            new Padding(padding: new EdgeInsets.all(5.0)),
            new Expanded(
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: ConstrainedBox(
                      constraints: new BoxConstraints.expand(),
                      child: new Text(
                        dataItem['title'],
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style:
                        new TextStyle(color: Colors.black, fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    flex: 3,
                  ),
                  new Expanded(
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Expanded(
                          child: new Text(ReadableTime(dataItem['createTime']),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  color: Colors.grey, fontSize: 14.0)),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new Text(
                              dataItem['commentNum'].toString() + "条评论",
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  color: Colors.grey, fontSize: 14.0)),
                          flex: 1,
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}