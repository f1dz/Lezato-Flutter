import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:lezato/widget/restaurant_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => AppProvider(apiService: ApiService()).getFavoriteRestaurants(),
        child: Consumer<AppProvider>(
          builder: (context, provider, _) {
            switch (provider.state) {
              case ResultState.Loading:
                return Center(child: CircularProgressIndicator());
                break;
              case ResultState.NoData:
                return Center(child: Text(provider.message));
                break;
              case ResultState.HasData:
                List<Restaurant> restaurants = provider.favoriteRestaurants;
                return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RestaurantItem(
                      restaurant: restaurants[index],
                      provider: provider,
                    );
                  },
                );
                break;
              case ResultState.Error:
                return Center(child: Text(provider.message));
                break;
            }

            return Container();
          },
        ),
      ),
    );
  }
}
