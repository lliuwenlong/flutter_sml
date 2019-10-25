import 'dart:math';

import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:location_permissions/location_permissions.dart';
getDistance(double lat1, double lng1, double lat2, double lng2) {
    double radLat1 = rad(lat1);
    double radLat2 = rad(lat2);
    double a = radLat1 - radLat2;
    double b = rad(lng1) - rad(lng2);
    double s = 2 * asin(sqrt(pow(sin(a / 2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
    return s * 6378138.0;
}

double rad(double d) {
    return d * pi / 180.0;
}

getLoction () async {
    PermissionStatus permission1 = await LocationPermissions().requestPermissions();
    if (permission1 == PermissionStatus.granted) {
        await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
        AMapLocation res = await AMapLocationClient.getLocation(true);
        return {
            "longitude": res.longitude,
            "latitude": res.latitude
        };
    } else {
        return null;
    }
}

double calculatedDistance (double lat1, double lng1, double lat2, double lng2) {
    double distance = getDistance(lat1, lng1, lat2, lng2);
    return distance;
}

String getDistanceText (double distance) {
    if (distance == null) {
        return "";
    }
    if (distance < 500) {
        return "<0.5公里";
    } else if (distance > 500 && distance < 1000) {
        return "<1公里";
    } else if (distance > 1000) {
        print(distance);
        return ">${(distance / 1000).toStringAsFixed(1)}公里";
    } else {
        return "";
    }
}

onPay (String type, int number, int id, int forestTypes) async {
    
}