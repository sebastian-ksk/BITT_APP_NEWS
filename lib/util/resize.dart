import 'package:flutter/material.dart';

double ResizerH({@required double MediaQ, @required double Size}) {
  var result = MediaQ / Size;
  return MediaQ / result;
}
