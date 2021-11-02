import 'package:flutter/material.dart';

class ButtonDefault extends StatelessWidget {

  final String _hintText;
  final VoidCallback _clickFunction;
  final Color _colorButton;
  final double _heightSize;
  final double _widthSize;
  final Widget _sufixImage;
  final Widget _prefixImage;
  final double _fontSize;
  final Color _colorBorder;
  final Color _colorFont;
  final double _radioBorder;
  final Color _splashColor;
  final FontWeight _fontWeight;
  
  const ButtonDefault({
    Key key, 
    String hintText : '',
    VoidCallback clickFunction,
    Color colorButton : Colors.blue,
    double heightSize : 0.08,
    double widthSize : 0.35,
    double fontSize : 0.03,
    Widget sufixImage,
    Widget prefixImage,
    Color colorBorder,
    Color colorFont,
    double radioBorder : 0.05,
    Color splashColor : Colors.blue,
    FontWeight fontWeight : FontWeight.normal
  }): 
    _fontWeight = fontWeight,
    _hintText = hintText,
    _clickFunction = clickFunction,
    _colorButton = colorButton,
    _heightSize = heightSize,
    _widthSize = widthSize,
    _sufixImage = sufixImage,
    _prefixImage = prefixImage,
    _fontSize = fontSize,
    _colorBorder = colorBorder,
    _colorFont = colorFont,
    _radioBorder = radioBorder,
    _splashColor = splashColor,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: _colorButton,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.height*_radioBorder),
          topRight: Radius.circular(size.height*_radioBorder),
          bottomLeft: Radius.circular(size.height*_radioBorder),
          bottomRight: Radius.circular(size.height*_radioBorder)
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height*_radioBorder),
          border: _colorBorder != null ? Border.all(color: _colorBorder, width: size.height*.002) : null
        ),
        width: size.width * _widthSize,
        height: size.height * _heightSize,
        child: InkWell(
          borderRadius: BorderRadius.circular(size.height*_radioBorder),
          splashColor: _splashColor,
          onTap: _clickFunction,
          child: Row(
            children: [
              Expanded(flex: 1, child: _prefixImage != null ? _prefixImage : Container()),
              Expanded(flex: 3, child: Center(child: Text(_hintText, textAlign: TextAlign.center, style: TextStyle(color: _colorFont != null ? _colorFont : Colors.white, fontSize: size.height*_fontSize, fontWeight: _fontWeight)))),
              Expanded(flex: 1, child: _sufixImage != null ? _sufixImage : Container())
            ],
          ), 
        ),
      ),
    );
  }
}