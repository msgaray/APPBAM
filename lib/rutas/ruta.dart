import 'package:bam/Paginas/Home_page.dart';
import 'package:bam/Paginas/createRaffle_page.dart';
import 'package:bam/Paginas/login_page.dart';
import 'package:bam/Paginas/openRaffle_page.dart';
import 'package:bam/Paginas/register_page.dart';
import 'package:bam/Paginas/registrarPerson_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRutasApp() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'register_page': (BuildContext context) => RegisterPage(),
    'home_page': (BuildContext context) => HomePage(),
    'login_page': (BuildContext context) => LoginPage(),
    'createRaffle_page': (BuildContext context) => CreateRafflePage(),
    'openRaffle_page': (BuildContext context) => OpenRafflePage(),
    'registrarPerson_page': (BuildContext context) => RegistrarPersonaPage(),
  };
}
