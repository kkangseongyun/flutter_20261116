import 'package:material_ui/material_ui.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {

  String? email = '';
  String? phone = '';
  String _userImage = 'assets/images/user_basic.jpg';

  //key를 준비해서.. key로 Form의 상태 객체 획득..
  //GlobalKey로 준비해야..
  var _formKey = GlobalKey<FormState>();

  //유저 데이터 저장을 위해 호출..
  Future<void> _saveData() async {
    print('$email, $phone, $_userImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          TextButton(
              onPressed: (){
                //key를 이용해 State 객체 획득..
                var form = _formKey.currentState;
                //validate() 호출하면 하위의 모든 TextFormField의 validator() 함수 호출된다.
                //모두 null ==> true, 하나라도 문자열 리턴 ==> false
                if(form?.validate() ?? false){
                  form?.save();//하위 모든 onSaved() 호출..
                  _saveData();
                }
              },
              child: Text('저장'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // 원형 프로필 이미지
              Card(
                elevation: 0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(_userImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 24),
              // Gallery 버튼
              ElevatedButton(
                onPressed: (){},
                child: Text('Gallery App'),
              ),
              SizedBox(height: 24),
              // Camera 버튼
              ElevatedButton(onPressed: (){}, child: Text('Camera App')),
              SizedBox(height: 30),

              //유저 입력 요소를 감싸서 유효성검증, 입력데이터 획득의 도움..
              Form(
                key: _formKey,//위젯에 매핑한 키를 이용해 위젯의 상태 획득..
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Form과 상호 연동을 하기 위한 유저 입력은 TextField 안되고.. TextFormField
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      //Form에 의해 자동 호출.. 매개변수는 현 순간 유저 입력 데이터..
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return 'enter your email';//invalid...에러메시지..
                        }
                        return null;//valid
                      },
                      //데이터 저장을 위해서 자동 호출..매개변수가 입력 데이터..
                      onSaved: (value) => setState(() => email = value ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return 'enter your phone';
                        }
                        return null;//valid
                      },
                      onSaved: (value) => setState(() => phone = value ),
                    ),
                  ],
                ),
              )
		
            ],
          ),
        ),
      ),
    );
  }
}
