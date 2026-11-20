import 'package:flutter_lab/riverpod/MyInfoNotifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class MyInfoScreen extends ConsumerStatefulWidget {
  String? id;
  String? q;
  Map<String, dynamic>? extra;

  MyInfoScreen({this.id, this.q, this.extra});

  @override
  ConsumerState<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends ConsumerState<MyInfoScreen> {
  // String? email = '';
  // String? phone = '';
  // String _userImage = 'assets/images/user_basic.jpg';

  //key를 준비해서.. key로 Form의 상태 객체 획득..
  //GlobalKey로 준비해야..
  var _formKey = GlobalKey<FormState>();

  //우리는 Form을 이용하고 있음으로 controller 없이도 유저 입력데이터 획득이 가능하다..
  //이 화면이 나올때 이전에 저장된 데이터가 있다면 출력되어야 한다. controller에 데이터 대입하면 출력된다..
  late TextEditingController emailController;
  late TextEditingController phoneController;

  //유저 데이터 저장을 위해 호출..
  Future<void> _saveData() async {
    // print('$email, $phone, $_userImage');
    //notifier에 함수 호출..
    ref
        .read(myInfoProvider.notifier)
        .saveMyInfo(email: emailController.text, phone: phoneController.text);
    context.pop();
  }

  @override
  void initState() {
    //widget이 가진 데이터를 state에서 획득...
    super.initState();
    print('${widget.id}, ${widget.q}, ${widget.extra}');

    emailController = TextEditingController();
    phoneController = TextEditingController();

    //최초에.. 상태 저장된것이 있다면.. 화면에 출력되게 한다.
    //데이터는 reiverpod에 있다..
    //initstate 부분이다.. 이곳에서 화면과 관련된 코드를 실행시키면 시점 차이에 의해 화면이 출력되기 전에
    //작업이 이루어 질 수 있다..
    //화면 정보 구성이 모두 완료된 후에.. 콜백을 실행시켜라..
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //provider 데이터 획득해서 화면 출력..
      var myInfo = ref.read(myInfoProvider);
      emailController.text = myInfo.email;
      phoneController.text = myInfo.phone;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var myInfo = ref.watch(myInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          TextButton(
            onPressed: () {
              //key를 이용해 State 객체 획득..
              var form = _formKey.currentState;
              //validate() 호출하면 하위의 모든 TextFormField의 validator() 함수 호출된다.
              //모두 null ==> true, 하나라도 문자열 리턴 ==> false
              if (form?.validate() ?? false) {
                // form?.save(); //하위 모든 onSaved() 호출..
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
                  child: Image.asset(myInfo.userImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 24),
              // Gallery 버튼
              ElevatedButton(onPressed: () {}, child: Text('Gallery App')),
              SizedBox(height: 24),
              // Camera 버튼
              ElevatedButton(onPressed: () {}, child: Text('Camera App')),
              SizedBox(height: 30),

              //유저 입력 요소를 감싸서 유효성검증, 입력데이터 획득의 도움..
              Form(
                key: _formKey, //위젯에 매핑한 키를 이용해 위젯의 상태 획득..
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Form과 상호 연동을 하기 위한 유저 입력은 TextField 안되고.. TextFormField
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      //Form에 의해 자동 호출.. 매개변수는 현 순간 유저 입력 데이터..
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'enter your email'; //invalid...에러메시지..
                        }
                        return null; //valid
                      },
                      //데이터 저장을 위해서 자동 호출..매개변수가 입력 데이터..
                      // onSaved: (value) => setState(() => email = value),
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'enter your phone';
                        }
                        return null; //valid
                      },
                      // onSaved: (value) => setState(() => phone = value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
