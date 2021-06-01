import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:lezato/ui/detail_screen.dart';
import 'package:lezato/widget/custom_sliver_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => AppProvider(apiService: ApiService()).getRestaurants(),
      child: CustomScrollView(
        slivers: [
          Consumer<AppProvider>(
            builder: (context, provider, _) {
              return SliverPersistentHeader(
                delegate: CustomSliverAppBar(expandedHeight: 250, provider: provider),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          Consumer<AppProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.state == ResultState.HasData) {
                return SliverList(
                    delegate: SliverChildListDelegate(
                        state.result.restaurants.map((restaurant) => item(context, restaurant)).toList()));
              } else if (state.state == ResultState.Error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(child: Lottie.asset('assets/json/search_empty.json')),
                );
              }
            },
          )
        ],
      ),
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
                        imageUrl: restaurant.getSmallPicture(),
                        width: 150,
                        height: 140,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, data, _) => Center(
                          child: CircularProgressIndicator(),
                          widthFactor: 0.5,
                        ),
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
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text("${restaurant.rating}"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.red,
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
