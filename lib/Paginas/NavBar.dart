import 'package:bam/Herramientas/herramienta.dart';
import 'package:bam/Paginas/registrarPerson_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key}) : super(key: key);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  User usuario = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(usuario.displayName),
            accountEmail: Text(usuario.email),
            currentAccountPicture: ClipOval(
              child: Image.network(
                'https://i.ytimg.com/vi/JQPWYGvnxd0/maxresdefault.jpg',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outlined),
            title: Text('Crear Rifa'),
            onTap: () {
              FirebaseFirestore.instance
                  .collection('user')
                  .doc(usuario.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  Navigator.pushNamed(context, 'createRaffle_page');
                } else {
                  nextRuta = 'createRaffle_page';
                  mostrarAlerta(context, 'Registrame', 'No te has registrado',
                      'registrarPerson_page');
                  //;
                }
              });
              /* if (usuario.phoneNumber != null) {
                
              } else {
                
              } */
            },
          ),
          ListTile(
            leading: Icon(Icons.menu_open),
            title: Text('Abrir Rifa'),
            onTap: () {
              Navigator.pushNamed(context, 'openRaffle_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page_rounded),
            title: Text('Amigos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.stacked_line_chart_outlined),
            title: Text('Estadisticas'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartir App'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Cerrar sesión'),
            onTap: () {
              Navigator.pushNamed(context, 'login_page');
            },
          ),
        ],
      ),
    );
  }
}
