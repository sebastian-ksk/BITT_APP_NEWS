import 'package:bit_app/models/news.dart';
import 'package:bit_app/view/widgets/news_card.dart';
import 'package:flutter/material.dart';

//==================CONSTRUCTOR DE LISTA DE ITEMS ==============================
class buildItemList extends StatelessWidget {
  final News snapshotData;
  buildItemList({Key key, @required this.snapshotData});

  @override
  Widget build(BuildContext context) {
    return NewsCard(
      news: snapshotData,
    );
  }
}
//==============================================================================
