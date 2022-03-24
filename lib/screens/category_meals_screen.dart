import 'package:flutter/material.dart';
import 'package:restaraunt_meals/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  /*final String categoryId;
  String categoryTitle;
  const CategoryMealScreen(this.categoryId, this.categoryTitle, {Key? key})
      : super(key: key);*/
  //const CategoryMealScreen({Key? key}) : super(key: key);
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;
  const CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  late List<Meal> dispalyedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      final categoryTitle = routeArgs['title'];
      dispalyedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      dispalyedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? ""),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: dispalyedMeals[index].title,
            imageUrl: dispalyedMeals[index].imageUrl,
            duration: dispalyedMeals[index].duration,
            complexity: dispalyedMeals[index].complexity,
            affordability: dispalyedMeals[index].affordability,
            id: dispalyedMeals[index].id,           
          );
        },
        itemCount: dispalyedMeals.length,
      ),
    );
  }
}
