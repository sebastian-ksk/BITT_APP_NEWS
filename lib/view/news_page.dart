import 'package:bit_app/data/news_repository.dart';
import 'package:bit_app/presenter/build_view.dart';
import 'package:bit_app/util/styles.dart';
import 'package:bit_app/view/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bit_app/util/services/firebaseController.dart'
    as firebaseController;

class NewsPage extends StatefulWidget {
  User user;

  NewsPage(this.user);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int Newsint = 1; //indicador de que tipo de noticias mostrar
  String TitleAppBar = 'BIT News'; //titulo de la barra superior
  String viewName = 'NewsList'; //palabra clave para mostrar las noticias

  Widget _selector_News(String tittle, int intNew) {
    return InkWell(
      onTap: () {
        setState(() {
          Newsint = intNew;
          viewName = 'NewsList';
          TitleAppBar = tittle;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Text(
          tittle,
          style: Styles.drawerOptionStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //======================Barra superior de noticias========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          TitleAppBar,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.signika(
              fontSize: 20,
              color: Colors.black45,
              fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Ionicons.heart,
                color: Colors.black87,
              ),
              onPressed: () {
                setState(() {
                  print('favorite list ');
                  viewName = "FavoriteList";
                  Newsint = 0;
                  TitleAppBar = "Favorite's List";
                });
              })
        ],
      ),
      //========================================================================
      //=====================Barra lateral de navegacion========================
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //=====================Logo de bir news ============================
            DrawerHeader(
              child: Container(
                height: MediaQuery.of(context).size.height / 12,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/img/BitLogo.png'),
                  fit: BoxFit.contain,
                )),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            //==================================================================
            ListTile(
              title: Text(
                'News',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            //===============TESLA ARTICULOS ==================================
            _selector_News(
                '> All articles about Tesla from the last month, sorted by recent first',
                1),
            //==================================================================
            // ==================ARTICULOS DE NEGOCIOS =========================
            _selector_News(
              '> Top business headlines in the US right now',
              2,
            ),
            // =================================================================
            //=========================APPLE ARTICULOS =========================
            _selector_News(
              '> All articles mentioning Apple from yesterday, sorted by popular publishers first',
              3,
            ),
            // =================================================================
            //========================TECH ARTICULOS ===========================
            _selector_News(
              '> Top headlines from TechCrunch right now',
              4,
            ),
            //==================================================================
            //========================WALL STREE ARTICULOS =====================
            _selector_News(
              'All articles published by the Wall Street Journal in the last 6 months, sorted by recent first',
              5,
            ),
            //==================================================================
            Divider(), //linea que marca una division de tablero
            ListTile(
              title: Text(
                'SETTINGS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                '<< SING OUT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                firebaseController.signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      //========================================================================

      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        //llamado a recontructor de vista
        child: BuildView(viewName: viewName, intNews: Newsint),
      ),
    );
  }

  void onGetDescargosError(String string) {}
}
