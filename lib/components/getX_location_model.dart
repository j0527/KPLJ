import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GetXLocation extends GetxController {
  Rx <Position?>  myLocation = Rx <Position?> (null);

    // 두 지점 간의 거리 계산
  double calculateDistance() {
    if (myLocation.value == null) {
      return 0.0;
    } else{

    double startLatitude = myLocation.value!.latitude;
    double startLongitude = myLocation.value!.longitude;


    // double endLatitude = 37.23555180940932; // 상대방의 위도
    // double endLongitude = 126.97514265376132; // 상대방의 경도
    // 더미데이터로 파파이스 강남점의 위도경도를 고정값으로 지정
    double endLatitude = 37.49327821749438; // 상대방의 위도
    double endLongitude = 127.02942893581022; // 상대방의 경도



    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
    update();
    return distanceInMeters;  
    }
  }
  
}