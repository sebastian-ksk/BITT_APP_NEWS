import 'package:flutter/material.dart';

//constantes de colores y cajas de decoracion
final kHintTextStyle = TextStyle(
  color: Colors.black26,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  border: Border.all(
    color: Colors.black,
    width: 2,
  ),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);
