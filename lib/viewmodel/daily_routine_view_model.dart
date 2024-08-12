import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DailyRoutineViewModel extends ChangeNotifier {
  static const String cacheKey = 'daily_routine_list';
  List<dynamic>? _dailyRoutine;
  bool _isLoading = false;
  String? _errorMessage;

  List<dynamic>? get dailyRoutine => _dailyRoutine;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<List> getDatafromFirestore() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot documentSnapshot =
        await collectionRef.doc('jAiBaTIxkxPbfmYdn57pFdgOe2D3').get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    for (var item in data['daily_routine']) {
      item['timestamp'] = item['timestamp'];
    }
    return data['daily_routine'];
  }

  Future<void> saveDataToCache(List<dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(data));
  }

  Future<void> fetchDailyRoutine() async {
    _isLoading = true;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();

    if (pref.containsKey(cacheKey)) {
      final data = jsonDecode(pref.getString(cacheKey)!);
      resetTimestamp(data);
      _dailyRoutine = data;
      _isLoading = false;
      notifyListeners();
    } else {
      _dailyRoutine = await getDatafromFirestore();
      if (_dailyRoutine != null) {
        saveDataToCache(_dailyRoutine!);
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateStatus(String name) async {
    final index =
        _dailyRoutine!.indexWhere((element) => element['name'] == name);
    _dailyRoutine![index]['isDone'] = !_dailyRoutine![index]['isDone'];

    if (_dailyRoutine![index]['timestamp'] == null) {
      _dailyRoutine![index]['timestamp'] = DateTime.now().toString();
    } else {
      _dailyRoutine![index]['timestamp'] = null;
    }

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot documentSnapshot =
        await collectionRef.doc('jAiBaTIxkxPbfmYdn57pFdgOe2D3').get();
    documentSnapshot.reference.update({'daily_routine': _dailyRoutine});
    saveDataToCache(_dailyRoutine!);
    notifyListeners();
  }

  Future<void> clearCache() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(cacheKey);
  }

  Future<void> resetTimestamp(List<dynamic> data) async {
    for (var item in data) {
      if (item['timestamp'] != null) {
        DateTime date = DateTime.parse(item['timestamp']);
        DateTime now = DateTime.now();

        if (date.day != now.day ||
            date.month != now.month ||
            date.year != now.year) {
          item['timestamp'] = null;
          item['isDone'] = false;
          CollectionReference collectionRef =
              FirebaseFirestore.instance.collection('users');
          DocumentSnapshot documentSnapshot =
              await collectionRef.doc('jAiBaTIxkxPbfmYdn57pFdgOe2D3').get();
          documentSnapshot.reference.update({'daily_routine': data});
        }
      }
    }
    await saveDataToCache(data);
    notifyListeners();
  }

  Future<void> checkStreak() async {}
}


// final prefs = await SharedPreferences.getInstance();
//     DateTime lastOpened = DateTime.parse(
//         prefs.getString(cacheLastOpenedKey) ?? DateTime.now().toString());
//     DateTime now = DateTime.now();
//     int days = lastOpened.difference(now).inDays;
//     CollectionReference collectionRef =
//         FirebaseFirestore.instance.collection('users');
//     DocumentSnapshot documentSnapshot =
//         await collectionRef.doc('jAiBaTIxkxPbfmYdn57pFdgOe2D3').get();
//     if (days > 1) {
//       prefs.setString(cacheLastOpenedKey, now.toString());

//       documentSnapshot.reference.update({
//         'streak': 0,
//         'stats': FieldValue.arrayUnion([for (int i = 0; i < days; i++) 0])
//       });
//     } else if (days == 1) {
//       int numberofroutinescompleted =
//           dailyRoutine!.where((element) => element['isDone'] == true).length;
//       documentSnapshot.reference.update({
//         'streak': FieldValue.increment(1),
//         'stats': FieldValue.arrayUnion([numberofroutinescompleted])
//       });
//     } else {
//       prefs.setString(cacheLastOpenedKey, now.toString());
//     }