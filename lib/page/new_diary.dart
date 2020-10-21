import 'package:agenda/bloc/diary_bloc.dart';
import 'package:agenda/bloc/provider_bloc.dart';
import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/data/model/diary.dart';
import 'package:agenda/page/widget_pronostico.dart';
import 'package:agenda/services/response/weather_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NewDiaryPage extends StatefulWidget {
  static final String routeName= 'new_diary';

  @override
  _NewDiaryPageState createState() => _NewDiaryPageState();
}

class _NewDiaryPageState extends State<NewDiaryPage> {
  final TextEditingController _typeCanchaController = TextEditingController();
  Cancha canchaSelected;
  DateTime selectedDate = DateTime.now();
  DiaryBloc bloc;
  String userName;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc= ProviderBloc.diaryBloc(context);
    bloc.actualizarClima();

    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Registro de Citas'),),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                _createInputUserName(),
                SizedBox(height: 20,),
                seleccionFecha(),
                SizedBox(height: 20,),
                pronosticoTiempo(),
                SizedBox(height: 20,),
                spinnerCanchas(),
                SizedBox(height: 30,),
                btnRegistrar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createInputUserName() {
    return TextFormField(
      autofocus: true,
      initialValue: "",
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un dato valido';
        } else
          return null;
      },
      onSaved: (value) {
        userName = value;
      },
      decoration: InputDecoration(
          labelText: 'Nombre de Usuario *',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
      onFieldSubmitted: (v) {
      },
    );
  }


  Widget seleccionFecha() {
    return GestureDetector(
      onTap: (){
        _selectedDate();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.blue),
              SizedBox(width: 20,),
              Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );

  }

  void _selectedDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget spinnerCanchas() {

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: _typeCanchaController,
          decoration: InputDecoration(
              labelText: 'Seleccione Cancha',
              hintStyle: TextStyle(color: Colors.grey),
              labelStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.black),
              )
          ),
          onSubmitted: (v) async {
          }
      ),

      suggestionsCallback: (pattern) async {
        return await bloc.listadoCanchasAsync('');
      },

      itemBuilder: (context, Cancha suggestion) {
        return row(suggestion);
      },

      onSuggestionSelected: (Cancha suggestion) {
        canchaSelected= suggestion;
        //_brand = suggestion;
        _typeCanchaController.text = 'Cancha ${suggestion.name}';
      },

    );




    /*return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.black38)
      ),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton<Cancha>(
          isExpanded: true,
          underline: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide.none)
              )
          ),
          hint: Text('Seleccione Cancha'),
          items: widget.listaCanchas.map((value) => _buildCancha(value)).toList(),
          onChanged: (valor) {
            print('selected parte ${valor.id}');
                    setState(() {
                      _canchaSelected = valor;
                    });

          },
          value: _canchaSelected,
        ),
      ),
    );*/
  }


  Widget row(Cancha item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Cancha ${item.name}',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }



  DropdownMenuItem<Cancha> _buildCancha(Cancha value) {
    return DropdownMenuItem<Cancha>(
      child: Text('Cancha ${value.name}'),
      value: value,
    );
  }

  Widget pronosticoTiempo() {
    return StreamBuilder<WeatherResponse>(
      stream: bloc.weatherStream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Card(
            elevation: 1,
            color: Colors.blue,
            child: Pronostico(weather: snapshot.data),
          );
        }else
          return CircularProgressIndicator();
      }
    );
  }

  Widget btnRegistrar() {
    return RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
      if(_formKey.currentState.validate() ){
        if(canchaSelected==null){
          Fluttertoast.showToast(
              msg: "Seleccione una Cancha",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else
        bloc.registrarCita(canchaSelected, "${selectedDate.toLocal()}".split(' ')[0], userName).then((value) {
          if(value!=null){
            Fluttertoast.showToast(
                msg: "Cita registrada exitosamente!! ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pop(context);
          }else
            Fluttertoast.showToast(
                msg: "Imposible registrar una cita a esta cancha",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
        });
      }

        },
        child: Text('Crear Cita')
    );
  }


}
