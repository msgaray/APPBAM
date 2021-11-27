import 'package:bam/Herramientas/herramienta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _password = '',
      _confirPassword = '',
      _user = '',
      _nombre = '',
      mensaje = ' ';
  bool _isloading = false;
  @override
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
            _inputTextNombre(),
            divider(20.0),
            _inputTextPassword(),
            divider(20.0),
            _inputTextPasswordConfirmar(),
            divider(20.0),
            Center(
              child: Text(mensaje),
            ),
            divider(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _btnCancelar(),
                _btnRegister(),
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

  Widget _inputTextNombre() {
    return TextField(
      obscureText: false,
      decoration: inputDecoration(
          'Nombre de Usuario', 'Nombre de Usuario', Icon(Icons.face)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
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

  Widget _inputTextPasswordConfirmar() {
    return TextField(
      obscureText: true,
      decoration: inputDecoration(
          'Confirmar Password', 'Confirmar Password', Icon(Icons.lock)),
      onChanged: (valor) {
        setState(() {
          _confirPassword = valor;
        });
      },
    );
  }

  Widget _btnCancelar() {
    return FlatButton(
        shape: StadiumBorder(),
        padding: EdgeInsets.only(left: 35.0, right: 35.0),
        height: 50.0,
        color: Color.fromRGBO(0, 151, 236, 1.0),
        textColor: Colors.white,
        focusColor: Colors.blue,
        splashColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        child: Text('CANCELAR'));
  }

  Widget _btnRegister() {
    return FlatButton(
        shape: StadiumBorder(),
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        height: 50.0,
        color: Color.fromRGBO(0, 151, 236, 1.0),
        textColor: Colors.white,
        focusColor: Colors.blue,
        splashColor: Colors.blue,
        onPressed: () async {
          if (_user != '' &&
              _nombre != '' &&
              _password != '' &&
              _confirPassword != '') {
            if (isEmail(_user)) {
              if (_password == _confirPassword) {
                mensaje = ' ';
                _isloading = true;
                setState(() {});
                try {
                  FirebaseAuth firebase = FirebaseAuth.instance;
                  var methods =
                      await firebase.fetchSignInMethodsForEmail(_user);
                  if (!methods.contains('password')) {
                    UserCredential userCredential =
                        await firebase.createUserWithEmailAndPassword(
                            email: _user, password: _password);
                    await userCredential.user
                        .updateProfile(displayName: _nombre);
                    _isloading = false;
                    Navigator.pushNamed(context, 'home_page');
                  } else {
                    _isloading = false;
                    setState(() {
                      mensaje = 'El Correo se encuentra registrado';
                    });
                  }
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                  _isloading = false;
                  setState(() {
                    mensaje = 'Error al cargar';
                  });
                }
              } else {
                setState(() {
                  mensaje = 'Las Contraseñas no son identicas';
                });
              }
            } else {
              setState(() {
                mensaje = 'NO es valido el correo';
              });
            }
          } else {
            setState(() {
              mensaje = 'Por favor Complete Los campos';
            });
          }
          //Navigator.pushNamed(context, '/');
        },
        child: Text('REGISTRARME'));
  }
}
