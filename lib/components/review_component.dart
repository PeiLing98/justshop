import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewComponent extends StatefulWidget {
  const ReviewComponent({Key? key}) : super(key: key);

  @override
  _ReviewComponentState createState() => _ReviewComponentState();
}

class _ReviewComponentState extends State<ReviewComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            title: const Text(
              'Username',
              style: boldContentTitle,
            ),
            trailing: RatingBar.builder(
                glow: false,
                updateOnDrag: true,
                initialRating: 1,
                unratedColor: Colors.grey[300],
                minRating: 1,
                itemSize: 15,
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  //print(rating);
                }),
            subtitle: const Text(
              'I like it very much!',
              style: ratingLabelStyle,
            ),
            isThreeLine: true,
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 30,
                  )),
            ),
          )),
    );
  }
}
