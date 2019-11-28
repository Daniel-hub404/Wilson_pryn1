import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:proyecto_pryn1/pages/Admins/adminsPage.dart';
import 'package:proyecto_pryn1/pages/Docentes/docentePage.dart';
import 'package:proyecto_pryn1/pages/Estudiantes/EstudiantePage.dart';


void main() => runApp(LoginApp());

String username;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter + Mysql',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/adminsPage': (BuildContext context) => new Admins(),
        '/docentePage': (BuildContext context) => new Docente(),
        '/estudiantePage': (BuildContext context) => new Estudiante(),
        '/LoginPage': (BuildContext context) => new LoginPage(),
      },
    );
  }
}


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String mensaje = '';

  Future<List> login() async {        //Cambiar ipconfig dependiendo de la red a la que este conectado
    final response = await http.post("http://192.168.1.11/entrar/login.php", body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });

  var datauser = json.decode(response.body);

  if (datauser.length == 0){
    setState(() {
      mensaje="usuario o contraseña incorrecta";
    });
  } else {
      if (datauser[0]['nivel'] == 'administrador'){
        Navigator.pushReplacementNamed(context, '/adminsPage');
      } else if (datauser[0]['nivel'] == 'Docente') {
        Navigator.pushReplacementNamed(context, '/docentePage');
      } else if (datauser[0]['nivel'] == 'Estudiante'){
        Navigator.pushReplacementNamed(context, '/estudiantePage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/fondo2.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 77.0),
                child: new CircleAvatar(
                  backgroundColor: Color(0x454b29),
                  child: new Image(
                    width: 135,
                    height: 135,
                    image: new AssetImage('assets/images/icono 2.png')
                  ),
                ),
                width: 220.0,
                height: 220.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 93
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: TextFormField(
                          controller: controllerUser,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Username'
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        margin: EdgeInsets.only(
                          top: 32
                        ),
                        padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: TextField(
                          controller: controllerPass,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: 'Password'
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            right: 32,
                          ),
                          child: Text(
                            'Recordar Pass',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      new RaisedButton(
                        child: new Text("   Ingresar   "),
                        color: Colors.orangeAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                        ),
                        onPressed: (){
                          login();
                          Navigator.pop(context);
                        },
                      ),
                      Text(mensaje,
                      style: TextStyle(fontSize: 25.0, color: Colors.red),)
                    ],
                  ),
              ),
            ],
          )
        ),
      ),
    );
  }
}