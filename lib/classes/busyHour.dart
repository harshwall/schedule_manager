import 'package:flutter/material.dart';
import 'package:schedule_manager/classes/pair.dart';

class BusyHour{
  int _startHour;
  int _startMinute;
  int _endHour;
  int _endMinute;

  int get startHour => _startHour;

  set startHour(int value) {
    _startHour = value;
  }

  BusyHour(this._startHour, this._startMinute, this._endHour, this._endMinute);

  int get startMinute => _startMinute;

  int get endMinute => _endMinute;

  set endMinute(int value) {
    _endMinute = value;
  }

  int get endHour => _endHour;

  set endHour(int value) {
    _endHour = value;
  }

  set startMinute(int value) {
    _startMinute = value;
  }

  Map<String,int> toMap(){
    var map=Map<String,int>();
    map['startHour']=_startHour;
    map['startMinute']=_startMinute;
    map['endHour']=_endHour;
    map['endMinute']=_endMinute;
    return map;
  }

  BusyHour.fromMapObject(Map<String,int> busy){
    BusyHour(busy['startHour'],busy['startMinute'],busy['endHour'],busy['endMinute']);
    DateTime startDateTime=DateTime(0,1,1,busy['startHour'],busy['startMinute'],0,0,0);
    TimeOfDay startTimeOfDay=TimeOfDay.fromDateTime(startDateTime);

    DateTime endDateTime=DateTime(0,1,1,busy['endHour'],busy['endMinute'],0,0,0);
    TimeOfDay endTimeOfDay=TimeOfDay.fromDateTime(endDateTime);

    Pair pair=Pair(startTimeOfDay,endTimeOfDay);
//    return ;



  }

}