import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeRatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: 3.8,
      allowHalfRating: true,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
      onRatingUpdate: null,
    );
  }
}
