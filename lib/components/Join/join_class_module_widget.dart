import 'package:diss_prototype/auth/auth_util.dart';
import 'package:diss_prototype/backend/backend.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../Pages/Student/student_lectures_page.dart';
import '../../Pages/Student/student_classroom_page.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class JoinClassModuleWidget extends StatefulWidget {
  const JoinClassModuleWidget({
    Key key,
    this.className,
    this.classKey,
  }) : super(key: key);

  final String className;
  final String classKey;

  @override
  _JoinClassModuleWidgetState createState() => _JoinClassModuleWidgetState();
}

class _JoinClassModuleWidgetState extends State<JoinClassModuleWidget> {
  void _joinGroup(
      BuildContext context, String classKey, String className) async {
    String _returnString = await joinGroup(className, classKey, currentUserUid);

    if (_returnString == "success") {
      Navigator.pop(context);
    }
  }

  final classKeyController = TextEditingController();
  final classroomNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 396,
      decoration: BoxDecoration(
        color: Color(0xFF14181B),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0x3B1D2429),
            offset: Offset(0, -3),
          )
        ],
        borderRadius: BorderRadius.circular(16),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 19, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Join Class',
              style: FlutterFlowTheme.title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: TextFormField(
                controller: classroomNameController,
                obscureText: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Classroom Name (Case Sensitive)',
                  labelStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Name of the classroom you will be joining',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF1D2429),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: TextFormField(
                controller: classKeyController,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Secret Key',
                  labelStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Secret key given by your Lecturer',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF1D2429),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (classroomNameController.text.isEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        content: Text(
                          'Classroom name field cannot be empty!',
                        ),
                      ),
                    );
                  } else if (classKeyController.text.isEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        content: Text(
                          'Secret Key field cannot be empty!',
                        ),
                      ),
                    );
                  } else if (classKeyController.text.isNotEmpty ||
                      classroomNameController.text.isNotEmpty) {
                    Map classes;
                    DocumentSnapshot<Map<String, dynamic>> doc =
                        await FirebaseFirestore.instance
                            .collection('Classrooms')
                            .doc(classroomNameController.text)
                            .get();
                    classes = doc.data();
                    if (classes.containsValue(classKeyController.text) !=
                            null &&
                        classes.containsValue(classroomNameController.text) !=
                            null) {
                      _joinGroup(context, classKeyController.text,
                          classroomNameController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(
                            'Wrong Values have been inputted!',
                          ),
                        ),
                      );
                    }
                  }
                },
                text: 'Submit',
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
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
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
    );
  }
}
