import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class TransactionDb {

  List transaction = [];

  // 4 Reference notre box Hive
  final _mybox = Hive.box('mybox');

  void Firstenter (){
     transaction = [
      
     ];
  }

  // chargement des donnee de la db
  void loadData (){
     transaction = _mybox.get("ListTransaction");
  }

  // Faire mis a jour des infos entree par le user
  void Misajour (){
    _mybox.put("ListTransaction", transaction);
  }
}