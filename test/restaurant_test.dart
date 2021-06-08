import 'package:flutter_test/flutter_test.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/response/response_restaurant_detail.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([AppProvider, ApiService])
void main() {
  group('Restaurant Test', () {
    Restaurant restaurant;
    ApiService apiService;
    AppProvider appProvider;

    setUp(() {
      apiService = MockApiService();
      appProvider = MockAppProvider();
      restaurant = Restaurant(
        id: "abc123",
        name: "Restaurant",
        description: "Test 123",
        pictureId: "1",
        city: "Jakarta",
        rating: 4.7,
      );
    });

    test('Should success parsing json', () {
      var result = Restaurant.fromJson(restaurant.toJson());

      expect(result.name, restaurant.name);
    });

    test("Should return restaurant detail from API", () async {
      when(apiService.getDetail(restaurant.id)).thenAnswer((_) async {
        return ResponseRestaurantDetail(
          error: false,
          message: 'success',
          restaurant: restaurant,
        );
      });

      expect(await apiService.getDetail(restaurant.id), isA<ResponseRestaurantDetail>());
    });

    test('Should return favorite restaurant', () {
      when(appProvider.favoriteRestaurants).thenAnswer((realInvocation) {
        List<Restaurant> restaurants = [restaurant];
        return restaurants;
      });
      expect(appProvider.favoriteRestaurants, isA<List<Restaurant>>());
    });
  });
}
