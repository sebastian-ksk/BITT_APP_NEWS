import 'package:bit_app/models/news.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bit_app/util/services/Persisters.dart' as globals;
import 'dart:convert';

class ApiService {
  String UrlForApi(optionUrl) {
    //==========API GET para captura de nocticias dese APINEWS==================
    //https://newsapi.org/ hay que registrarse para obtener un token de recepcion
    //==========================================================================
    switch (optionUrl) {
      //All articles about Tesla from the last month, sorted by recent first
      case 1:
        return 'http://newsapi.org/v2/everything?q=tesla&from=2021-02-01&sortBy=publishedAt&apiKey=d03cc61aff3941b6892cc06a05c29c34';
      //Top business headlines in the US right now
      case 2:
        return 'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d03cc61aff3941b6892cc06a05c29c34';
      //All articles mentioning Apple from yesterday, sorted by popular publishers first
      case 3:
        return 'http://newsapi.org/v2/everything?q=apple&from=2021-02-22&to=2021-02-22&sortBy=popularity&apiKey=d03cc61aff3941b6892cc06a05c29c34';
      //Top headlines from TechCrunch right now
      case 4:
        return 'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d03cc61aff3941b6892cc06a05c29c34';
      //All articles published by the Wall Street Journal in the last 6 months, sorted by recent first
      case 5:
        return 'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=d03cc61aff3941b6892cc06a05c29c34';
    }
  }

  //=====================FUNCION PARA OPTENER JSON API=========================
  GetDio({@required int optionUrl}) async {
    //funcion de tipo asincrona
    var dio = Dio(); //mientrtas se ejecuta se ejecutan
    //otras tareas

    Response response = await dio.get(UrlForApi(optionUrl));
    if (response.statusCode == 200) {
      //si fue igual a 200 realiza la decodificacion
      return NewsApiModel.fromjson(response.data);
    } else {
      //si no retorna el error
      print('URL ERROR....');
    }
  }

  GetJsonSh() async {
    //respuesta para las noticias favoritas elejidas por el usuario
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //espera a la lista de noticias preferidas por el usurario
    List<String> FavoriteList = prefs.getStringList('FavoriteList') ?? [];
    //se obtiene la lista de noticias
    List<News> articlesListSend = List<News>(); //transformacion a tipo news
    FavoriteList.forEach((element) {
      dynamic jsonCONVERT = json.decode(element);
      articlesListSend.add(News.fromjson(jsonCONVERT));
    }); //conversion y adiccion de cada noticia a la lista
    return articlesListSend; // retorna la lista
  }
}
