import 'package:bam/Herramientas/herramienta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String nextRuta;

class RegistrarPersonaPage extends StatefulWidget {
  RegistrarPersonaPage({Key key}) : super(key: key);

  @override
  _RegistrarPersonaPageState createState() => _RegistrarPersonaPageState();
}

class _RegistrarPersonaPageState extends State<RegistrarPersonaPage> {
  String _fechaNacimento = '',
      _telefono = '',
      _apellido = '',
      _nombre = '',
      mensaje = ' ';
  bool _isloading = false;
  TextEditingController _inputFielDateController = new TextEditingController();
  User usuario = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 230, 1.0),
      appBar: AppBar(
        title: Text('Registarme'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          children: [
            imagen(),
            divider(15.0),
            crearLoading(_isloading),
            divider(15.0),
            _inputTextNombre(),
            divider(20.0),
            _inputTextApellido(),
            divider(20.0),
            _crearFecha(context),
            divider(20.0),
            _inputTextTelefono(),
            divider(20.0),
            Text(mensaje),
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

  Widget _inputTextApellido() {
    return TextField(
      obscureText: false,
      decoration: inputDecoration('Apellido', 'Apellido', Icon(Icons.face)),
      onChanged: (valor) {
        setState(() {
          _apellido = valor;
        });
      },
    );
  }

  Widget _inputTextNombre() {
    return TextField(
      obscureText: false,
      decoration: inputDecoration('Nombre', 'Nombre', Icon(Icons.face)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _inputTextTelefono() {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration:
          inputDecoration('N° Celular', 'N° Celular', Icon(Icons.phone)),
      onChanged: (valor) {
        setState(() {
          _telefono = valor;
        });
      },
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFielDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1910),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(() {
        _fechaNacimento = picked.day.toString() +
            '/' +
            picked.month.toString() +
            '/' +
            picked.year.toString();
        _inputFielDateController.text = _fechaNacimento;
      });
    }
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
          Navigator.pop(context);
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
        onPressed: () {
          if (_apellido != '' &&
              _nombre != '' &&
              _fechaNacimento != '' &&
              _telefono != '') {
            mensaje = ' ';
            _isloading = true;
            setState(() {});
            FirebaseFirestore.instance.collection('user').doc(usuario.uid).set({
              'nombre': _nombre,
              'apellido': _apellido,
              'fechaNacimento': _fechaNacimento,
              'telefono': _telefono
            });
            Navigator.pop(context);
            Navigator.pushNamed(context, nextRuta);
          } else {
            setState(() {
              mensaje = 'Por favor Complete Los campos';
            });
          }
        },
        child: Text('REGISTRARME'));
  }
}
