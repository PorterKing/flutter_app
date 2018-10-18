import 'package:flutter/material.dart';
import 'package:flutter_app/calculate/CalculatePage.dart';

const int NUMBERTYPE = 1, OPERATORTYPE = 2, RESULTTYPE = 3;

class CalculateDisplay {
  String value;
  int type;

  CalculateDisplay(this.value, this.type);
}

abstract class CalculateButton extends StatelessWidget {
  CalculateDisplay display;
  var height;
  var width;
  var textSize;
  FontWeight fontWeight = FontWeight.normal;
  bool showBorder = false;
  Color buttonColor = Colors.white;
  Color textColor = Colors.black26;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  ShapeBorder shape;

  CalculateButton(@required this.display);

  onPressed(CalculateDisplay value);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        padding: margin,
        height: height,
        child: new RaisedButton(
          color: buttonColor,
          padding: padding,
          child: new Container(
            width: width,
            alignment: Alignment.center,
            child: new Text(
              (display == null || display.value == null) ? "" : display.value,
              style: new TextStyle(
                  color: textColor, fontSize: textSize, fontWeight: fontWeight),
            ),
          ),
          onPressed: () {
            onPressed(display);
          },
          shape: shape,
        ),
        decoration: showBorder
            ? new BoxDecoration(
                border: new Border.all(
                    color: Colors.grey, width: 0.5, style: BorderStyle.solid))
            : null,
      ),
      flex: 1,
    );
  }
}
///计算结果
double calculateValue(String content) {
  if (content == null || content.length < 1) return -1.0;
  // 找到字符串中最后一个左括号
  int startIndex = content.lastIndexOf("(");
  // 如果不是-1,标识这个等式中有括号,继续找与之对应的右括号
  if (startIndex != -1) {
    // 从左括号的位置开始找,找到第一个右括号,这对括号里面一定没有括号 进入递归
    int endIndex = content.indexOf(")", startIndex);
    if(endIndex == -1) return -1.0;
    double d = calculateValue(content.substring(startIndex + 1, endIndex));
    return calculateValue(content.substring(0, startIndex) +
        d.toString() +
        content.substring(endIndex + 1));
  }
  //从左边开始遍历 "+"
  int index = content.indexOf(OPERATE[0]);
  if (index != -1) {
    return calculateValue(content.substring(0, index)) +
        calculateValue(content.substring(index + 1));
  }
  //从右边开始遍历 "-"
  index = content.lastIndexOf(OPERATE[1]);
  if (index != -1) {
    return calculateValue(content.substring(0, index)) -
        calculateValue(content.substring(index + 1));
  }
  //从左边开始遍历 "*"
  index = content.indexOf(OPERATE[2]);
  if (index != -1) {
    return calculateValue(content.substring(0, index)) *
        calculateValue(content.substring(index + 1));
  }
  //从右边开始遍历 "/"
  index = content.lastIndexOf(OPERATE[3]);
  if (index != -1) {
    return calculateValue(content.substring(0, index)) /
        calculateValue(content.substring(index + 1));
  }

  return double.parse(content);
}
