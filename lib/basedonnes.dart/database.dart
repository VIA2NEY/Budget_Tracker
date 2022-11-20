import 'package:hive_flutter/adapters.dart';

class TransactionDb {

  List transaction = [];

  // 4 Reference notre box Hive
  final _mybox = Hive.box('mybox');

  // chargement des donnee de la db
  void loadData (){
     transaction = _mybox.get("ListTransaction");
  }

  // Faire mis a jour des infos entree par le user
  void Misajour (){
    _mybox.put("ListTransaction", transaction);
  }
}