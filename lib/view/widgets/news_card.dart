import 'dart:convert';
import 'package:bit_app/models/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bit_app/view/favoriteList.dart';
import 'package:dio/dio.dart';

class NewsCard extends StatefulWidget {
  final News news;
  NewsCard({Key key, @required this.news});

  @override
  _ItemListState createState() => _ItemListState();
}

//==============================CARDS DE NOTICIAS===============================
class _ItemListState extends State<NewsCard> {
  bool PressHeart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344,
      height: MediaQuery.of(context).size.height / 1.72,
      margin: EdgeInsets.only(top: 15),
      //===================DECORACION DEL CONTENEDOR ===========================
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            //sombreado
            BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black12)
          ]),
      //========================================================================
      child: Column(
        children: [
          //====================CARDS DE NOTICIAS===============================
          //====================IMAGEN DE LA NOTICIA============================
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: widget.news.urlToImage != null
                        ? NetworkImage(widget.news.urlToImage)
                        : AssetImage('assets/img/backbit.png'))),
          ),
          //====================================================================
          //============================ CAJA DE TEXTO =========================
          Flexible(
            //para que los textos no se limiten a los margenes
            child: Container(
              padding: EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, //alineacion central
                children: [
                  //=================== TITULO DE LA NOTICIA ====================
                  Text(widget.news.title ?? 'Title not find',
                      maxLines: 3, //maximo de lineas
                      style: GoogleFonts.signika(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  // ===================AUTOR DEL ARTICULO =====================
                  Text(widget.news.author ?? 'Author not find',
                      style: GoogleFonts.signika(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.normal)),
                  // ===========================================================
                  Container(
                    height: 10,
                  ),
                  // =================== DESCRIPCION DEL TEXTO =================
                  Text(widget.news.description ?? 'Description not find',
                      maxLines: 3,
                      style: GoogleFonts.signika(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal)),
                  // ===========================================================
                ],
              ),
            ),
          ),
          //====================================================================
          //==============CONTENEDOR DE FAVORITOS Y LECTURA COMPLETA ===========
          Container(
            margin: EdgeInsets.only(right: 13, left: 13), //mergen interna
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //===================ICONO DE CORAZON ========================
                  IconButton(
                      icon: PressHeart != true
                          ? Icon(Ionicons.heart_outline)
                          : Icon(Ionicons.heart),
                      onPressed: () {
                        setState(() {
                          PressHeart = !PressHeart;
                          _saveFavoriteList(SnapshotReceive: widget.news);
                        });
                        print("favorito");
                      }),
                  //============================================================
                  //===================BOTON DE VER MAS ========================
                  InkWell(
                    //le da gestos a todo widget
                    onTap: () {
                      print("ver mas ...");
                      Navigator.pushNamed(context, '/preview',
                          arguments: widget.news);
                    },
                    child: Text(
                      'MORE>',
                      style: GoogleFonts.signika(
                          fontSize: 14,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                  // ===========================================================
                ],
              ),
            ),
          )
          // ===================================================================
        ],
      ),
    );
  }

  //=================almacenamiento de noticias favoritas=======================
  _saveFavoriteList({@required News SnapshotReceive}) async {
    //espera a lista de favoritos
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //convesion a list
    List<String> FavoriteList = prefs.getStringList('FavoriteList') ?? [];
    //adicion a lista de favoritos
    FavoriteList.add(json.encode(SnapshotReceive.toJson()));
    //espera por lista de favoritos
    await prefs.setStringList('FavoriteList', FavoriteList);
  }
}
