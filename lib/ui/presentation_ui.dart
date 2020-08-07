import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/ui/login_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Presentation extends StatefulWidget {
  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Empregos",
        heightImage: 250,
        styleTitle: fontHeavy24Dark,
        description:
            "Acompanhe as melhores vagas de emprego que são compátiveis com você em nossa cidade.",
        styleDescription: fontRegular16Dark,
        pathImage: "assets/illustration/i-1.png",
        backgroundColor: Color(corPrincipal),
      ),
    );
    slides.add(
      new Slide(
        title: "Currículum",
        heightImage: 250,
        styleTitle: fontHeavy24Dark,
        description:
            "Cadastre suas habilidades, formações acadêmicas e experiências...",
        styleDescription: fontRegular16Dark,
        pathImage: "assets/illustration/i-2.png",
        backgroundColor: Color(corPrincipal),
      ),
    );
    slides.add(
      new Slide(
        title: "Contato",
        heightImage: 250,
        styleTitle: fontHeavy24Dark,
        description:
            "Entre em contato com a empresa e converse sobre a vaga disponível.",
        styleDescription: fontRegular16Dark,
        pathImage: "assets/illustration/i-3.png",
        backgroundColor: Color(corPrincipal),
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginUi()));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      colorDoneBtn: Color(corSecundaria).withOpacity(0.8),
      colorSkipBtn: CupertinoColors.activeBlue,
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
