import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_dev_mobile/model/activity.dart';
import 'package:tp2_dev_mobile/providers/activities_notifier.dart';
import 'package:tp2_dev_mobile/providers/cart_notifier.dart';
import 'package:tp2_dev_mobile/repositories/activities_repository.dart';

class ActivitiesManager {
  static fetchActivities(ActivitiesNotifier notifier) async {
    List<Activity> activities = await ActivitiesRepository.getActivities();
    notifier.activities = activities;
  }

  static addToCart(Activity activity, BuildContext context) async {
    ActivitiesRepository.addToCart(
      activity,
    );
    Provider.of<CartNotifier>(context, listen: false).addItem(activity.id);
  }

  static removeOneFromCart(Activity activity, BuildContext context) async {
    ActivitiesRepository.removeOneFromCart(
      activity,
    );
    Provider.of<CartNotifier>(context, listen: false).removeItem(activity.id);
  }
}
