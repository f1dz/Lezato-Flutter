import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/data/model/review.dart';

class ReviewScreen extends StatelessWidget {
  final Restaurant restaurant;

  const ReviewScreen({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: restaurant.customerReviews.length,
            itemBuilder: (context, index) {
              Review review = restaurant.customerReviews[index];
              return Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          child: Text(
                            review.name[0],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  review.date,
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  review.review,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
