import 'package:bit_app/util/colors.dart';
import 'package:bit_app/util/resize.dart';
import 'package:bit_app/util/styles.dart';
import 'package:bit_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bit_app/view/news_page.dart';
import 'package:bit_app/util/services/firebaseController.dart'
    as firebaseController;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _rememberMe = false;
  bool LogButton = false;
  bool eyePass = false;

  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  TextEditingController _textEditingControllerPasword =
      new TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  showSnackBar(String message) {
    setState(() {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }

  Widget _buildUserName() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        controller: _textEditingControllerEmail,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.supervised_user_circle,
            color: Colors.black,
          ),
          hintText: 'Username',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildPasword() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        obscureText:
            eyePass == false ? true : false, //visualizacion de contraseña
        controller: _textEditingControllerPasword,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(eyePass == false
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                eyePass = !eyePass;
              });
            },
          ),
          hintText: 'Password',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          print('Sing Up Botton pressed');
          setState(() {
            //LogButton = !LogButton;
            firebaseController.registerUser(
              email: _textEditingControllerEmail.text,
              password: _textEditingControllerPasword.text,
              context: context,
            );
            firebaseController.stateChanges(context);
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'SING UP',
          style: GoogleFonts.signika(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _Height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //====================imagen de background============================
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/backbit.png'))),
          ),
          //====================================================================
          Column(
            children: [
              //====================cuadro de login=================================
              Container(
                padding: EdgeInsets.only(
                  top: ResizerH(
                    MediaQ: _Height,
                    Size: 50,
                  ),
                  left: 25,
                  right: 25,
                ),
                height: MediaQuery.of(context).size.height * (5 / 8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: whiteLogin,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, //alineacion a la izquierda
                  children: [
                    //=======================Texto de welcome====================
                    Text(
                      "Register In: ",
                      style: GoogleFonts.signika(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    //============================================================
                    //=======================imagen de logo=======================
                    Image.asset(
                      'assets/img/BitLogo.png',
                      width: ResizerH(MediaQ: _Height, Size: 157),
                      height: ResizerH(MediaQ: _Height, Size: 63),
                      fit: BoxFit.contain,
                    ),
                    //==============================================================
                    //=======================text login please======================
                    Text(
                      "Please Enter you name: ",
                      style: GoogleFonts.signika(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    //==============================================================
                    SizedBox(height: 5.0),
                    _buildUserName(),
                    SizedBox(height: 5.0),
                    Text(
                      "Please Enter your Pasword: ",
                      style: GoogleFonts.signika(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    _buildPasword(),
                    SizedBox(height: 5.0),
                    _buildRegisterBtn()
                  ],
                  //============================================================
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
