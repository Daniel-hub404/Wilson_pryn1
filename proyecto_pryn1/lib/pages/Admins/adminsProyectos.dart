import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




import 'dart:async';
import 'dart:convert';

import 'package:proyecto_pryn1/pages/Admins/adminsEditdata.dart';







class ListaProAd extends StatefulWidget {
  @override
  _ListaProAdState createState() => _ListaProAdState();
}

class _ListaProAdState extends State<ListaProAd> {

Future<List> getData() async{
  final response = await http.get("http://192.168.1.11/admin/getdata.php");
  return json.decode(response.body);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Lista de Proyectos"),
      backgroundColor: Colors.green,),
      

      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? new ItemList(
            list: snapshot.data
          )
          : new Center(
            child: new CircularProgressIndicator(),
          );
        },
        ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new EditData(
                  list: list,
                  index: i,
                ),
              ),
            ),
            //IMPORTANTE, ACA CAMBIAREMOS LA PEQUEÑA DESCRIPCION Y EL RESUMEN DE LAS CALIFICACIONES CON ESTO 
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['descripcion'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.person_pin,
                  size: 77.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: new Text(
                  "Calificación Actual: ${list[i]['puntajeEval3']}",
                  style:TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
