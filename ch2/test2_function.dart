main(){

  void myFun1(bool data1, { String? data2, int data3 = 0 }){ }

  myFun1(true);
  myFun1(true, data2: "hello", data3: 10);
  myFun1(true, data3: 20, data2: "world");

  void myFun2(bool data1, [ String? data2, int data3 = 0]){ }

  myFun2(true);
  // myFun2(true, data2: "hello");//error, positional parameter - 이름 명시 안된다.
  myFun2(true, "hello");
  myFun2(true, "hello", 10);
  // myFun2(true, 10, "hello");//error..
}