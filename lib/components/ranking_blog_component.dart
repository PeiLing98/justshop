import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RankingBlogComponent extends StatefulWidget {
  const RankingBlogComponent({Key? key}) : super(key: key);

  @override
  _RankingBlogComponentState createState() => _RankingBlogComponentState();
}

class _RankingBlogComponentState extends State<RankingBlogComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(250, 233, 221, 221),
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    // child: Image.network(
                    //     userStoreData!.imagePath,
                    //     fit: BoxFit.cover),
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Store Name',
                        style: buttonLabelStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: RatingBar.builder(
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
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_pin,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      // store[index].city + ", " + store[index].state,
                      'City, State',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Roboto',
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 263,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      child: Text(
                                        // categoryDistinctList[index][0],
                                        'Food',
                                        style: TextStyle(
                                            fontSize: 10, fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                      const Text(
                        'Sales: 100',
                        style: buttonLabelStyle,
                      ),
                    ],
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
