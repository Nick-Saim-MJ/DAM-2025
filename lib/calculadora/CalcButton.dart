import 'package:flutter/material.dart';
class CalcButton extends StatelessWidget {
  final String? text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function? callback;
  const CalcButton({
    Key? key,
    this.text,
    this.fillColor = 0xFFFFB74D,
    this.textColor = 0xFF6C807F,
    this.textSize = 20,
    this.callback,
  }) : super(key: key);
//Aquí Codigo

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 70,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary, backgroundColor: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: () {
            callback!(text);
          },
          child: Text(
            text!,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
}
}
