import 'package:flutter/material.dart';
import '../services/car_service.dart';

class CarProvider with ChangeNotifier {
  List<dynamic> _cars = [];
  bool _isLoading = false;

  List<dynamic> get cars => _cars;
  bool get isLoading => _isLoading;

  Future<void> fetchCars() async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await CarService.getCars();
      _cars = data;
    } catch (e) {
      _cars = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCar(Map<String, dynamic> car) async {
    await CarService.addCar(car);
    await fetchCars();
  }

  Future<void> deleteCar(String id) async {
    await CarService.deleteCar(id);
    await fetchCars();
  }
}
