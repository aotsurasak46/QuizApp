import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/question.dart';
import 'package:flutter_application_1/models/quiz_question.dart';
import 'package:flutter_application_1/services/questions_service.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

class QuestionFormScreen extends StatefulWidget {
  const QuestionFormScreen({super.key});

  @override
  QuestionFormScreenState createState() {
    return QuestionFormScreenState();
  }
}

class QuestionFormScreenState extends State<QuestionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _choice1Controller = TextEditingController();
  final TextEditingController _choice2Controller = TextEditingController();
  final TextEditingController _choice3Controller = TextEditingController();
  final TextEditingController _choice4Controller = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  final questionsService = QuestionsService();

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      QuizQuestion newQuestion = QuizQuestion(
          _questionController.text,
          [
            _choice1Controller.text,
            _choice2Controller.text,
            _choice3Controller.text,
            _choice4Controller.text
          ],
          _choice1Controller.text,
          int.parse(_scoreController.text));
      await questionsService.addQuizQuestion(newQuestion);
      clear();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void clear() {
    _questionController.clear();
    _choice1Controller.clear();
    _choice2Controller.clear();
    _choice3Controller.clear();
    _choice4Controller.clear();
    _scoreController.clear();
  }

  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green.shade300,
    padding: const EdgeInsets.all(8),
    content: const Row(
      children: [
        Icon(
          Icons.check,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'บันทึกคำถามสำเร็จ',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Container(
        color: Config.alabasterColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 120,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "เพิ่มคำถามและตัวเลือกของคุณ",
                        style: TextStyle(
                          fontFamily: "prompt",
                          fontSize: 25,
                          color: Config.onyxColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _questionController,
                        decoration: const InputDecoration(
                          labelText: 'คำถาม',
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.bitterSweetColor, width: 3),
                          ),
                          errorStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 12,
                            color: Config.bitterSweetColor,
                          ),
                          labelStyle: const TextStyle(
                            fontFamily: "prompt",
                            fontSize: 20,
                            color: Config.darkerToneColor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Config.onyxColor, width: 3),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.earthYellowColor, width: 3),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return 'โปรดกรอกคำถาม';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _choice1Controller,
                        decoration: InputDecoration(
                          labelText: 'ตัวเลือกที่ 1 (คำตอบที่ถูกต้อง)',
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.bitterSweetColor, width: 3),
                          ),
                          errorStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 12,
                            color: Config.bitterSweetColor,
                          ),
                          labelStyle: const TextStyle(
                            fontFamily: "prompt",
                            fontSize: 20,
                            color: Config.onyxColor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Config.onyxColor, width: 3),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.earthYellowColor, width: 3),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return 'โปรดกรอกตัวเลือกที่ 1';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _choice2Controller,
                        decoration: InputDecoration(
                          labelText: 'ตัวเลือกที่ 2',
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.bitterSweetColor, width: 3),
                          ),
                          errorStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 12,
                            color: Config.bitterSweetColor,
                          ),
                          labelStyle: const TextStyle(
                            fontFamily: "prompt",
                            fontSize: 20,
                            color: Config.onyxColor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Config.onyxColor, width: 3),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.earthYellowColor, width: 3),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return 'โปรดกรอกตัวเลือกที่ 2';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _choice3Controller,
                        decoration: InputDecoration(
                          labelText: 'ตัวเลือกที่ 3',
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.bitterSweetColor, width: 3),
                          ),
                          errorStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 12,
                            color: Config.bitterSweetColor,
                          ),
                          labelStyle: const TextStyle(
                            fontFamily: "prompt",
                            fontSize: 20,
                            color: Config.onyxColor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Config.onyxColor, width: 3),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.earthYellowColor, width: 3),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return 'โปรดกรอกตัวเลือกที่ 3';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _choice4Controller,
                        decoration: InputDecoration(
                          labelText: 'ตัวเลือกที่ 4',
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.bitterSweetColor, width: 3),
                          ),
                          errorStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 12,
                            color: Config.bitterSweetColor,
                          ),
                          labelStyle: const TextStyle(
                            fontFamily: "prompt",
                            fontSize: 20,
                            color: Config.onyxColor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Config.onyxColor, width: 3),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.earthYellowColor, width: 3),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return 'โปรดกรอกตัวเลือกที่ 4';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _scoreController,
                        decoration: const InputDecoration(
                          labelText: 'คะแนน',
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.bitterSweetColor, width: 3),
                          ),
                          errorStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 12,
                            color: Config.bitterSweetColor,
                          ),
                          labelStyle: TextStyle(
                            fontFamily: "prompt",
                            fontSize: 20,
                            color: Config.onyxColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Config.onyxColor, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Config.earthYellowColor, width: 3),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return 'โปรดกรอกคะแนนสำหรับคำถาม';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Config.alabasterColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: Config.toPopPage(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.0,
                  color: Colors.black,
                ),
                label: const Text(
                  'ย้อนกลับ',
                  style: TextStyle(
                    fontFamily: Config.fontStyle,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: submitForm,
                icon: FaIcon(
                  FontAwesomeIcons.check,
                  color: Config.onyxColor,
                ),
                label: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontFamily: Config.fontStyle,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
