import 'package:flutter/material.dart';
import 'package:waiter_app/provider/order_provider.dart';

class TasteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> lstTaste = [];
  String _selectedTaste = "";
  final tasteController = TextEditingController();

  String get selectedTaste => _selectedTaste;

  void setSelectedTaste(String taste) {
    _selectedTaste = "$_selectedTaste$taste,";
    tasteController.text = _selectedTaste;
    notifyListeners();
  }

  void clearSelectedTaste() {
    _selectedTaste = "";
    tasteController.text = "";
    notifyListeners();
  }
}
