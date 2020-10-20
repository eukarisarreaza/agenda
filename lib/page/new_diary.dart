import 'package:agenda/bloc/diary_bloc.dart';
import 'package:agenda/bloc/provider_bloc.dart';
import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/page/widget_pronostico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class NewDiaryPage extends StatefulWidget {
  static final String routeName= 'new_diary';

  @override
  _NewDiaryPageState createState() => _NewDiaryPageState();
}

class _NewDiaryPageState extends State<NewDiaryPage> {
  final TextEditingController _typeCanchaController = TextEditingController();
  var _canchaSelected;
  DateTime selectedDate = DateTime.now();
  DiaryBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc= ProviderBloc.diaryBloc(context);


    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Registro de Citas'),),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
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
        _canchaSelected= suggestion;
        //_brand = suggestion;
        //_typeMarcaController.text = suggestion.name;
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
    return Card(
      elevation: 1,
      color: Colors.blue,
      child: Pronostico(),
    );


  }

  Widget btnRegistrar() {
    return RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {},
        child: Text('Crear Cita')
    );
  }


}
