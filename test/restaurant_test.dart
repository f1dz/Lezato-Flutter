import 'package:flutter_test/flutter_test.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/restaurant.dart';

void main() {
  test('Should success parsing json', () {
    var _json = {
      "id": "abc123",
      "name": "Restaurant",
      "description": "Test 123",
      "pictureId": "1",
      "city": " Jakarta",
      "rating": 4.7
    };

    var restaurantObject = Restaurant(
      id: "abc123",
      name: "Restaurant",
      description: "Test 123",
      pictureId: "1",
      city: "Jakarta",
      rating: 4.7,
    );
    var result = Restaurant.fromJson(_json);

    expect(result.name, restaurantObject.name);
  });

  test("Should get restaurant name from API", () async {
    final api = ApiService();
    var id = "rqdv5juczeskfw1e867";
    var expectedName = "Melting Pot";

    var restaurant = await api.getDetail(id);

    expect(restaurant.restaurant.name, expectedName);
  });
}
