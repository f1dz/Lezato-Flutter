import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:lezato/ui/detail_screen.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  final AppProvider provider;

  RestaurantItem({@required this.restaurant, this.provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(restaurant: restaurant);
        })).then((value) => provider?.getFavoriteRestaurants());
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
