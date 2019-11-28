import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proyecto_pryn1/pages/Estudiantes/estudianteProyectos.dart';






class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list,this.index});
  //@override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
//CAMBIAR ESTOS CONTROLLER
  TextEditingController controllerpuntajeEval2;

//CAMBIAR DIRECCION IP PARA QUE FUNCIONE Y CAMBIAR LO QUE ESTA ENTRE COMILLAS POR LOS VALORES NECESARIOS EN LA BD
void editData(){
  var url="http://192.168.1.11/estudiante/editdata.php";
  http:post(url,body: {
    "id": widget.list[widget.index]['id'],
    "puntajeEval2": controllerpuntajeEval2.text,
   
  });
}

//CAMBIAR ESTOS VALORES
@override
  void initState() {
    controllerpuntajeEval2=new TextEditingController(text: widget.list[widget.index]['puntajeEval2']);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Agregar Calificación"),
        backgroundColor: Colors.green,
      ),
      body: Form(//EL FORM NOS PERMITE HACER VALIDACIONES
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new  ListTile(
                  leading: const Icon(Icons.event_note, color: Colors.black),//colores
                  title: new TextFormField(
                    controller: controllerpuntajeEval2,
                    validator: (value) {
                     if (value.isEmpty) return "Ingrese una Calificación"; 
                    },
                    decoration: new InputDecoration(
                      hintText: "Calificación", labelText: "Calificación",
                    ),
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Guardar"),
                  color: Colors.orangeAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new ProyectosEstudiante()
                      )
                    );
                  },
                ),
                new RaisedButton(
                  child: new Text("Salir"),
                  color: Colors.orangeAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new ProyectosEstudiante()
                      )
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}