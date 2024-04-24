import 'package:flutter/material.dart';
import 'package:movies_app/db_helper/db_helper.dart';
import 'package:movies_app/models/person.dart';

class User with ChangeNotifier{
Person person =Person(id: '1',name: '');
Future<void> getUserData()async{
final data= await DBHelper.getData();
person=Person(name:data?['name']==null?'User': data!['name'].toString(), id: '1');
notifyListeners();
}
Future<void> changeUserName(String name)async{
await DBHelper.update(name);
person=Person(name:name, id: '1');
notifyListeners();
}
}
