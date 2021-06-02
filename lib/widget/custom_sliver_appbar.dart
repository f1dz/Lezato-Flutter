///
/// This widget was brought and customized from here
/// [link] https://medium.com/flutter-community/flutter-increase-the-power-of-your-appbar-sliverappbar-c4f67c4e076f
///
import 'package:flutter/material.dart';
import 'package:lezato/provider/app_provider.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final AppProvider provider;

  CustomSliverAppBar({@required this.expandedHeight, @required this.provider});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/restaurant_small.jpeg',
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: -25,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  child: Container(
                      child: TextFormField(
                    onChanged: (value) {
                      if (value.length >= 3)
                        provider.onSearch(value);
                      else if (value.length == 0) provider.onSearch(value);
                    },
                    decoration: InputDecoration(
                        hintText: "Search restaurant or menu",
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 15)),
                  )),
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
