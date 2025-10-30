import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarModel car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(car.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              if (isFavorite) {
                favoritesProvider.removeFavorite(car.id);
              } else {
                favoritesProvider.addFavorite(car);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.directions_car, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 20),
            Text(
              car.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(car.brand, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Year: ${car.year}"),
            Text("Price: \$${car.price}"),
            const SizedBox(height: 20),
            Text(
              car.description ?? "No description available.",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
