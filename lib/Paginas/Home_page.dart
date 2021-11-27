import 'package:bam/Paginas/NavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.share),
          ),
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.info_sharp),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'En Proceso',
            ),
            Tab(text: 'Jugadas'),
          ],
        ),
      ),
      drawer: NavBarPage(),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: listProceso(),
          ),
          ListView(
            children: listJugadas(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'createRaffle_page');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> listJugadas() {
    return [
      _listTile(
          'https://assets.tramontina.com.br/upload/tramon/imagens/CUT/27899453PDM001D.jpg',
          'Juego de sartenes',
          'Descripción'),
    ];
  }

  List<Widget> listProceso() {
    return [
      _listTile(
          'https://assets.tramontina.com.br/upload/tramon/imagens/CUT/27899453PDM001D.jpg',
          'Juego de sartenes',
          'Descripción'),
    ];
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
