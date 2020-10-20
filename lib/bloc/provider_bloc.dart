



import 'package:agenda/bloc/diary_bloc.dart';
import 'package:flutter/material.dart';

class ProviderBloc extends InheritedWidget{
  static ProviderBloc _instance;
  final _diaryBloc= DiaryBloc();


  factory ProviderBloc({Key key, Widget child}) {
    if (_instance == null) {
      _instance = ProviderBloc._internal(key: key, child: child);
    }

    return _instance;
  }

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);

  static DiaryBloc diaryBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProviderBloc) as ProviderBloc)
        ._diaryBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  
}