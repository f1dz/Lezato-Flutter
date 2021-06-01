import 'package:cached_network_image/cached_network_image.dart';

///
/// This widget was brought and customized from here
/// [link] https://medium.com/flutter-community/flutter-increase-the-power-of-your-appbar-sliverappbar-c4f67c4e076f
///
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lezato/data/model/restaurant.dart';

class DetailSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Restaurant restaurant;

  DetailSliverAppBar({@required this.expandedHeight, @required this.restaurant});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Hero(
          tag: restaurant.id,
          child: CachedNetworkImage(
            imageUrl: restaurant.getMediumPicture(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 150,
          left: 8,
          right: 8,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Form(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
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
                              ],
                            ),
                            RatingBarIndicator(
                                rating: restaurant.rating,
                                itemSize: 18,
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
                                Text(restaurant.city, style: Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                            Row(
                              children: restaurant.categories
                                  .map(
                                    (cat) => Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Chip(
                                        label: Text(cat.name),
                                        backgroundColor: Colors.white,
                                        shape: StadiumBorder(side: BorderSide(color: Colors.green)),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Chip(
                              label: Text('Reviews'),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  restaurant.customerReviews.length.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              shape: StadiumBorder(side: BorderSide(color: Colors.orange)),
                            ),
                            Text(
                              restaurant.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
