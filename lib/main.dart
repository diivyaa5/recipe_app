// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

// void main() {
//   runApp(RecipeApp());
// }

// class Recipe {
//   final String title;
//   final String? imageUrl;
//   final List<String> ingredients;
//   final String instructions;
//   final String category;

//   Recipe({
//     required this.title,
//     this.imageUrl,
//     required this.ingredients,
//     required this.instructions,
//     required this.category,
//   });

//   factory Recipe.fromJson(Map<String, dynamic> json) {
//     return Recipe(
//       title: json['title'],
//       imageUrl: json['imageUrl'],
//       ingredients: List<String>.from(json['ingredients']),
//       instructions: json['instructions'],
//       category: json['category'],
//     );
//   }
// }

// class RecipeApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Recipe App',
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//         scaffoldBackgroundColor: Colors.grey[100],
//         textTheme: Theme.of(context).textTheme.apply(
//               fontFamily: 'Roboto',
//             ),
//       ),
//       home: RecipeListScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class RecipeListScreen extends StatefulWidget {
//   @override
//   _RecipeListScreenState createState() => _RecipeListScreenState();
// }

// class _RecipeListScreenState extends State<RecipeListScreen> {
//   List<Recipe> _allRecipes = [];
//   List<Recipe> _filteredRecipes = [];
//   String _searchQuery = '';
//   String _selectedCategory = 'All';

//   @override
//   void initState() {
//     super.initState();
//     _loadRecipes();
//   }

//   Future<void> _loadRecipes() async {
//     final data = await rootBundle.loadString('assets/recipes.json');
//     final List<dynamic> jsonResult = json.decode(data);
//     final recipes = jsonResult.map((json) => Recipe.fromJson(json)).toList();
//     setState(() {
//       _allRecipes = recipes;
//       _filteredRecipes = recipes;
//     });
//   }

//   void _filterRecipes(String query) {
//     setState(() {matchesCategory
//       _searchQuery = query;
//       _filteredRecipes = _allRecipes.where((recipe) {
//         final matchesTitle = recipe.title.toLowerCase().contains(query.toLowerCase());
//         final matchesCategory = _selectedCategory == 'All' || recipe.category == _selectedCategory;
//         return matchesTitle && ;
//       }).toList();
//     });
//   }

//   void _filterByCategory(String category) {
//     setState(() {
//       _selectedCategory = category;
//       _filterRecipes(_searchQuery);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categories = ['All'] + _allRecipes.map((r) => r.category).toSet().toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🍽️ Recipes'),
//         centerTitle: true,
//         elevation: 2,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               onChanged: _filterRecipes,
//               decoration: InputDecoration(
//                 hintText: 'Search recipes...',
//                 prefixIcon: Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 45,
//             padding: const EdgeInsets.only(left: 8),
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: categories.map((category) {
//                 final isSelected = _selectedCategory == category;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 6.0),
//                   child: ChoiceChip(
//                     label: Text(category),
//                     selected: isSelected,
//                     labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
//                     selectedColor: Colors.deepOrange,
//                     onSelected: (_) => _filterByCategory(category),
//                     backgroundColor: Colors.grey[200],
//                     shape: StadiumBorder(),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredRecipes.length,
//               itemBuilder: (context, index) {
//                 final recipe = _filteredRecipes[index];
//                 return Card(
//                   elevation: 3,
//                   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(10),
//                     leading: CircleAvatar(
//                       radius: 28,
//                       backgroundColor: Colors.deepOrange[100],
//                       child: recipe.imageUrl != null
//                           ? ClipOval(
//                               child: Image.network(recipe.imageUrl!, fit: BoxFit.cover, width: 56, height: 56),
//                             )
//                           : Icon(Icons.fastfood, color: Colors.deepOrange),
//                     ),
//                     title: Text(recipe.title, style: TextStyle(fontWeight: FontWeight.bold)),
//                     subtitle: Text(recipe.category),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => RecipeDetailsScreen(recipe: recipe),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RecipeDetailsScreen extends StatelessWidget {
//   final Recipe recipe;

//   RecipeDetailsScreen({required this.recipe});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(recipe.title)),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (recipe.imageUrl != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//                 child: Image.network(
//                   recipe.imageUrl!,
//                   width: double.infinity,
//                   height: 220,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 recipe.title,
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text('🧂 Ingredients',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.deepOrange)),
//             ),
//             ...recipe.ingredients.map((ing) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                   child: Row(
//                     children: [
//                       Icon(Icons.check_circle_outline, color: Colors.deepOrange, size: 20),
//                       SizedBox(width: 8),
//                       Text(ing, style: TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 )),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('📋 Instructions',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.deepOrange)),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//               child: Text(
//                 recipe.instructions,
//                 style: TextStyle(fontSize: 16, height: 1.5),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';



void main() {
  runApp(RecipeApp());
}

class Recipe {
  final String title;
  final String? imageUrl;
  final List<String> ingredients;
  final String instructions;
  final String category;
  final String youtubeUrl;
  final String prepTime;
  final String cookTime;
  final int servings;

  Recipe({
    required this.title,
    this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.youtubeUrl,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
      category: json['category'],
      youtubeUrl: json['youtubeUrl'],
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      servings: json['servings'],
    );
  }
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Roboto',
            ),
      ),
      home: RecipeListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> _allRecipes = [];
  List<Recipe> _filteredRecipes = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final data = await rootBundle.loadString('assets/recipes.json');
    final List<dynamic> jsonResult = json.decode(data);
    final recipes = jsonResult.map((json) => Recipe.fromJson(json)).toList();
    setState(() {
      _allRecipes = recipes;
      _filteredRecipes = recipes;
    });
  }

  void _filterRecipes(String query) {
    setState(() {
      _searchQuery = query;
      _filteredRecipes = _allRecipes.where((recipe) {
        final matchesTitle = recipe.title.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = _selectedCategory == 'All' || recipe.category == _selectedCategory;
        return matchesTitle && matchesCategory;
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterRecipes(_searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All'] + _allRecipes.map((r) => r.category).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('🍽️ Recipes'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            padding: const EdgeInsets.only(left: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    selectedColor: Colors.deepOrange,
                    onSelected: (_) => _filterByCategory(category),
                    backgroundColor: Colors.grey[200],
                    shape: StadiumBorder(),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = _filteredRecipes[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.deepOrange[100],
                      child: recipe.imageUrl != null
                          ? ClipOval(
                              child: Image.network(recipe.imageUrl!, fit: BoxFit.cover, width: 56, height: 56),
                            )
                          : Icon(Icons.fastfood, color: Colors.deepOrange),
                    ),
                    title: Text(recipe.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(recipe.category),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsScreen(recipe: recipe),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.network(
                  recipe.imageUrl!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipe.title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('🧂 Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.deepOrange)),
            ),
            ...recipe.ingredients.map((ing) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.deepOrange, size: 20),
                      SizedBox(width: 8),
                      Text(ing, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('📋 Instructions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.deepOrange)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                recipe.instructions,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('⏳ Prep Time: ${recipe.prepTime}\n🍳 Cook Time: ${recipe.cookTime}\n🍽️ Servings: ${recipe.servings}',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  // Launch YouTube video (if desired)
                  _launchURL(recipe.youtubeUrl);
                },
                child: Text('Watch Video'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    // Launch URL using url_launcher package
     final Uri uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
  }
}
