import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:lezato/ui/detail_screen.dart';
import 'package:lezato/utils/notification_helper.dart';
import 'package:lezato/widget/custom_sliver_appbar.dart';
import 'package:lezato/widget/restaurant_item.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(DetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => AppProvider().getRestaurants(),
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
                    delegate: SliverChildListDelegate(state.result.restaurants
                        .map((restaurant) => RestaurantItem(restaurant: restaurant))
                        .toList()));
              } else if (state.state == ResultState.Error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Lottie.asset('assets/json/no_internet.json'),
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
}
