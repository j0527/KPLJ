import 'package:blind_dating/indicatorCurrent_model.dart';
import 'package:blind_dating/sliderItems_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// View에서 불러와서 바로 쓰게끔 하나로 합치는 클래스이며 위젯 2개를 합쳐서 씀 (따로따로 dart파일 만들어서 하는게 좋은건지 이게 좋은지 모름)
class ImageSliderWidget extends StatelessWidget {
  final CarouselController controller; // CarouselController 인스턴스
  final List<SliderlItems> imageList; // 슬라이더에 담길 것들 가지고있는 리스트
  final RxInt current; // 바뀌는 current를 알기위해 RxInt로 선언

  ImageSliderWidget({
    Key? key,
    required this.controller,
    required this.imageList,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 각각의 위젯에 정보 넣어주기
        CarouselSliderWidget(controller: controller, imageList: imageList, current: current),
        CarouselIndicator(controller: controller, imageList: imageList, current: current),
      ],
    );
  }
}

// Slider부분을 담당하는 위젯
class CarouselSliderWidget extends StatelessWidget {
  final CarouselController controller; 
  final List<SliderlItems> imageList;
  final RxInt current;

  // Slider에 필요한 정보들
  CarouselSliderWidget({
    Key? key,
    required this.controller,
    required this.imageList,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: controller,
      items: imageList.map((item) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300, 
              height: 300,
              child: Image.asset(item.imagePath, fit: BoxFit.cover), // fit 조절로 이미지를 원하는 크기에 맞게 조절 가능
            ),
            Text(item.description),
          ],
        );
      }).toList(),
      options: CarouselOptions(
        height: 400,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          current.value = index; // 페이지 변경 시 current 업데이트
        },
      ),
    );
  }
}

// indicator를 담당하는 위젯
class CarouselIndicator extends StatelessWidget {
  final CarouselController controller;
  final List<SliderlItems> imageList;
  final RxInt current;

  // indicator에 필요한 정보들
  CarouselIndicator({
    Key? key,
    required this.controller,
    required this.imageList,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndicatorCurrent>(
      builder: (indicatorCurrent) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) { // entry는 슬라이더의 인덱스에 담긴 모든걸 알고있는 Map항목임
              return GestureDetector(
                onTap: () {
                  controller.animateToPage(entry.key);  // 이미지 슬라이더를 해당 페이지로 이동
                  indicatorCurrent.setCurrent(entry.key); // IndicatorCurrent 컨트롤러를 통해 페이지 변경
                },
                // indicator의 속성들을 정의하는 부분, Obx는 index마다 색이 바뀌기 때문에 감싸져있음
                child: Obx(() {
                  return Container(
                    width: 20,
                    height: 12,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // 상하(vertical)로는 8.0, 좌우(horizontal)로는 4.0의 여백을 부여
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // 동그라미 indicator생성
                      color: Colors.black.withOpacity(current.value == entry.key ? 0.9 : 0.4), // 투명도를 조절하기 선택되면 더 어두운색 되게해줌
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
