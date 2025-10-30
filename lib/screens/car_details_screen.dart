import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/favorites_provider.dart';

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
              // ✅ FIXED TYPE ISSUE
              if (isFavorite) {
                favoritesProvider.removeFavorite(car.id);
              } else {
                // Ensure addFavorite accepts CarModel
                favoritesProvider.addFavorite(car);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Show image or fallback icon
            if (car.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  car.imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.directions_car, size: 100, color: Colors.blueAccent),
                ),
              )
            else
              const Icon(Icons.directions_car, size: 100, color: Colors.blueAccent),

            const SizedBox(height: 20),

            Text(
              car.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              car.brand,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),

            const SizedBox(height: 10),
            Text("Year: ${car.year ?? 'N/A'}",
                style: const TextStyle(fontSize: 16)),
            Text("Price: \$${car.price}",
                style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),
            Text(
              car.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
