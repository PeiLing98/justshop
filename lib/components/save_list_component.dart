import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SaveListComponent extends StatefulWidget {
  final String listingName;
  final String listingPrice;
  const SaveListComponent(
      {Key? key, required this.listingName, required this.listingPrice})
      : super(key: key);

  @override
  _SaveListComponentState createState() => _SaveListComponentState();
}

class _SaveListComponentState extends State<SaveListComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(129, 89, 89, 0.98),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: const ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      // child: Image.network(
                      //   store[index].imagePath,
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
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
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.listingName,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(widget.listingPrice,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
