import 'package:flutter/material.dart';

class Pair {
  Pair(this._left, this._right);

  dynamic _left;
  dynamic _right;
  static String startHour='startHour';
  static String endHour='endHour';
  static String startMinute='startMinute';
  static String endMinute='endMinute';

  dynamic get left => _left;

  set left(dynamic value) {
    _left = value;
  }

  dynamic get right => _right;

  set right(dynamic value) {
    _right = value;
  }


  @override
  String toString() => 'Pair[$_left, $_right]';

  Map<String,int> toMap(){
    var map=Map<String,int>();
    map[startHour]=_left.hour;
    map[startMinute]=_left.minute;
    map[endHour]=_right.hour;
    map[endMinute]=_right.minute;
    return map;

  }

  Pair.fromMapObject(Map<String,dynamic> busy){
    DateTime startDateTime=DateTime(0,1,1,busy[startHour],busy[startMinute],0,0,0);
    TimeOfDay startTimeOfDay=TimeOfDay.fromDateTime(startDateTime);

    DateTime endDateTime=DateTime(0,1,1,busy[endHour],busy[endMinute],0,0,0);
    TimeOfDay endTimeOfDay=TimeOfDay.fromDateTime(endDateTime);

    this._left=startTimeOfDay;
    this._right=endTimeOfDay;

  }


}