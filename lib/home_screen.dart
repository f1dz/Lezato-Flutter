import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/data/response_restaurant.dart';
import 'package:lezato/detail_screen.dart';

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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DetailScreen(restaurant: restaurant);
                      }));
                    },
                    child: item(context, restaurant),
                  );
                },
                itemCount: snapshot.data.restaurants.length,
              );
            } else {
              return Container(
                child: Center(
                  child: Text('No data to displayed'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  item(BuildContext context, Restaurant restaurant) {
    return Card(
      margin: EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(children: [
            Hero(tag: restaurant.id, child: CachedNetworkImage(imageUrl: restaurant.pictureId)),
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
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(restaurant.city),
                      ],
                    ),
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
