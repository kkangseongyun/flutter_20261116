class User {
  String? name;
  int? age;

  //생성자 매개변수로 멤버 초기화..
  //case1
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }

  //case2
  // User(this.name, this.age);

  //case3
  User(String name, int age): this.name = name.toUpperCase(), this.age = age * 2;

  User.one(){}
  User.two(): this("aaa", 10);
  User.three(): this.one();
}

class Singleton {
  int? data;
  Singleton._privateConstructor();
  static final Singleton _instance = Singleton._privateConstructor();
  factory Singleton(){
    //외부에서는 여전히 생성자, 객체 생성 목적으로 호출..
    //자동 객체 생성 리턴되지 않는다.
    //개발자 코드로.. 클래스 타입의 객체를 준비해서 리턴해야 한다.
    return _instance;
  }
}

main(){
  var obj1 = User('kim', 10);
  var obj2 = User.one();

  var obj3 = Singleton();
  var obj4 = Singleton();
  obj3.data = 10;
  obj4.data = 20;
  print("${obj3.data}, ${obj4.data}");//20, 20
}