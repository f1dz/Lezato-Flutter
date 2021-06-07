import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;
  final AppProvider provider;

  const FavoriteButton({this.restaurant, this.provider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider().getFavoriteRestaurants(),
      child: Consumer<AppProvider>(builder: (context, provider, _) {
        switch (provider.state) {
          case ResultState.Loading:
            return Icon(Icons.favorite_outline);
            break;
          case ResultState.NoData:
            return IconButton(
              icon: Icon(Icons.favorite_outline),
              onPressed: () {
                provider.toggleFavorite(restaurant).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved to favorite")));
                });
              },
            );
            break;
          case ResultState.HasData:
            return provider.favoriteRestaurants.where((element) => element.id == restaurant.id).isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {
                      provider.toggleFavorite(restaurant).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Removed from favorite")));
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.favorite_outline),
                    onPressed: () {
                      provider.toggleFavorite(restaurant).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Saved to favorite")));
                      });
                    },
                  );
            break;
          case ResultState.Error:
            return Icon(Icons.favorite_outline);
            break;
        }
        return Container();
      }),
    );
  }
}
