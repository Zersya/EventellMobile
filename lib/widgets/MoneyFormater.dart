import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class MoneyFormater extends StatelessWidget {

  final money;
  final textStyle;

  const MoneyFormater({Key key, this.money, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      FlutterMoneyFormatter(
          amount: money.toDouble(),
          settings: MoneyFormatterSettings(
            symbol: 'Rp. ',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 2,
          )).output.symbolOnLeft,
      style: textStyle,
    );
  }
}
