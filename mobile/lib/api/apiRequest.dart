import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NudgeServices {
  static Future<void> sendSMS(
    context, {
    @required var phone,
    @required String message,
  }) async {
    try {
      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      };

      var data = {
        "phone": "$phone",
        "message": "$message"
      };

      print(data);

      //POST REQUEST BUILD

      final response = await http.post(
          'http://172.105.150.155/api/twilio/sms/send',
          headers: headers,
          body: json.encode(data));

      print(response.body);

      if (response.statusCode == 200) {
        if (response.body.contains('required')) {
          return null;
        }
        //  saveItem(item: '${response.body}', key: 'message');
        //return MessageModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      //if (e.response.body != null) {

      print(e.toString());
    }

    return null;
  }
  static Future<void> call(
    context, {
    @required var phone,
    @required String message,
  }) async {
    try {
      var headers = {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      };

      var data = {
        "phone": "$phone",
        "message": "$message"
      };

      print(data);

      //POST REQUEST BUILD

      final response = await http.post(
          'http://172.105.150.155/api/nexmo/call',
          headers: headers,
          body: json.encode(data));

      print(response.body);

      if (response.statusCode == 200) {
        if (response.body.contains('required')) {
          return null;
        }
        //  saveItem(item: '${response.body}', key: 'message');
        //return MessageModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      //if (e.response.body != null) {

      print(e.toString());
    }

    return null;
  }
}
