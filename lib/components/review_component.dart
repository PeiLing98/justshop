import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/review_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewComponent extends StatefulWidget {
  final Review review;
  final AllUser user;
  final Listing listing;
  const ReviewComponent(
      {Key? key,
      required this.review,
      required this.user,
      required this.listing})
      : super(key: key);

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
            title: Text(
              widget.user.username,
              style: boldContentTitle,
            ),
            trailing: RatingBar.builder(
                ignoreGestures: true,
                glow: false,
                updateOnDrag: true,
                initialRating: double.parse(widget.review.ratingStar),
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
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Listing: ${widget.listing.listingName}',
                    style: ratingLabelStyle,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.review.review,
                    style: ratingLabelStyle,
                  ),
                ],
              ),
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
