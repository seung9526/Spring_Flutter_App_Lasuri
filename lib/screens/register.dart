import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import 'login.dart';

class UserProvider extends ChangeNotifier {
  String _email = "";
  String _password = "";
  String _name = "";

  String get email => _email;
  String get password => _password;
  String get name => _name;

  void setEmail(String input_email) {
    _email = input_email;
    notifyListeners();
  }

  void setPassword(String input_password) {
    _password = input_password;
    notifyListeners();
  }

  void setName(String input_name) {
    _name = input_name;
    notifyListeners();
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 페이지가 dispose될 때 컨트롤러를 해제합니다.
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final String apiUrl = 'http://192.168.50.135:8081/api/user/register';

    // 입력한 데이터 가져오기
    final String email = emailController.text;
    final String password = passwordController.text;
    final String name = nameController.text;

    // 데이터가 비어 있는지 확인
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      print('이메일, 비밀번호, 이름 중 일부 또는 모두가 비어 있습니다.');
      return;
    }

    final Map<String, String> data = {
      'userEmail': email,
      'userPassword': password,
      'userName': name,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print('회원 가입 성공!');
      print('서버 응답: ${response.body}');

      // 회원가입 성공 시 로그인 페이지로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(), // LoginPage로 이동
        ),
      );
    } else {
      print('회원 가입 실패');
      print('서버 응답: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5D0E5),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // 유효성 검사를 위한 키 설정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/logo/main-logo.png'),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: '이메일',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '이메일을 입력하세요.';
                              }
                              // 정규 표현식을 사용하여 이메일 형식 유효성 검사 수행
                              final emailRegex = RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return '올바른 이메일 형식이 아닙니다.';
                              }
                              return null; // 유효성 검사 통과
                            },
                            onSaved: (value) => emailController = TextEditingController
                                .fromValue(value as TextEditingValue?)!,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: '비밀번호',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          context.read<UserProvider>().setPassword(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '비밀번호를 입력하세요.';
                          }
                          // 비밀번호 복잡성에 대한 유효성 검사를 추가하려면 여기에 코드를 추가하세요.
                          return null; // 유효성 검사 통과
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: '이름',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onChanged: (value) {
                          context.read<UserProvider>().setName(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '이름을 입력하세요.';
                          }
                          // 다른 이름 유효성 검사 규칙을 추가하려면 여기에 코드를 추가하세요.
                          return null; // 유효성 검사 통과
                        },
                      ),

                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // 폼 유효성 검사 통과 시 회원 가입 시도
                            registerUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          minimumSize: const Size(400, 50),
                        ),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}