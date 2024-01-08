import 'package:flutter/material.dart';
import 'package:tp2_dev_mobile/model/activity.dart';

class ActivitiesNotifier extends ChangeNotifier {
  List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  set activities(List<Activity> activities) {
    _activities = activities;
    notifyListeners();
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  Activity getActivityById(String id) {
    return _activities.firstWhere((activity) => activity.id == id);
  }

  void removeActivity(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }
}
