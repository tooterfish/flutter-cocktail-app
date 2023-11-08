import 'package:http/http.dart' as http;
import 'dart:convert';

class Cocktail {
  final String name;

  const Cocktail({
    required this.name,
  });
}

class CocktailService {
  Future<Cocktail> getCocktail() async {
    final response = await http.get(
        Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/random.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final drinkData = data['drinks'][0];
      final cocktail = Cocktail(name: drinkData['strDrink']);
      // print(cocktail.name);
      return cocktail;
    } else {
      throw Exception('HTTP Failed');
    }
  }
}
