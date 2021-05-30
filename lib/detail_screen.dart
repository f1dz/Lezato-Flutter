import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'data/model/food.dart';

class DetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  DetailScreen({@required this.restaurant});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        var provider = AppProvider(apiService: ApiService());
        provider.getRestaurant(widget.restaurant.id);
        return provider;
      },
      child: Consumer<AppProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            return screen(state.restaurant.restaurant);
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
    );
  }

  menuList(List<dynamic> menus) {
    return SliverPadding(
      padding: EdgeInsets.all(4),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: menus.map((e) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.center,
                          image: (e.runtimeType == Food)
                              ? AssetImage('assets/images/food.jpeg')
                              : AssetImage('assets/images/drink.jpeg'))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e.name),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  screen(Restaurant restaurant) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant.name),
              background: Hero(
                tag: restaurant.id,
                child: CachedNetworkImage(
                  imageUrl: restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Container(
                              padding: EdgeInsets.all(6.0),
                              decoration:
                                  BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                restaurant.rating.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          Text(restaurant.city, style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                      Text(restaurant.description),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(4),
            sliver: SliverToBoxAdapter(
                child: Text(
              'Foods',
              style: Theme.of(context).textTheme.headline6,
            )),
          ),
          menuList(restaurant.menus.foods),
          SliverPadding(
            padding: EdgeInsets.all(4),
            sliver: SliverToBoxAdapter(
                child: Text(
              'Drinks',
              style: Theme.of(context).textTheme.headline6,
            )),
          ),
          menuList(restaurant.menus.drinks),
        ],
      ),
    );
  }
}
