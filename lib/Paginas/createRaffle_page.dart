import 'dart:ui';

import 'package:bam/Herramientas/herramienta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateRafflePage extends StatefulWidget {
  CreateRafflePage({Key key}) : super(key: key);

  @override
  _CreateRafflePageState createState() => _CreateRafflePageState();
}

class _CreateRafflePageState extends State<CreateRafflePage> {
  String _opcionSeleccionadad = 'Volar',
      _opcionLoteria = 'Volar',
      _opcionTamano = '10',
      _fecha = '',
      _premio = '',
      _descripcionPremio = '',
      _precio = '',
      mensaje = ' ';

  TextEditingController _inputFielDateController = new TextEditingController();

  List<String> _categoria = [
    'Volar',
    'Rayos X',
    'Super Aliento',
    'Super Fuerza'
  ];
  List<String> _categoriaLoteira = [
    'Volar',
    'Rayos X',
    'Super Aliento',
    'Super Fuerza'
  ];
  List<String> _tamano = ['10', '100', '1000', '10000'];

  User usuario = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 230, 1.0),
      appBar: AppBar(
        title: Text('Nueva Rifa'),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.info_sharp),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        children: [
          divider(55.0),
          Column(
            children: [
              _imagen(),
            ],
          ),
          divider(30.0),
          _inputTextPremio(),
          divider(15.0),
          _inputTextDescripcion(),
          divider(15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 160.0,
                child: _crearDropdown(_opcionSeleccionadad,
                    getOpcionesDropdown(_categoria), 'Categoria'),
              ),
              Container(
                width: 160.0,
                child: _crearDropdown(_opcionLoteria,
                    getOpcionesDropdown(_categoriaLoteira), 'Loteria'),
              ),
            ],
          ),
          divider(15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120.0,
                child: _crearDropdown(
                    _opcionTamano, getOpcionesDropdown(_tamano), 'Tamaño'),
              ),
              _diajugar(context),
            ],
          ),
          divider(15.0),
          _inputTextValor(),
          divider(15.0),
          Center(
            child: Text(mensaje),
          ),
          divider(15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _btnCancelar(),
              _btnRegister(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputTextPremio() {
    return TextField(
      decoration:
          inputDecoration('Premio', 'Premio', Icon(Icons.wallet_giftcard)),
      onChanged: (valor) {
        setState(() {
          _premio = valor;
        });
      },
    );
  }

  Widget _inputTextDescripcion() {
    return TextField(
      decoration: inputDecoration(
          'Descripción', 'Descripción', Icon(Icons.wallet_giftcard)),
      onChanged: (valor) {
        setState(() {
          _descripcionPremio = valor;
        });
      },
    );
  }

  Widget _inputTextValor() {
    return TextField(
      decoration:
          inputDecoration('Valor', 'Valor', Icon(Icons.wallet_giftcard)),
      onChanged: (valor) {
        setState(() {
          _precio = valor;
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
          if (_premio != '' &&
              _descripcionPremio != '' &&
              _opcionSeleccionadad != '' &&
              _opcionLoteria != '' &&
              _opcionTamano != '' &&
              _fecha != '' &&
              _precio != '') {
            FirebaseFirestore.instance
                .collection('rifaUserID_' + usuario.uid)
                .add({
              'premio': _premio,
              'descripcion': _descripcionPremio,
              'categoria': _opcionSeleccionadad,
              'loteria': _opcionLoteria,
              'tamaño': _opcionTamano,
              'dia a Jugar': _fecha,
              'valor': _precio
            });
            Navigator.pushNamed(context, 'openRaffle_page');
          } else {
            mensaje = 'Complete todo los campos';
            setState(() {});
          }
        },
        child: Text('REGISTRARME'));
  }

  Widget _diajugar(BuildContext context) {
    return Container(
        width: 180.0,
        child: TextField(
          enableInteractiveSelection: false,
          controller: _inputFielDateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Dia a Jugar',
            labelText: 'Dia a Jugar',
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
        ));
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(() {
        _fecha = picked.day.toString() +
            '/' +
            picked.month.toString() +
            '/' +
            picked.year.toString();
        _inputFielDateController.text = _fecha;
      });
    }
  }

  Widget _imagen() {
    return ClipOval(
      child: Image.network(
        'https://i.ytimg.com/vi/JQPWYGvnxd0/maxresdefault.jpg',
        fit: BoxFit.cover,
        width: 130,
        height: 130,
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(List<String> listaText) {
    List<DropdownMenuItem<String>> lista = new List();
    listaText.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }

  Widget _crearDropdown(
      String value, List<DropdownMenuItem<String>> items, String labelText) {
    return DropdownButtonFormField(
      value: value,
      items: items,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: labelText,
      ),
      onChanged: (opt) {
        setState(() {
          value = opt;
        });
      },
    );
  }
}
