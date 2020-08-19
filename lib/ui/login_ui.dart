import 'dart:ui';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/signup_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_final_ui.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final UserController c = Get.put(UserController());

  final PageController _controller = PageController();

  List<Widget> _list = [
    Image.asset("assets/bg/home-1.png", fit: BoxFit.cover),
    Image.asset("assets/bg/home-2.png", fit: BoxFit.cover),
    Image.asset("assets/bg/home-3.png", fit: BoxFit.cover),
    Image.asset("assets/bg/home-4.png", fit: BoxFit.cover),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = _controller.page.round() + 1;

      if (nextPage == _list.length) {
        nextPage = 0;
      }

      _controller
          .animateToPage(nextPage,
              duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corSecundaria2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(corDark),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Center(
              child: CupertinoButton(
                onPressed: () => Get.to(SignUpUi()),
                child: Text(
                  "Cadastro",
                  style: fontBold20Light,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          new PageView(
            children: _list,
            controller: _controller,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                scale: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  "A melhor maneira de encontrar e oferecer empregos na cidade de Ouro Fino e região.",
                  style: fontRegular18White,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            child: SizedBox(
              width: Get.width > 1000 ? 300 : Get.width / 2,
              child: CupertinoButton(
                child: Text(
                  "Login",
                  style: TextStyle(color: Color(corSecundaria2)),
                ),
                onPressed: () {
                  Get.to(LoginFinalUi());
                },
                color: Color(corPrincipal),
              ),
            ),
          )
        ],
      ),
    );
  }
}
