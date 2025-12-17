import 'package:flutter/material.dart';
import '../data/property_models.dart';
import '../data/property_repository.dart';
import '../data/map_data.dart' as map_data; // add this import with alias

class PropertyProvider extends ChangeNotifier {
  final PropertyRepository _repository;

  PropertyProvider(this._repository);

  // ===== STATE =====
  List<Property> _properties = [];
  bool _isLoading = false;
  String? _error;

  int _currentPage = 1;
  int _totalPages = 1;
  final int _limit = 10;

  map_data.MapData? _mapData; // use the alias

  // ===== GETTERS =====
  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  map_data.MapData? get mapData => _mapData; // only one getter

  // ===== CORE ACTION =====
  Future<void> loadProperties({int page = 1}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _repository.fetchProperties(
        page: page,
        limit: _limit,
      );

      _properties = response.data.properties;
      _currentPage = response.data.pagination.page;
      _totalPages = response.data.pagination.pages;

      // Make sure response.data.maps is of type map_data.MapData
      _mapData = response.data.maps; 
    } catch (e) {
      _error = 'Failed to load properties';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===== PAGINATION =====
  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= _totalPages) {
      await loadProperties(page: page);
    }
  }

  Future<void> nextPage() async {
    if (_currentPage < _totalPages) {
      await loadProperties(page: _currentPage + 1);
    }
  }

  Future<void> previousPage() async {
    if (_currentPage > 1) {
      await loadProperties(page: _currentPage - 1);
    }
  }
}