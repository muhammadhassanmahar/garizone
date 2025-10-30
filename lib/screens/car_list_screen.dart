import 'package:flutter/material.dart';
import 'car_details_screen.dart';
import '../models/car_model.dart';
import '../providers/car_provider.dart';
import 'package:provider/provider.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CarProvider>(context, listen: false).fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    final cars = carProvider.cars;

    if (carProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cars.isEmpty) {
      return const Center(child: Text("No cars available"));
    }

    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.directions_car, color: Colors.blueAccent),
            title: Text(car.name),
            subtitle: Text("${car.brand} • ${car.year}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
