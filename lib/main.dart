import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cocktail_app/cocktailService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Cocktail> futureCocktail;

  @override
  void initState() {
    super.initState();
    futureCocktail = CocktailService().getCocktail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Cocktail Ideas'),
          FutureBuilder(
              future: futureCocktail,
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data);
                  return Text(snapshot.data.name);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  futureCocktail = CocktailService().getCocktail();
                });
              },
              child: Text('Surprise Me!')),
        ],
      ),
    );
  }
}
