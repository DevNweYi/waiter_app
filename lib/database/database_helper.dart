import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _db;
  static const String tbBaseUrl = "BaseUrl";
  static const String tbConnector = "Connector";
  static const String tbWaiter = "Waiter";
  static const String tbTableType = "TableType";
  static const String tbTable = "Table";
  static const String tbMainMenu = "MainMenu";
  static const String tbSubMenu = "SubMenu";
  static const String tbItem = "Item";
  static const String tbSystemItem = "SystemItem";
  static const String tbSystemSetting = "SystemSetting";
  static const String tbTaste = "Taste";
  static const String tbTasteMulti = "TasteMulti";

  Future<Database> _createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "waiter.db");
    _db = await openDatabase(path);
    await _db.execute("CREATE TABLE IF NOT EXISTS $tbBaseUrl(BaseUrl TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbConnector(IPAddress TEXT,DatabaseName TEXT,DatabaseLoginUser TEXT,DatabaseLoginPassword TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbWaiter(WaiterID INTEGER,WaiterName TEXT,Password TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbTableType(TableTypeID INTEGER,TableTypeName TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbTable(TableID INTEGER,TableName TEXT,TableTypeID INTEGER)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbMainMenu(MainMenuID INTEGER,MainMenuName TEXT,CounterID INTEGER)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbSubMenu(SubMenuID INTEGER,MainMenuID INTEGER,SubMenuName TEXT,IncomeID INTEGER)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbItem(ItemID TEXT,SubMenuID INTEGER,ItemName TEXT,SalePrice INTEGER,SType INTEGER,OutOfOrder INTEGER,Ingredients TEXT,Barcode TEXT,NoDiscount INTEGER,ItemDiscount INTEGER)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbSystemItem(SystemID INTEGER,ItemID TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbSystemSetting(Tax INTEGER,Service INTEGER,AdminPassword TEXT,Title TEXT,UserPassword TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbTaste(TasteID INTEGER,TasteName TEXT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS $tbTasteMulti(TID INTEGER,GroupID INTEGER,TasteID INTEGER,TasteName TEXT,TasteShort TEXT,TasteSort INTEGER,Price INTEGER)");
    return _db;
  }

  Future<void> deleteAllData() async{
    _db = await _createDatabase();
    await _db.delete(tbBaseUrl);
    await _db.delete(tbConnector);
    await _db.delete(tbWaiter);
    await _db.delete(tbTableType);
    await _db.delete(tbTable);
    await _db.delete(tbMainMenu);
    await _db.delete(tbSubMenu);
    await _db.delete(tbItem);
    await _db.delete(tbSystemItem);
    await _db.delete(tbSystemSetting);
    await _db.delete(tbTaste);
    await _db.delete(tbTasteMulti);
  }

  Future<int> insertBaseUrl(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbBaseUrl, data);
  }

  Future<List<Map<String, dynamic>>> getBaseUrl() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list =
        await _db.rawQuery("SELECT BaseUrl FROM $tbBaseUrl");
    return list;
  }

  Future<int> insertConnector(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbConnector, data);
  }

  Future<List<Map<String, dynamic>>> getConnector() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery(
        "SELECT IPAddress,DatabaseName,DatabaseLoginUser,DatabaseLoginPassword FROM $tbConnector");
    return list;
  }

  Future<int> insertWaiter(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbWaiter, data);
  }

  Future<List<Map<String, dynamic>>> getWaiter() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db
        .rawQuery("SELECT WaiterID,WaiterName,Password FROM $tbWaiter");
    return list;
  }

  Future<int> insertTableType(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbTableType, data);
  }

  Future<List<Map<String, dynamic>>> getTableType() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db
        .rawQuery("SELECT TableTypeID,TableTypeName FROM $tbTableType");
    return list;
  }

  Future<int> insertTable(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbTable, data);
  }

  Future<List<Map<String, dynamic>>> getTable() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db
        .rawQuery("SELECT TableID,TableName,TableTypeID FROM $tbTable");
    return list;
  }

  Future<int> insertMainMenu(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbMainMenu, data);
  }

  Future<List<Map<String, dynamic>>> getMainMenu() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db
        .rawQuery("SELECT MainMenuID,MainMenuName,CounterID FROM $tbMainMenu");
    return list;
  }

  Future<int> insertSubMenu(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbSubMenu, data);
  }

  Future<List<Map<String, dynamic>>> getSubMenu() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery(
        "SELECT SubMenuID,MainMenuID,SubMenuName,IncomeID FROM $tbSubMenu");
    return list;
  }

  Future<int> insertItem(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbItem, data);
  }

  Future<List<Map<String, dynamic>>> getItem() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery(
        "SELECT ItemID,SubMenuID,ItemName,SalePrice,SType,OutOfOrder,Ingredients,Barcode,NoDiscount,ItemDiscount FROM $tbItem");
    return list;
  }

  Future<int> insertSystemItem(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbSystemItem, data);
  }

  Future<List<Map<String, dynamic>>> getSystemItem() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list =
        await _db.rawQuery("SELECT SystemID,ItemID FROM $tbSystemItem");
    return list;
  }

  Future<int> insertSystemSetting(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbSystemSetting, data);
  }

  Future<List<Map<String, dynamic>>> getSystemSetting() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery(
        "SELECT Tax,Service,AdminPassword,Title,UserPassword FROM $tbSystemSetting");
    return list;
  }

  Future<int> insertTaste(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbTaste, data);
  }

  Future<List<Map<String, dynamic>>> getTaste() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list =
        await _db.rawQuery("SELECT TasteID,TasteName FROM $tbTaste");
    return list;
  }

  Future<int> insertTasteMulti(Map<String, dynamic> data) async {
    _db = await _createDatabase();
    return await _db.insert(tbTasteMulti, data);
  }

  Future<List<Map<String, dynamic>>> getTasteMulti() async {
    _db = await _createDatabase();
    List<Map<String, dynamic>> list = await _db.rawQuery(
        "SELECT TID,GroupID,TasteID,TasteName,TasteShort,TasteSort,Price FROM $tbTasteMulti");
    return list;
  }
}