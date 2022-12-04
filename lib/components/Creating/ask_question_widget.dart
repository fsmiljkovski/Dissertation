import 'package:diss_prototype/backend/schema/index.dart';
import 'package:diss_prototype/flutter_flow/flutter_flow_util.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class AskQuestionWidget extends StatefulWidget {
  const AskQuestionWidget({
    Key key,
    this.className,
    this.lectureName,
  }) : super(key: key);

  final String className;
  final String lectureName;

  @override
  _AskQuestionWidgetState createState() => _AskQuestionWidgetState();
}

class _AskQuestionWidgetState extends State<AskQuestionWidget> {
  TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  final filter = ProfanityFilter();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        width: double.infinity,
        height: 270,
        decoration: BoxDecoration(
          color: Color(0xFF14181B),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x3B1D2429),
              offset: Offset(0, -3),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: textController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Ask a question',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF14181B),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (textController.text.isNotEmpty) {
                      Map questions;
                      DocumentSnapshot<Map<String, dynamic>> doc =
                          await FirebaseFirestore.instance
                              .collection('Classrooms')
                              .doc(widget.className)
                              .collection('Lectures')
                              .doc(widget.lectureName)
                              .collection('Questions')
                              .doc(textController.text)
                              .get();
                      questions = doc.data();
                      if (questions != null) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text(
                              'That question has already been asked!',
                            ),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        var question = FirebaseFirestore.instance
                            .collection('Classrooms')
                            .doc(widget.className)
                            .collection('Lectures')
                            .doc(widget.lectureName)
                            .collection('Questions');
                        question.doc(textController.text).set(
                          {
                            'QuestionText': textController.text,
                            'isEnabled': true,
                          },
                        );
                      }
                    } else if (filter.hasProfanity(textController.text)) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(
                            'The question field must not contain any profanity',
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(
                            'The question field must not be empty',
                          ),
                        ),
                      );
                    }
                  },
                  text: 'Ask Question',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 60,
                    color: FlutterFlowTheme.primaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 40,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 60,
                    color: Color(0xFF262D34),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 40,
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
