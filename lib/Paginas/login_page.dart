import 'dart:async';

import 'package:bam/Herramientas/herramienta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _user = '', _password = '', mesanje = ' ';
  bool _isloading = false;
  @override
  _LoginPageState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        //Navigator.pushNamed(context, 'home_page');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 230, 1.0),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          children: [
            imagen(),
            divider(15.0),
            crearLoading(_isloading),
            divider(15.0),
            _inputTextEmail(),
            divider(20.0),
            _inputTextPassword(),
            divider(20.0),
            Center(
              child: Text(mesanje),
            ),
            divider(20.0),
            Column(
              children: [_btnIniciar()],
            ),
            divider(40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonOlvidar(),
                _btnRegistrar(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputTextEmail() {
    return TextField(
      obscureText: false,
      decoration: inputDecoration('Email', 'Email', Icon(Icons.email)),
      onChanged: (valor) {
        setState(() {
          _user = valor;
        });
      },
    );
  }

  Widget _inputTextPassword() {
    return TextField(
      obscureText: true,
      decoration: inputDecoration('Password', 'Password', Icon(Icons.lock)),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        });
      },
    );
  }

  Widget _buttonOlvidar() {
    return FlatButton(
      child: childText('Olvidé mi Contraseña', 15.0, FontWeight.bold,
          Color.fromRGBO(102, 102, 102, 1.0)),
      onPressed: () {
        _mostrarAlerta(context);
      },
    );
  }

  Widget _btnRegistrar() {
    return FlatButton(
      child: childText('Crear una cuenta', 15.0, FontWeight.bold,
          Color.fromRGBO(102, 102, 102, 1.0)),
      onPressed: () {
        Navigator.pushNamed(context, 'register_page');
      },
    );
  }

  Widget _btnIniciar() {
    return FlatButton(
      shape: StadiumBorder(),
      padding: EdgeInsets.only(left: 50.0, right: 50.0),
      height: 50.0,
      color: Color.fromRGBO(0, 151, 236, 1.0),
      textColor: Colors.white,
      focusColor: Colors.blue,
      splashColor: Colors.blue,
      onPressed: () async {
        if (_user != '' && _password != '') {
          if (isEmail(_user)) {
            mesanje = ' ';
            _isloading = true;
            setState(() {});
            try {
              FirebaseAuth firebase = FirebaseAuth.instance;
              var methods = await firebase.fetchSignInMethodsForEmail(_user);
              if (methods.contains('password')) {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _user, password: _password);

                _isloading = false;
                Navigator.pushNamed(context, 'home_page');
              } else {
                _isloading = false;
                setState(() {
                  mesanje = 'El usuario o contraseña no son correctas';
                });
              }
            } on FirebaseAuthException catch (e) {
              _isloading = false;
              print(e.message);
              setState(() {
                mesanje = 'El usuario o contraseña no son correctas';
              });
            }
          } else {
            setState(() {
              mesanje = 'El Email es incorrecto';
            });
          }
        } else {
          setState(() {
            mesanje = 'Completar los campos';
          });
        }
      },
      child: childText(
          'INICIAR', 15.0, FontWeight.bold, Color.fromRGBO(230, 230, 230, 1.0)),
    );
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Restablecer Contraseña'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _inputTextEmail(),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, 'register_page');
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }
}
