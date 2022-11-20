import 'package:budget_tracker/basedonnes.dart/database.dart';
import 'package:budget_tracker/bouttons_ajouter.dart';
import 'package:budget_tracker/top_card.dart';
import 'package:budget_tracker/transactions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // 3 Referencer la box hive
  final myBox = Hive.box('mybox');

  @override
  void initState() {
    // Premier ouverture
    db.loadData();

    super.initState();
  }

  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

void _newTransaction() {
showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text('N E W  T R A N S A C T I O N'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Dépense'),
                      Switch(
                        value: _isIncome,
                        onChanged: (newValue) {
                          setState(() {
                            _isIncome = newValue;
                          });
                          print(_isIncome);
                        },
                      ),
                      Text('Revenue'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Montant ',
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Ajouter un montant s\'il vous plaît';
                              }
                              return null;
                            },
                            controller: _textcontrollerAMOUNT,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Pour quelle raisons ?',
                          ),
                          controller: _textcontrollerITEM,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey[600],
                child:
                    Text('Cancel', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                color: Colors.grey[600],
                child: Text('Valider', style: TextStyle(color: Colors.white)),
                onPressed: sauvegarde,
              )
            ],
          );
        },
      );
    });
  }

  // List transaction = [
  //   ["Economie","1000","revenue"],
  //   ["Transport","2500","depense"],
  //   ["Internet","1500","depense"],
  // ]; Pour devenir
  TransactionDb db = TransactionDb();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        body: Column(
          children: [
            //Partie en haut
            TopNeuCard(
              balance: "20,000", 
              expense: "1,500", 
              income: "3,000"
            ),
            // 
    
            // Au milieu
            Expanded(
              child: ListView.builder(
                itemCount: db.transaction.length,
                itemBuilder: (context, index) {
                  return Transactions(
                    nomTransaction: db.transaction[index][0],
                    montant: db.transaction[index][1], 
                    depenseOuRevenue: db.transaction[index][2],
                    fonction_de_suppression : (context) => deleteTransaction(index),
                  );
                }
              )
            ),
            // 

            // Partie en bas
            PlusButton(
              function: _newTransaction,
            )
            // 
          ],
        ),
      ),
    );
    
  }

  //Cree une nouvelle transaction

  // void creationTransaction (){
  //   showDialog(context: context, builder: (context) ){

  //     return AlertDialog(

  //     );
  //   }
  // }

  void sauvegarde (){
    setState(() {
      db.transaction.add([
        _textcontrollerITEM.text,
        _textcontrollerAMOUNT.text,
        _isIncome == false ? "depense" : "Revenue",        
      ]);
      _textcontrollerITEM.clear();
      _textcontrollerAMOUNT.clear();
    });
    Navigator.of(context).pop();
    db.Misajour();
  }
  // Supression
  void deleteTransaction (int index){
    setState(() {
      db.transaction.removeAt(index);
    });
    db.Misajour();
  }

  // Quand on click sur checkbox
  void checkBoxChange (bool ? valeur, int index){
    setState(() {
      db.transaction[index][3] = !db.transaction[index][3] ;/*C'est un exple ooh */
    });
    db.Misajour();
  }

}