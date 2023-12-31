import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/view/data_updating.dart';
import 'package:waiter_app/view/local_server_connection.dart';
import 'package:waiter_app/view/manage_main_menu.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../nav_drawer.dart';
import '../../provider/setting_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_setting.dart';
import '../../value/app_string.dart';
import '../../value/password_type.dart';
import '../dialog/dialog_password.dart';

class NavSetting extends StatefulWidget {
  const NavSetting({super.key});

  @override
  State<NavSetting> createState() => _NavSettingState();
}

class _NavSettingState extends State<NavSetting> {
  @override
  void initState() {
    context.read<SettingProvider>().fillGeneralSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(AppString.setting,
            style: TextStyle(color: AppColor.primary)),
        iconTheme: const IconThemeData(color: AppColor.primary),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.grey,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: AppString.general,
                    color: AppColor.primary,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: const Text(
                      AppSetting.addTimeByItemInOrder,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.addTimeByItemInOrder ?? false,
                        onChanged: (value) {
                          provider.setAddTimeByItemInOrder(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.showTasteInSelectItem,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.showTasteInSelectItem ?? false,
                        onChanged: (value) {
                          provider.setShowTasteInSelectItem(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.useTasteByMenu,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.useTasteByMenu ?? false,
                        onChanged: (value) {
                          provider.setUseTasteByMenu(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.notPutItemAndTasteInOrder,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.notPutItemAndTasteInOrder ?? false,
                        onChanged: (value) {
                          provider.setNotPutItemAndTasteInOrder(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.addStartTimeInOrder,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.addStartTimeInOrder ?? false,
                        onChanged: (value) {
                          provider.setAddStartTimeInOrder(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.hideSalePriceInItem,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.hideSalePriceInItem ?? false,
                        onChanged: (value) {
                          provider.setHideSalePriceInItem(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.hideCommercialTax,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.hideCommercialTax ?? false,
                        onChanged: (value) {
                          provider.setHideCommercialTax(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.calculateAdvancedTax,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.calculateAdvancedTax ?? false,
                        onChanged: (value) {
                          provider.setCalculateAdvancedTax(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      AppSetting.addCustomerByTotalPerson,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    ),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.addCustomerByTotalPerson ?? false,
                        onChanged: (value) {
                          provider.setAddCustomerByTotalPerson(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: AppString.data,
                    color: AppColor.primary,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      title: const Text(
                        AppString.localServerConnection,
                        style: TextStyle(
                          color: AppColor.primaryDark,
                        ),
                        maxLines: null,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog<void>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogPassword(
                                    passwordType:
                                        PasswordType.localServerPassword,
                                  );
                                });
                          },
                          icon: const Icon(Icons.arrow_right))),
                  const Divider(),
                  ListTile(
                      title: const Text(
                        AppString.updateData,
                        style: TextStyle(
                          color: AppColor.primaryDark,
                        ),
                        maxLines: null,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const DataUpdating();
                            }));
                          },
                          icon: const Icon(Icons.arrow_right))),
                  const Divider(),
                  ListTile(
                      title: const Text(
                        AppString.manageMainMenu,
                        style: TextStyle(
                          color: AppColor.primaryDark,
                        ),
                        maxLines: null,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ManageMainMenu();
                            }));
                          },
                          icon: const Icon(Icons.arrow_right))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
