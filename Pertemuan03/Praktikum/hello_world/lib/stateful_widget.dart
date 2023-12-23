import 'package:flutter/material.dart';

class BiggerText extends StatefulWidget {
  final String text;

  const BiggerText({Key? key, required this.text}): super (key: key);

  @override
  _BiggerTextState createState() => _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(fontSize: _textSize),     
           ),
           ElevatedButton(
            child: Text(_textSize == 16.0 ? "Perbesar" : "Perkecil"),
            onPressed: () {
             setState(() {
             _textSize = _textSize == 16.0 ? 25.0 : 16.0;
});
},

)
],
);
}
}