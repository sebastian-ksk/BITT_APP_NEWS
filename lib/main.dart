//==============================================================================
//            ██████╗░██╗████████╗  ░░░░░░  ░█████╗░██████╗░██████╗░          //
//            ██╔══██╗██║╚══██╔══╝  ░░░░░░  ██╔══██╗██╔══██╗██╔══██╗          //
//            ██████╦╝██║░░░██║░░░  █████╗  ███████║██████╔╝██████╔╝          //
//            ██╔══██╗██║░░░██║░░░  ╚════╝  ██╔══██║██╔═══╝░██╔═══╝░          //
//            ██████╦╝██║░░░██║░░░  ░░░░░░  ██║░░██║██║░░░░░██║░░░░░          //
//            ╚═════╝░╚═╝░░░╚═╝░░░  ░░░░░░  ╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░          //
//============================================================================//
//descripción: esta aplicación contiene un espacio de ingreso por usuario y   //
//contraseña, visualización de noticias aportadas por el servicio api rest    //
//https://newsapi.org/, con la posibilidad de agregarse a una lista de        //
//favoritas y una visualización singular de cada noticia.                     //
//============================================================================//
//desarrollador:Juan Sebastian Castellanos                                    //
//correo:sebastiancastell371@gmail.com                                        //
//github:sebastian-ksk                                                        //
//SIOT-INGENIERIA   https://www.siot-ingenieria.com.co/                       //
//============================================================================//
import 'package:bit_app/view/login_page.dart';
import 'package:bit_app/view/news_page.dart';
import 'package:bit_app/view/register.dart';
import 'package:bit_app/view/single_new.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bit_app/util/services/firebaseController.dart'
    as firebaseController;
import 'package:bit_app/view/view_more.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// clase principal
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => new LoginPage());
          case '/news':
            return MaterialPageRoute(
                builder: (context) => new NewsPage(settings.arguments));
          case '/sing_news':
            return MaterialPageRoute(builder: (context) => new SingleNew());
          case '/preview':
            return MaterialPageRoute(
                builder: (context) => new Preview(settings.arguments));
          case '/register':
            return MaterialPageRoute(builder: (context) => new RegisterPage());
          default:
            return null;
        }
      },
    );
  }
}
