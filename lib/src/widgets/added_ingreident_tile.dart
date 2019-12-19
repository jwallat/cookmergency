import 'package:flutter/widgets.dart';
import "package:flutter/material.dart";
import "../models/ingredient_amount_model.dart";

class AddedIngredientTile extends StatelessWidget {
  final IngredientAmountModel model;
  final Function selfdestructionCallback;

  const AddedIngredientTile({this.model, this.selfdestructionCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${model.ingredientName}, ${model.amount} ${model.unit}"),
        trailing: FlatButton(
          child: const Icon(Icons.delete),
          onPressed: () {
            selfdestructionCallback(model);
          },
        ),
      ),
    );
  }
}
