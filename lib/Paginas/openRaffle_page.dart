import 'package:bam/Herramientas/herramienta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OpenRafflePage extends StatefulWidget {
  OpenRafflePage({Key key}) : super(key: key);

  @override
  _OpenRafflePageState createState() => _OpenRafflePageState();
}

class _OpenRafflePageState extends State<OpenRafflePage> {
  User usuario = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot> _usersStream;

  @override
  Widget build(BuildContext context) {
    _usersStream = FirebaseFirestore.instance
        .collection('rifaUserID_' + usuario.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Rifas'),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.search),
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.filter_list_alt),
              )
            ],
          ),
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return new ListTile(
                title: new Text(data['premio']),
                subtitle: new Text(data.toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  List<Widget> rifas() {
    List<Widget> aux;
  }

  Widget _listTile(String url, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Color.fromRGBO(230, 230, 230, 1.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: ClipOval(
          child: FadeInImage(
            placeholder: AssetImage('img/jar-loading.gif'),
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        isThreeLine: true,
        trailing: Text('jasgfgdfgsdgddg\ndfgdfgdfgsdgsgh'),
        onTap: () {},
      ),
    );
  }
}
