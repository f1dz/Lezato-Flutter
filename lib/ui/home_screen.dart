import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:lezato/ui/detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Center(child: Text('')),
        // ),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Center(
            child: Text(
              'Lezato',
              style: TextStyle(color: Colors.red),
            ),
          ),
          floating: true,
          expandedHeight: 200,
          flexibleSpace: Image.asset(
            'assets/images/restaurant_small.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AppProvider(apiService: ApiService()).getRestaurants(),
          child: Consumer<AppProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.state == ResultState.HasData) {
                return SliverList(
                    delegate: SliverChildListDelegate(
                        state.result.restaurants.map((restaurant) => item(context, restaurant)).toList()));
              } else {
                return SliverToBoxAdapter(
                  child: Text('No data found'),
                );
              }
            },
          ),
        )
      ],
    ));
  }

  Widget item(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(restaurant: restaurant);
        }));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                    tag: restaurant.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: restaurant.pictureId,
                        width: 150,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    )),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          restaurant.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        RatingBarIndicator(
                            rating: restaurant.rating,
                            itemSize: 24,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
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
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black26,
            height: 1,
            indent: 16,
            endIndent: 16,
          )
        ],
      ),
    );
  }
}
