import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

//======================controladores de firebase===============================

//======================cambios de estado del usuario===========================
void stateChanges(context) async {
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      //si el usuario no esta
      print('User is currently signed out!');
    } else {
      //si el usuario existe
      print('User is signed in!');
      Future.delayed(Duration(seconds: 2), () {
        //espera de 2 segundos
        Navigator.pushNamed(context, '/news',
            arguments: user); //redireccion a news
      });
    }
  });
}
//==============================================================================

//======================funcion de ingreso a plataforma ========================
void signIn(
    {@required String email, //requiere de usuario
    @required String password, //contraseña
    @required context}) async {
  try {
    //tratar
    //ingreso a plataforma
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    //si existe un error retorna mensajes respctivos.
    if (e.code == 'user-not-found') {
      showMaterialDialog(
          context: context, message: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      showMaterialDialog(
          context: context, message: 'Wrong password provided for that user.');
    }
  }
}
//==============================================================================

//======================dialogos de login=======================================
showMaterialDialog({@required context, @required String message}) {
  showDialog(
      context: context,
      //new alert dielog es mostrado para cuado se requiera
      builder: (_) => new AlertDialog(
            title: Text("Warning!"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
// =============================================================================

//=========================registro de usuarios=================================
void registerUser(
    {@required String email,
    @required String password,
    @required context}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    //errores de contraseña debil
    if (e.code == 'weak-password') {
      showMaterialDialog(
          context: context, message: 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      //ERROR DE CUENTA EXISTENTE
      showMaterialDialog(
          context: context,
          message: 'The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
//====================== funcion de salida de cuenta ===========================
void signOut() async {
  await FirebaseAuth.instance.signOut();
}
//==============================================================================
