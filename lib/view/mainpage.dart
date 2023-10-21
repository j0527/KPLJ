import 'package:blind_dating/components/imageSlider_widget.dart';
import 'package:blind_dating/indicatorCurrent_model.dart';
import 'package:blind_dating/sliderItems_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final CarouselController _controller = CarouselController(); // 이미지 슬라이더를 제어하기 위한 기본적인 컨트롤러
  final IndicatorCurrent indicatorCurrent = Get.put(IndicatorCurrent()); // 현재 이미지 슬라이더의 상태를 관리하는 GetX 컨트롤러

  // 이미지와 텍스트 가지는 더미데이터 리스트
  final List<SliderlItems> carouselItems = [
    SliderlItems(
      imagePath: 'images/불테리어.png',
      description: '박명수 27세', 
    ),
    SliderlItems(
      imagePath: 'images/퍼그.png',
      description: '호날두 7세', 
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('오늘의 추천',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
              Container(
                color: Colors.amber,
                height: 400, // 이미지 슬라이더 높이
                child: Stack(
                  children: [
                    GetBuilder<IndicatorCurrent>(
                      builder: (controller) {
                        return CarouselSliderWidget(
                          // CarouselSliderWidget위젯에 전달하고 가져오는부분
                          controller: _controller, // 이미지 슬라이더를 제어하는 컨트롤러를 전달
                          imageList: carouselItems, // 이미지와 설명을 가진 리스트를 전달
                          current: controller.current, // 현재 페이지를 관리하는 GetX 컨트롤러에서 현재 페이지를 가져옴
                        );
                      },
                    ),
                    CarouselIndicator(
                      // CarouselIndicator위젯에 전달하고 가져오는부분
                      imageList: carouselItems, // 이미지와 설명을 가진 리스트를 전달
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
              Container(
                padding: const EdgeInsets.all(20),
              )
            ],
          ),
        ),
      );
  }
}