import 'package:flutter/material.dart';
import 'package:tp2_dev_mobile/model/activiteam_user.dart';

class ActiviteamUserNotifier with ChangeNotifier {
  ActiviTeamUser? _user;

  ActiviTeamUser? get user => _user;

  void setUser(ActiviTeamUser user) {
    _user = user;
    notifyListeners();
  }

  void updateUser(ActiviTeamUser user) {
    _user = user;
    notifyListeners();
  }
}
