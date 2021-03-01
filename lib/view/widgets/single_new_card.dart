import 'package:bit_app/models/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleNewCard extends StatelessWidget {
  final News news;
  const SingleNewCard({Key key, @required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //====================IMAGEN DE LA NOTICIA============================
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: news.urlToImage != null
                    ? NetworkImage(news.urlToImage)
                    : AssetImage('assets/img/backbit.png'),
              ),
            ),
          ),
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
                  Text(news.title ?? 'Title not find',
                      maxLines: 3, //maximo de lineas
                      style: GoogleFonts.signika(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Container(
                    height: 10,
                  ),
                  // =================== DESCRIPCION DEL TEXTO =================
                  Text(news.content ?? 'Description not find',
                      maxLines: 3,
                      style: GoogleFonts.signika(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal)),
                  // ===========================================================
                  // ===================AUTOR DEL ARTICULO =====================
                  Text(news.author ?? 'Author not find',
                      style: GoogleFonts.signika(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.normal)),
                  // ===========================================================
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
