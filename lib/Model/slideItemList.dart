import 'slideImageBank.dart';

class SlideItemList {
  List<Slide> _slideItemList = [
    Slide(imageUrl: 'images/0.jpg'),
    Slide(imageUrl: 'images/1.jpeg'),
    Slide(imageUrl: 'images/2.jpeg'),
    Slide(imageUrl: 'images/3.jpeg'),
    Slide(imageUrl: 'images/4.jpeg'),
    Slide(imageUrl: 'images/5.jpeg'),
    Slide(imageUrl: 'images/7.jpeg'),
    Slide(imageUrl: 'images/8.jpeg'),
    Slide(imageUrl: 'images/9.jpeg'),
  ];

  String assetSlideImage(int index) {
    return _slideItemList[index].imageUrl;
  }

  int slideItemLength() {
    return _slideItemList.length;
  }
}
