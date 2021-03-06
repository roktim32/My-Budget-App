import 'dart:io';
import 'package:flutter_budget_ui/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

class Db{
  static Store? _store;

  static void init(Directory dir){
    _store = Store(getObjectBoxModel(), directory: dir.path + '/mybudget'); 
  }

  static void dispose(){
    _store!.close();
    _store = null;
  }

  static Store? get store=>_store;
}