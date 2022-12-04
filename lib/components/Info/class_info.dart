import 'package:diss_prototype/backend/backend.dart';

import '../../Pages/Lecturer/professor_classroom_page.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class ClassInfoWidget extends StatefulWidget {
  const ClassInfoWidget({
    Key key,
    this.className,
    this.classProfessor,
    this.classKey,
  }) : super(key: key);

  final String className;
  final String classProfessor;
  final String classKey;

  @override
  _ClassInfoWidgetState createState() => _ClassInfoWidgetState();
}

class _ClassInfoWidgetState extends State<ClassInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 290,
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
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Text(
                'Class Information',
                style: FlutterFlowTheme.title2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 10),
              child: Text(
                "Class Title: " +
                    widget.className, //'Class Title: Mobile Development',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.secondaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 10),
              child: Text(
                'Professor:   ' + widget.classProfessor,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.secondaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 10),
              child: Text(
                "Secret Key:  " + widget.classKey,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.secondaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Delete Classroom'),
                        content: Text(
                          'Are you sure you want to delete this classroom?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(alertDialogContext);
                              await FirebaseFirestore.instance
                                  .collection('Classrooms')
                                  .doc(widget.className)
                                  .delete();
                              await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePageLecturerWidget(),
                                ),
                                (r) => false,
                              );
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                text: 'Delete',
                options: FFButtonOptions(
                  width: 210,
                  height: 50,
                  color: Colors.red,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
