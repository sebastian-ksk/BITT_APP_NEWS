import 'package:bit_app/data/apiService.dart';
import 'package:bit_app/presenter/build_itemList.dart';
import 'package:flutter/material.dart';
import 'package:bit_app/util/services/errorPage.dart';
import 'package:bit_app/util/services/Persisters.dart' as globals;

class BuildView extends StatelessWidget {
  final String viewName;
  final int intNews;

  BuildView({Key key, @required this.viewName, @required this.intNews});

  @override
  Widget build(BuildContext context) {
    switch (viewName) {
      case 'NewsList':
        return Container(
          child: Center(
            child: Container(
              child: FutureBuilder(
                  //future es para expereincia de usuario
                  future: ApiService().GetDio(optionUrl: intNews),
                  builder: (context, snapshot) {
                    //el constructor trae un snapshot
                    if (snapshot.hasData) {
                      //si se retorno algo
                      return ListView.builder(
                        itemCount: (snapshot.data)
                            .articlesList
                            .length, //numero de items en al alista
                        itemBuilder: (BuildContext context, int index) {
                          //un index por cada articulo
                          // por cada item construye una tarjeta
                          return buildItemList(
                              snapshotData:
                                  (snapshot.data).articlesList[index]);
                        },
                      );
                      //si no se retorna un error de adqusiscion
                    } else if (snapshot.hasError) {
                      return Container();
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
        );
      //======================caso de lista de favoritos =======================
      case 'FavoriteList':
        return Container(
            child: Center(
          child: Container(
              child: FutureBuilder(
            //future widget para esperear una funcion asincrona antes de continuar
            //https://medium.com/comunidad-flutter/decodificando-futurebuilder-b2248b4a5207
            //informacion e link anterior.

            future: ApiService().GetJsonSh(),
            builder: (context, snapshot) {
              //mientras el snapshotData no este vacio se cargan las noticias
              //favoritas
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  //carga los datos en cards de noticias
                  itemBuilder: (BuildContext context, int index) {
                    return buildItemList(snapshotData: snapshot.data[index]);
                  },
                );
                //sino carga una imagen de error de busqueda de noticias favoritas
              } else if (snapshot.hasError) {
                this.onGetDescargosError(snapshot.error.toString());
                return ErrorPage();
              }
              //mientras se carga s muestra un indicador circular de carga
              return Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 500,
                child: Center(child: CircularProgressIndicator()),
              ));
              //==========================================================
            },
          )),
        ));
    }
  }

  void onGetDescargosError(String string) {}
}
