import 'package:flutter/material.dart';
import 'package:proyecto_pryn1/main.dart';
import 'package:proyecto_pryn1/pages/Admins/adminsProyectos.dart';

class Admins extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('ADMINS'),
      backgroundColor: Colors.green,),
      drawer: MenuLateral(),
      body: new Column(
        children: <Widget>[
          new Image.asset('assets/images/administrador.jpg'),
          Text('Bienvenido a la Universidad El Bosque, institución con acreditación de alta calidad, en este momento usted se encuentra en la pagina de los Admins, aqui usted podra calificar proyectos y guardar las notas de estos, si desea puede darle a las tres barritas que se encuentran en la parte superior izquierda, allí usted podra navegar por la aplicación.',style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      
    );
  }
}

class CrudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter + Mysql',
      home: Admins(),
      routes: <String, WidgetBuilder>{
        '/adminsProyectos': (BuildContext context) => new ListaProAd(),
        '/LoginPage': (BuildContext context) => Admins(),
      },
    );
  }
}


class MenuLateral extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Drawer(
      child: ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: Text('UNIVERSIDAD EL BOSQUE', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),),
          accountEmail: Text('Feria De Proyectos', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/DrawImage.jpg"),
              fit: BoxFit.cover
            )
          ),
        ),
        Ink(
          color: Colors.green,
          child:  new ListTile(
          title: Text("ADMINS", style: TextStyle(color: Colors.black),),
        ),
        ),
       Ink(
          child:  new ListTile(
          title: Text("PROYECTOS", style: TextStyle(color: Colors.black),),
          onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:(BuildContext context) => ListaProAd()
              )
            );
          },
        ),
       ),
       Ink(
          child:  new ListTile(
          title: Text("SALIR", style: TextStyle(color: Colors.black),),
          onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:(BuildContext context) => LoginPage()
              )
            );
          },
        ),
       ),
      ],  
      ),
    );
  }
}


