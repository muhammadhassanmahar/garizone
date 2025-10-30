import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/car_model.dart';
import 'car_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final List<CarModel> favorites = favoritesProvider.favorites;

    if (favorites.isEmpty) {
      return const Center(child: Text("No favorites added yet."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final car = favorites[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: Text(car.name),
            subtitle: Text("${car.brand} • ${car.year}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => favoritesProvider.removeFavorite(car.id),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CarDetailsScreen(car: car),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
