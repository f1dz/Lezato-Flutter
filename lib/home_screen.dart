import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/detail_screen.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lezato')),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (_) {
            var provider = AppProvider(apiService: ApiService());
            provider.getRestaurants();
            return provider;
          },
          child: Consumer<AppProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                List<Restaurant> restaurants = state.result.restaurants;
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
                  itemCount: restaurants.length,
                );
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Center(child: Text(state.message));
              } else {
                return Center(
                  child: Text('No data to displayed'),
                );
              }
            },
          ),
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
