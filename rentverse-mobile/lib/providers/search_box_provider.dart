import 'package:flutter/material.dart';

class SearchBoxProvider extends ChangeNotifier {
  String whereValue = '';
  int monthCount = 0;
  int yearCount = 0;
  String? typeValue;

  bool isWhereOpen = false;
  bool isDurationOpen = false;
  bool isTypeOpen = false;

  void setWhere(String value) {
    whereValue = value;
    notifyListeners();
  }

  void incrementMonth() {
    monthCount++;
    notifyListeners();
  }

  void decrementMonth() {
    if (monthCount > 0) monthCount--;
    notifyListeners();
  }

  void incrementYear() {
    yearCount++;
    notifyListeners();
  }

  void decrementYear() {
    if (yearCount > 0) yearCount--;
    notifyListeners();
  }

  String get durationText {
    if (monthCount == 0 && yearCount == 0) return 'Select duration';
    return '${yearCount > 0 ? '$yearCount year ' : ''}'
           '${monthCount > 0 ? '$monthCount month' : ''}';
  }

  String get typeText => typeValue ?? 'Select type';
}