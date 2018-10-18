import 'package:flutter/material.dart';
import 'package:flutter_app/calculate/CalculateButton.dart';

typedef void CalculateButtonClickListener(CalculateDisplay display);

const OPERATE = ["+", "-", "*", "/"];

class CalculatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculatePageState();
}

class CalculatePageState extends State<CalculatePage> {
  String resultValue;
  String operateValue = "";

  onNumBerButtonClick(CalculateDisplay display) {
    setState(() {
      switch (display.type) {
        case OPERATORTYPE:
          operateValue = operateValue + display.value.toString();
          break;

        case RESULTTYPE:
          if (display.value == "=") {
            resultValue = calculateValue(operateValue).toString();
            operateValue = "";
          } else if (display.value == "C") {
            if (operateValue.length > 0) {
              operateValue = operateValue.substring(0, operateValue.length - 1);
            }
          }
          break;

        case NUMBERTYPE:
          operateValue = operateValue + display.value.toString();
          ;
          break;
      }
      print("operateValue:" + (operateValue == null ? "null" : operateValue));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("计算器"),
        iconTheme: new IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new ResultView(value: resultValue),
            new InputView(value: operateValue),
            new OperateView(
              onClick: onNumBerButtonClick,
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * 输出结果viewflutter run --release
 */
class ResultView extends StatelessWidget {
  String value;

  ResultView({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: new Container(
          child: new Text(
            value ?? "0",
            style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          color: Colors.greenAccent,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        ),
      ),
      flex: 3,
    );
  }
}

/**
 * 输入显示view
 */
class InputView extends StatelessWidget {
  String value;

  InputView({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: new Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          color: Colors.black12,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                child: new Text(
                  value ?? "",
                  style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              )
            ],
          ),
        ),
      ),
      flex: 2,
    );
  }
}

/**
 * 操作区域view
 */
class OperateView extends StatelessWidget {
  CalculateButtonClickListener onClick;

  OperateView({Key key, @required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        child: new Column(
          children: <Widget>[
            OperateLine(array: [
              NumberButton(CalculateDisplay("1", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay("2", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay("3", NUMBERTYPE), onClick),
            ]),
            OperateLine(array: [
              NumberButton(CalculateDisplay("4", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay("5", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay("6", NUMBERTYPE), onClick),
            ]),
            OperateLine(array: [
              NumberButton(CalculateDisplay("7", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay("8", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay("9", NUMBERTYPE), onClick),
            ]),
            OperateLine(array: [
              NumberButton(CalculateDisplay("", NUMBERTYPE), null),
              NumberButton(CalculateDisplay("0", NUMBERTYPE), onClick),
              NumberButton(CalculateDisplay(".", NUMBERTYPE), onClick),
            ]),
            OperateLine(array: [
              OperatorButton(CalculateDisplay(OPERATE[0], OPERATORTYPE),
                  Colors.redAccent, onClick),
              OperatorButton(CalculateDisplay(OPERATE[1], OPERATORTYPE),
                  Colors.greenAccent, onClick),
              OperatorButton(CalculateDisplay(OPERATE[2], OPERATORTYPE),
                  Colors.orangeAccent, onClick),
              OperatorButton(CalculateDisplay(OPERATE[3], OPERATORTYPE),
                  Colors.blueAccent, onClick),
            ]),
            OperateLine(array: [
              ResultButton(
                  CalculateDisplay("C", RESULTTYPE), Colors.cyan, onClick),
              ResultButton(
                  CalculateDisplay("=", RESULTTYPE), Colors.brown, onClick),
            ]),
          ],
        ),
      ),
      flex: 10,
    );
  }
}

class OperateLine extends StatelessWidget {
  List<Widget> array;

  OperateLine({@required this.array}) : assert(array != null);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: array,
    );
  }
}

///数字键盘
class NumberButton extends CalculateButton {
  CalculateButtonClickListener onClick;

  NumberButton(CalculateDisplay display, this.onClick) : super(display) {
    height = 58.0;
    width = 40.0;
    textSize = 18.0;
    fontWeight = FontWeight.bold;
    padding = EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0);
    showBorder = true;
  }

  @override
  onPressed(display) => onClick != null ? onClick(display) : null;
}

///运算符
class OperatorButton extends CalculateButton {
  CalculateButtonClickListener onClick;

  OperatorButton(CalculateDisplay display, Color _bgcolor, this.onClick)
      : super(display) {
    height = 80.0;
    width = 30.0;
    textSize = 30.0;
    buttonColor = _bgcolor;
    textColor = Colors.white;
    fontWeight = FontWeight.normal;
    margin = EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0);
    showBorder = false;
    shape = CircleBorder(
        side:
            BorderSide(color: _bgcolor, style: BorderStyle.solid, width: 1.0));
  }

  @override
  onPressed(display) => onClick != null ? onClick(display) : null;
}

///结算操作按钮
class ResultButton extends CalculateButton {
  CalculateButtonClickListener onClick;

  ResultButton(CalculateDisplay display, Color _bgcolor, this.onClick)
      : super(display) {
    height = 60.0;
    width = 60.0;
    textSize = 30.0;
    textColor = _bgcolor;
    fontWeight = FontWeight.normal;
    margin = EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0);
    showBorder = false;
    shape = BeveledRectangleBorder(
        borderRadius: BorderRadius.all(new Radius.circular(5.0)),
        side:
            BorderSide(color: _bgcolor, style: BorderStyle.solid, width: 1.0));
  }

  @override
  onPressed(display) => onClick != null ? onClick(display) : null;
}
