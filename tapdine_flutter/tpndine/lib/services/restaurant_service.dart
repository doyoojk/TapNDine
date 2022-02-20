import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tpndine/configuration/constants.dart';
import 'package:tpndine/services/hmac.dart';
import 'dart:developer';

class RestaurantService {
  static String latitude = Constants.geo_point['lat'].toString();
  static String longitude = Constants.geo_point['long'].toString();
  static String siteId = '815195ff68974fddbfa90e72ed59d4c6';
  DateTime date = DateTime.now().toUtc();

  /// This method requests the a specific sitge based on the the site's id
  /// by using NCR's find-site-by-id API.
  ///
  /// @param [None]
  /// @return A map that encapsulates the store's meta data.
  ///
  Future<Map<String, dynamic>> request_site_by_id() async {
    String GetStoreByIdUrl = Constants.requestUrl + '/site/sites/$siteId';
    var request = http.Request('GET', Uri.parse(GetStoreByIdUrl));
    Map<String, String> headers = {
      'date': _substring_to_utc(HttpDate.format(date)),
      'accept': 'application/json',
      'content-type': 'application/json'
    };
    request.headers.addAll(headers);
    HMac hMac = new HMac();
    request.headers['Authorization'] =
        hMac.createHmac(request, '/site/sites/$siteId', date);
    http.Response response =
        await http.Response.fromStream(await request.send());

    var jsonString = response.body;
    var jsonMap = json.decode(jsonString);
    return jsonMap;
  }

  /// This method requests the nearby sites based on geolocation
  /// using NCR's find-nearby API.
  ///
  /// @param [None]
  /// @return A map that encapsulates the all store's meta data.
  ///
  Future<Map<String, dynamic>> request_nearby_sites() async {
    String GetStoresUrl =
        Constants.requestUrl + '/site/sites/find-nearby/$latitude,$longitude';
    var request = http.Request('GET', Uri.parse(GetStoresUrl));
    Map<String, String> headers = {
      'date': _substring_to_utc(HttpDate.format(date)),
      'accept': 'application/json',
      'content-type': 'application/json'
    };
    request.headers.addAll(headers);
    HMac hMac = HMac();
    request.headers['Authorization'] = hMac.createHmac(
        request, '/site/sites/find-nearby/$latitude,$longitude', date);
    http.Response response =
        await http.Response.fromStream(await request.send());

    var jsonString = response.body;
    log("THE JSON STRING IS " + response.statusCode.toString());
    var jsonMap = json.decode(jsonString);
    return jsonMap;
  }

  /// This method converts a RFC 1123 date format in GMT to UTC
  /// by cropping the 'GMT' part and replacing it with 'UTC' part
  /// using substring.
  ///
  /// @param [date] The date string in RFC 1123 GMT date format.
  _substring_to_utc(String date) {
    var newString = date.substring(0, date.length - 3);
    return newString + " UTC";
  }
}
