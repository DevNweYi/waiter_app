import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/value/app_constant.dart';

import '../value/app_string.dart';

class LocalServerConController {
  final ipAddressController = TextEditingController();
  final databaseNameController = TextEditingController();
  final databaseLoginUserController = TextEditingController();
  final databaseLoginPasswordController = TextEditingController();

  Future<bool> save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isValidateControl()) {
      sharedPreferences.setString("IPAddress", ipAddressController.text);
      sharedPreferences.setString("DatabaseName", databaseNameController.text);
      sharedPreferences.setString(
          "DatabaseLoginUser", databaseLoginUserController.text);
      sharedPreferences.setString(
          "DatabaseLoginPassword", databaseLoginPasswordController.text);
      sharedPreferences.setString(
          "BaseUrl", "http://$ipAddressController.text/WaiterWebService/api/");

      String ipAddress = ipAddressController.text;

      AppConstant.baseUrl = "http://$ipAddress/WaiterWebService/api/";

      AppConstant.connectorModel = ConnectorModel(
          ipAddress: sharedPreferences.getString("IPAddress").toString(),
          databaseName: sharedPreferences.getString("DatabaseName").toString(),
          databaseLoginUser:
              sharedPreferences.getString("DatabaseLoginUser").toString(),
          databaseLoginPassword:
              sharedPreferences.getString("DatabaseLoginPassword").toString());

      return true;
    }
    return false;
  }

  /* Future<void> fillLocalServerData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ipAddressController.text =
        sharedPreferences.getString("IPAddress").toString();
    databaseNameController.text =
        sharedPreferences.getString("DatabaseName").toString();
    databaseLoginUserController.text =
        sharedPreferences.getString("DatabaseLoginUser").toString();
    databaseLoginPasswordController.text =
        sharedPreferences.getString("DatabaseLoginPassword").toString();
  } */

  bool isValidateControl() {
    if (ipAddressController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterIPAddress);
      return false;
    } else if (databaseNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterDatabaseName);
      return false;
    } else if (databaseLoginUserController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterDatabaseLoginUser);
      return false;
    } else if (databaseLoginPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: AppString.enterDatabaseLoginPassword);
      return false;
    }
    return true;
  }
}
