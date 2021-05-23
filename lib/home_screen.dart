import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/data/response_restaurant.dart';

import 'data/api.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lezato')),
      ),
      body: Center(
        child: FutureBuilder<ResponseRestaurant>(
          future: Api.getData(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<Restaurant> restaurants = snapshot.data.restaurants;
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Restaurant restaurant = restaurants[index];
                  return card(context, restaurant);
                },
                itemCount: snapshot.data.restaurants.length,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  card(BuildContext context, Restaurant restaurant) {
    return Card(
      margin: EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(children: [
            CachedNetworkImage(imageUrl: restaurant.pictureId),
            Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      restaurant.rating.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    )))
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.fade,
                    ),
                    Text(restaurant.city),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
