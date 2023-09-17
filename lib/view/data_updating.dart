import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/data_updating_provider.dart';
import 'package:waiter_app/view/login.dart';

import '../api/apiservice.dart';
import '../database/database_helper.dart';
import '../model/connector_model.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import 'package:dio/dio.dart';

class DataUpdating extends StatefulWidget {
  const DataUpdating({super.key});

  @override
  State<DataUpdating> createState() => _DataUpdatingState();
}

class _DataUpdatingState extends State<DataUpdating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppString.updateData,
        style: TextStyle(color: AppColor.primary),
      )),
      body: Consumer<DataUpdatingProvider>(builder: (context, provider, child) {
        return provider.isWaiterComplete &&
                provider.isMainMenuComplete &&
                provider.isSubMenuComplete &&
                provider.isItemComplete &&
                provider.isSystemItemComplete &&
                provider.isTableTypeComplete &&
                provider.isTableComplete &&
                provider.isTasteComplete &&
                provider.isTasteMultiComplete &&
                provider.isSystemSettingComplete
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppString.dataUpdateCompleted),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const Login();
                          }), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 30, left: 30),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                        child: const Text(AppString.login)),
                  ],
                ),
              )
            : Center(
                child: !provider.isShowLoading
                    ? ElevatedButton(
                        onPressed: () async {
                          context
                              .read<DataUpdatingProvider>()
                              .setIsShowLoading(true);
                          updateData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 30, left: 30),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                        child: const Text(AppString.update))
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppString.updatingData),
                          SizedBox(
                            height: 30,
                          ),
                          CircularProgressIndicator()
                        ],
                      ));
      }),
    );
  }

  void updateData() {
    ApiService apiService;
    List<Map<String, dynamic>> lstBaseUrl = [];
    List<Map<String, dynamic>> lstConnector = [];
    dynamic connectorModel;

    DatabaseHelper().getBaseUrl().then((value) {
      lstBaseUrl = value;

      apiService =
          ApiService(dio: Dio(BaseOptions(baseUrl: lstBaseUrl[0]["BaseUrl"])));

      DatabaseHelper().getConnector().then((value) {
        lstConnector = value;
        connectorModel = ConnectorModel(
            ipAddress: lstConnector[0]["IPAddress"],
            databaseName: lstConnector[0]["DatabaseName"],
            databaseLoginUser: lstConnector[0]["DatabaseLoginUser"],
            databaseLoginPassword: lstConnector[0]["DatabaseLoginPassword"]);

        apiService.getWaiter(connectorModel).then((lstWaiter) {
          DatabaseHelper().insertWaiter(lstWaiter).then((value) {
            if (lstWaiter.length == value) {
              setState(() {
                context.read<DataUpdatingProvider>().setIsWaiterComplete(true);
              });
            }
          });
        });

        apiService.getMainMenu(connectorModel).then((lstMainMenu) {
          DatabaseHelper().insertMainMenu(lstMainMenu).then((value) {
            if (lstMainMenu.length == value) {
              setState(() {
                context
                    .read<DataUpdatingProvider>()
                    .setIsMainMenuComplete(true);
              });
            }
          });
        });

        apiService.getSubMenu(connectorModel).then((lstSubMenu) {
          DatabaseHelper().insertSubMenu(lstSubMenu).then((value) {
            if (lstSubMenu.length == value) {
              setState(() {
                context.read<DataUpdatingProvider>().setIsSubMenuComplete(true);
              });
            }
          });
        });

        apiService.getItem(connectorModel).then((lstItem) {
          DatabaseHelper().insertItem(lstItem).then((value) {
            if (lstItem.length == value) {
              setState(() {
                context.read<DataUpdatingProvider>().setIsItemComplete(true);
              });
            }
          });
        });

        apiService.getSystemItem(connectorModel).then((lstSystemItem) {
          DatabaseHelper().insertSystemItem(lstSystemItem).then((value) {
            if (lstSystemItem.length == value) {
              setState(() {
                context
                    .read<DataUpdatingProvider>()
                    .setIsSystemItemComplete(true);
              });
            }
          });
        });

        apiService.getTableType(connectorModel).then((lstTableType) {
          DatabaseHelper().insertTableType(lstTableType).then((value) {
            if (lstTableType.length == value) {
              setState(() {
                context
                    .read<DataUpdatingProvider>()
                    .setIsTableTypeComplete(true);
              });
            }
          });
        });

        apiService.getTable(connectorModel).then((lstTable) {
          DatabaseHelper().insertTable(lstTable).then((value) {
            if (lstTable.length == value) {
              setState(() {
                context.read<DataUpdatingProvider>().setIsTableComplete(true);
              });
            }
          });
        });

        apiService.getTaste(connectorModel).then((lstTaste) {
          DatabaseHelper().insertTaste(lstTaste).then((value) {
            if (lstTaste.length == value) {
              setState(() {
                context.read<DataUpdatingProvider>().setIsTasteComplete(true);
              });
            }
          });
        });

        apiService.getTasteMulti(connectorModel).then((lstTasteMulti) {
          DatabaseHelper().insertTasteMulti(lstTasteMulti).then((value) {
            if (lstTasteMulti.length == value) {
              setState(() {
                context
                    .read<DataUpdatingProvider>()
                    .setIsTasteMultiComplete(true);
              });
            }
          });
        });

        apiService.getSystemSetting(connectorModel).then((lstSystemSetting) {
          if (lstSystemSetting.isNotEmpty) {
            DatabaseHelper().insertSystemSetting({
              "tax": lstSystemSetting[0].tax,
              "service": lstSystemSetting[0].service,
              "adminPassword": lstSystemSetting[0].adminPassword,
              "title": lstSystemSetting[0].title,
              "userPassword": lstSystemSetting[0].userPassword
            }).then((value) {
              if (value == 1) {
                setState(() {
                  context
                      .read<DataUpdatingProvider>()
                      .setIsSystemSettingComplete(true);
                });
              }
            });
          }
        });
      });
    });
  }
}
