import 'package:blind_dating/components/%08getX_location_model.dart';
import 'package:blind_dating/components/imageSlider_widget.dart';
import 'package:blind_dating/model/indicatorCurrent_model.dart';
import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  // 이미지와 텍스트 가지는 더미데이터 리스트
  final List<SliderlItems> carouselItems = [
    SliderlItems(
      userimagePath: 'images/불테리어.png',
      userName: '박명수', 
      userAge: '10세',
      userLocation: '내 코앞',
      userDestance: '1m',
      userMBTI: 'LOVE'
    ),
    SliderlItems(
      userimagePath: 'images/퍼그.png',
      userName: '크리스티아누 호날두', 
      userAge: '27세',
      userLocation: '평양 직할시',
      userDestance: '100km',
      userMBTI: 'ESTJ'
    ),
  ];



  @override
  Widget build(BuildContext context) {

  final CarouselController _controller = CarouselController(); // 이미지 슬라이더를 제어하기 위한 기본적인 컨트롤러
  final IndicatorCurrent indicatorCurrent = Get.put(IndicatorCurrent()); // 현재 이미지 슬라이더의 상태를 관리하는 GetX 컨트롤러
  final GetXLocation locationController = Get.put(GetXLocation()); // 위치와 관련된 getXmodel
  
  double calcDistance = locationController.calculateDistance(); // getXmodel에서 계산된 거리를 담을 변수
  String unit = "m"; // 기본 거리 단위를 m로 지정

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
              '오늘의 추천',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            // const SizedBox(
            //   height: 50,
            // ),
              Container(
                color: Color.fromARGB(255, 99, 182, 203),
                height: 500, // 이미지 슬라이더 영역 크기
                child: Stack(
                  children: [
                    GetBuilder<IndicatorCurrent>(
                      builder: (controller) {
                        return CarouselSliderWidget(
                          // CarouselSliderWidget위젯에 전달하고 가져오는부분
                          controller: _controller, // 이미지 슬라이더를 제어하는 컨트롤러를 전달
                          userInfoList: carouselItems, // 이미지와 설명을 가진 리스트를 전달
                          current: controller.current, // 현재 페이지를 관리하는 GetX 컨트롤러에서 현재 페이지를 가져옴
                        );
                      },
                    ),
                    CarouselIndicator(
                      // CarouselIndicator위젯에 전달하고 가져오는부분
                      userInfoList: carouselItems, // 이미지와 설명을 가진 리스트를 전달
                      current: indicatorCurrent.current, // GetX 컨트롤러에서 현재 페이지를 가져옴
                      controller: _controller, // 이미지 슬라이더를 제어하는 컨트롤러를 전달
                    // ),
                    // return ImageSliderWidget(
                    //   imageList: carouselItems, // 이미지와 설명을 가진 리스트를 전달
                    //   current: indicatorCurrent.current, // GetX 컨트롤러에서 현재 페이지를 가져옴
                    //   controller: _controller, // 이미지 슬라이더를 제어하는 컨트롤러를 전달
                    //   sliderCurrent: controller.current
                    // );
                    // },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
} // ---- Functions ----

