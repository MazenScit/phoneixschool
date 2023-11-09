import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/model/message_model.dart';


class DataSwiper extends StatefulWidget {
  final List <MessageModel> myoccassion;
  const DataSwiper({Key? key, required this.myoccassion}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DataSwiperState();
  }
}

class DataSwiperState extends State<DataSwiper> {
  //properties want to custom
  late int _itemCount;

  late bool _loop;

  late bool _autoplay;

  late int _autoplayDelay;


  late bool _outer;

  late double _radius;

  late double _viewportFraction;

  late SwiperLayout _layout;

  late int _currentIndex;

  late double _scale;

  late Axis _scrollDirection;

  late AxisDirection _axisDirection;

  late Curve _curve;

  late double _fade;

  late bool _autoplayDisableOnInteraction;

  late CustomLayoutOption customLayoutOption;

  late SwiperController _controller;

  TextEditingController numberController = TextEditingController();

  Widget _buildItem(BuildContext context, int index) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 1,
              child: Container(
                color: Colors.white,
                child: Center(child: Text(widget.myoccassion[index].message_title))),
            ),
            
          ],
        ));
  }

  @override
  void didUpdateWidget(DataSwiper oldWidget) {
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
      ..addTranslate(
        [
          const Offset(-370.0, -40.0),
          Offset.zero,
          const Offset(370.0, -40.0),
        ],
      );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-25.0 / 180, 0.0, 25.0 / 180])
      ..addTranslate(
        [
          const Offset(-350.0, 0.0),
          Offset.zero,
          const Offset(350.0, 0.0),
        ],
      );
    _fade = 1.0;
    _currentIndex = 0;
    _curve = Curves.easeOutSine;
    _scale = 0.8;
    _autoplay = true;
    _controller = SwiperController();
    _layout = SwiperLayout.TINDER;
    _radius = 20.0;
    _loop = true;
    _itemCount = widget.myoccassion.length > 4? 5:widget.myoccassion.length;
    _autoplayDelay = 3000;
    _viewportFraction = 0.8;
    _outer = false;
    _scrollDirection = Axis.horizontal;
    _axisDirection = AxisDirection.left;
    _autoplayDisableOnInteraction = false;
    super.initState();
  }

// maintain the index

  Widget buildSwiper() {
    return Swiper(
      customLayoutOption: customLayoutOption,
      fade: _fade,
      index: _currentIndex,
      onIndexChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      curve: _curve,
      scale: _scale,
      itemWidth: 400.0,
      controller: _controller,
      layout: _layout,
      outer: _outer,
      itemHeight: 70.0,
      viewportFraction: _viewportFraction,
      autoplayDelay: _autoplayDelay,
      loop: _loop,
      autoplay: _autoplay,
      itemBuilder: _buildItem,
      itemCount: _itemCount,
      scrollDirection: _scrollDirection,
      axisDirection: _axisDirection,
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplayDisableOnInteraction: _autoplayDisableOnInteraction,
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              size: 5.0, activeSize: 7.0, space: 20.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
   var height= MediaQuery.of(context).size.height;
    return Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
              Container(
                height: 100,
                width: double.infinity,
                child: buildSwiper(),
              ),
             
              
                  ],
                ),
        ),
      );
  }
}





