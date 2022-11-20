import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Transactions extends StatelessWidget {
  String nomTransaction;
  String montant;
  String depenseOuRevenue;
  Function (BuildContext)? fonction_de_suppression ;

  Transactions(
      {required this.nomTransaction,
      required this.montant,
      required this.depenseOuRevenue,
      required this.fonction_de_suppression,
      });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Menu slidant
      endActionPane: ActionPane(
        motion: StretchMotion(), 
        children: [
          SlidableAction(
            onPressed: fonction_de_suppression,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
        ]
      ),

      child: Container(
        margin: EdgeInsets.symmetric(horizontal :16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.grey[200],
            // height: 50,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nomTransaction,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text( 
                      (depenseOuRevenue == 'depense' ? '- ' : '+ ') + montant + ' Xof',
                      style: TextStyle(
                        color: (depenseOuRevenue == 'depense' ? Colors.red : Colors.green),
                        fontSize: 16,
                        // fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
