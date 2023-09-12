import 'package:flutter/material.dart';
import 'package:suuitch/screens/register.dart';
import '../service/login_service.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loginSuccess = true;
  String loginMessage = '';

  final loginService = LoginService(); // LoginService 인스턴스 생성

  @override
  void dispose() {
    // 페이지가 dispose될 때 컨트롤러를 해제합니다.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> Login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        loginSuccess = false;
        loginMessage = '이메일 또는 비밀번호가 비어 있습니다.';
      });
      return;
    }

    try {
      final loginResult = await loginService.login(email, password);

      setState(() {
        loginSuccess = loginResult['success'];
        loginMessage = loginResult['message'];
      });

      if (loginSuccess) {
        // 로그인 성공 시 처리
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainPage(), // MainPage로 이동
          ),
        );
      } else {
        // 로그인 실패 시 처리
        setState(() {
          loginSuccess = false;

        });
      }
    } catch (error) {
      setState(() {
        loginSuccess = false;
        loginMessage = '오류 발생: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5D0E5),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/logo/main-logo.png'),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'ID와 비밀번호가 올바르지 않습니다.' : null,
                  onSaved: (value) =>
                  emailController = TextEditingController
                      .fromValue(value as TextEditingValue?)!,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디 및 패스워드가 틀렸습니다.';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                  passwordController = TextEditingController
                      .fromValue(value as TextEditingValue?)!,
                ),
              ),
              SizedBox.fromSize(
                size: const Size(0, 10),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), // 둥근 모서리 설정
                  ),
                  minimumSize: const Size(100, 40),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox.fromSize(
                size: const Size(0, 5),
              ),
              Text(
                loginMessage, // 메시지 표시
                style: TextStyle(
                  color: loginSuccess ? Colors.green : Colors.red, // 성공 또는 실패에 따라 색상 변경
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 8.0), // 상단으로 조금 올림
                    child: Text("아직 계정이 없으신가요?"),
                  ),
                  Spacer(), // 오른쪽 끝까지 간격 채우기
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(), // 회원가입 페이지로 이동
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(40.0), // 둥근 모서리 설정
                      ),
                      minimumSize: Size(170, 40), // 버튼 크기 설정
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
