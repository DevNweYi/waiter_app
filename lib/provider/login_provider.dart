import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/model/waiter_model.dart';

import '../value/app_string.dart';

class LoginProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  List<Map<String, dynamic>> _lstWaiter = [];
  Map<String, dynamic> _selectedWaiter = {
    "WaiterID": 0,
    "WaiterName": "",
  };

  List<Map<String, dynamic>> get lstWaiter => _lstWaiter;

  //Map<String, dynamic> get selectedWaiter => _selectedWaiter;

  void setWaiterList(List<Map<String, dynamic>> lstWaiter) {
    _lstWaiter = lstWaiter;
    //notifyListeners();
  }

  void setSelectedWaiter(Map<String, dynamic> selectedWaiter) {
    _selectedWaiter = selectedWaiter;
    nameController.text = selectedWaiter["WaiterName"];
    notifyListeners();
  }

  Future<bool> authenticate() async {
    if (isValidateControl()) {
      int waiterId = _selectedWaiter["WaiterID"];
      String waiterName = _selectedWaiter["WaiterName"];

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt("WaiterID", waiterId);
      sharedPreferences.setString("WaiterName", waiterName);

      return true;
    }
    return false;
  }

  bool isValidateControl() {
    String password = "";
    String inputPassword = passwordController.text;
    if (_lstWaiter.isNotEmpty) {
      password = _selectedWaiter["Password"];
    }

    if (_lstWaiter.isEmpty) {
      Fluttertoast.showToast(msg: AppString.notFoundWaiter);
      return false;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterPassword);
      return false;
    } else if (password != inputPassword) {
      Fluttertoast.showToast(msg: AppString.invalidLogin);
      return false;
    }
    return true;
  }

  Future<WaiterModel> getLoginWaiter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? waiterId = sharedPreferences.getInt("WaiterID");
    String? waiterName = sharedPreferences.getString("WaiterName");
    return WaiterModel(
        waiterId: waiterId ?? 0, waiterName: waiterName ?? "", password: "");
  }
}
