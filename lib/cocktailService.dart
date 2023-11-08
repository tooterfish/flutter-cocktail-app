import 'package:http/http.dart' as http;
import 'dart:convert';

class Cocktail {
  final String name;
  final String glass;
  final String instructions;
  final List ingredients;
  final List measures;
  final String thumbnail;

  const Cocktail({
    required this.name,
    required this.glass,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    required this.thumbnail,
  });
}

class CocktailService {
  Future<Cocktail> getCocktail() async {
    final response = await http.get(
        Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/random.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final drinkData = data['drinks'][0];
      //put ingredients and measures data into lists so they're easier to render later
      List ingredients = [];
      List measures = [];
      for (var i = 1; i <= 15; i++) {
        if (drinkData['strIngredient${i}'] != null) {
          ingredients.add(drinkData['strIngredient${i}']);
        }
        if (drinkData['strMeasure${i}'] != null) {
          measures.add(drinkData['strMeasure${i}']);
        }
      }

      //construct our output object
      final cocktail = Cocktail(
        name: drinkData['strDrink'],
        glass: drinkData['strGlass'],
        instructions: drinkData['strInstructions'],
        ingredients: ingredients,
        measures: measures,
        thumbnail: drinkData['strDrinkThumb'],
      );
      // print(cocktail.ingredients);
      return cocktail;
    } else {
      throw Exception('HTTP Failed');
    }
  }
}
