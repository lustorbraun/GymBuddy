import 'package:flutter/material.dart';
import 'package:gym_buddy/src/models/itemModel.dart';
import 'package:gym_buddy/src/resources/databaseProvider.dart';

final dbHelper = DatabaseProvider.instance;

class PhotosProvider extends ChangeNotifier {
  List<ItemModel> _itemModelList = [];
  List<ItemModel> _filtereditemModelList = [];
  String _filter = "Biceps";

  void setfilter(String filter){
    print("filter changed from $_filter ");
    _filter = filter;
    print("to $_filter");
    notifyListeners();
  }

  String get filtere{
    return _filter;
  }

  List<ItemModel> get photosList{
    return _itemModelList;
  }

  List<ItemModel> get filteredphotosList{
    return _filtereditemModelList;
  }

  void addImage( ItemModel itemModel ) async {
     await dbHelper.insert(itemModel.toMap());
     _itemModelList.add(itemModel);
     notifyListeners();
  }

  void updateFilteredPhotos() async {
    List<Map<String,dynamic>> _listMap =await dbHelper.queryFilteredRows(_filter);
    List<ItemModel> _itemModelListTemp = [];
    if(_listMap.isNotEmpty){
      _listMap.forEach((map) {
        _itemModelListTemp.add(ItemModel.fromMap(map));
      });
    }
    _filtereditemModelList = _itemModelListTemp.reversed.toList();
    print("${_listMap.length}");
  }

  void updatePhotos() async {
    List<Map<String,dynamic>> _listMap =await dbHelper.queryAllRows();
    List<ItemModel> _itemModelListTemp = [];
    if(_listMap.isNotEmpty){
      _listMap.forEach((map) {
        _itemModelListTemp.add(ItemModel.fromMap(map));
      });
    }
    _itemModelList = _itemModelListTemp.reversed.toList();
    print("${_listMap.length}");
  }

  void deleteImage( int id ) async {
    int status = await dbHelper.delete(id);
    _itemModelList.removeWhere((model){
      return model.id == id;
    });
    print("status of deletion of item with id : $id was $status ");
    notifyListeners();
  }

}