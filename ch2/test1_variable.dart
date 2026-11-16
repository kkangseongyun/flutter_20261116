main(){
  //모든 변수는 객체이다.
  int data1 = 10;
  print(data1.isEven);

  //객체의 캐스팅은 상하위 관계에서만 가능하다.
  //int 클래스와 double 클래스가 상하위 관계가 아니다. 암시적도 안되고, 명시적도 안된다.
  // double data2 = data1 as double;//error
  double data2 = data1.toDouble();
  int data3 = data2.toInt();

  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();

  //var, dynamic
  int a1 = 10;
  // a1 = true;//error

  //var - 타입 유추 기법이다. 대입되는 값에의해 타입이 고정..
  var a2 = 10;
  // a2 = true;//error..
  var a3;//대입되는 값이 없으면 타입을 유추할 수 없다.
  //==>dynamic 타입으로 유추
  a3 = 10;
  a3 = true;
  a3 = 'hello';

  dynamic a4 = 10;
  a4 = true;
  a4 = 'hello';

  //null safety
  String b1 = 'hello';//String + Non Null
  // b1 = null;//error...
  b1.substring(2);

  String? b2 = 'hello';//String + nullable
  b2 = null;
  b2?.substring(2);
}
