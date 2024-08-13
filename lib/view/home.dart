// ignore_for_file: use_build_context_synchronously

import 'package:assessment_app/res/colors.dart';
import 'package:assessment_app/res/fonts.dart';
import 'package:assessment_app/viewmodel/daily_routine_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'daily_routine.dart';
import 'streak.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> title = ['Daily Skincare', 'Streaks'];
  int currentIndex = 0;
  List<int> stats = [];
  int streak = 0;
  Future<void> fetchData() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot documentSnapshot =
        await collectionRef.doc('jAiBaTIxkxPbfmYdn57pFdgOe2D3').get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    stats = data['stats'].cast<int>();
    streak = data['streak'];
  }

  Future<void> checkStreak() async {
    final prefs = await SharedPreferences.getInstance();
    const String cacheLastOpenedKey = 'last_open';
    DateTime lastOpened = DateTime.parse(
        prefs.getString(cacheLastOpenedKey) ?? DateTime.now().toString());
    DateTime now = DateTime.now();
    int days = lastOpened.difference(now).inDays;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot documentSnapshot =
        await collectionRef.doc('jAiBaTIxkxPbfmYdn57pFdgOe2D3').get();
    if (days > 1) {
      prefs.setString(cacheLastOpenedKey, now.toString());

      documentSnapshot.reference.update({
        'streak': 0,
        'stats': FieldValue.arrayUnion([for (int i = 0; i < days; i++) 0])
      });
    } else if (days == 1) {
      int numberofroutinescompleted =
          Provider.of<DailyRoutineViewModel>(context, listen: false)
              .dailyRoutine!
              .where((element) => element['isDone'] == true)
              .length;
      documentSnapshot.reference.update({
        'streak': FieldValue.increment(1),
        'stats': FieldValue.arrayUnion([numberofroutinescompleted])
      });
    } else {
      prefs.setString(cacheLastOpenedKey, now.toString());
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 72,
        title: Text(
          title[currentIndex],
          style: AppFonts.title,
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          const DailyRoutine(),
          Streaks(
            streak: streak,
            stats: stats,
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          elevation: 0,
          selectedItemColor: AppColor.secondarytextColor,
          unselectedItemColor: AppColor.secondarytextColor.withOpacity(0.7),
          selectedLabelStyle: AppFonts.bottomNavigationText,
          unselectedLabelStyle: AppFonts.bottomNavigationText,
          type: BottomNavigationBarType.fixed,
          iconSize: 24,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search_sharp),
              label: 'Routine',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: 'Streaks',
            ),
          ],
        ),
      ),
    );
  }
}
