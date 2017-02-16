import 'dart:html';

class TestClass{
  String content = document.body.innerHtml;
  List<int> list = <int>[1, 2, 3];

  TestClass(){
    print(content);

  }
}