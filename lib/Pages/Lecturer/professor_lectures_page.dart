import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/Creating/create_new_lecture_widget.dart';
import '../../components/Info/class_info.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'professor_classroom_page.dart';
import 'professor_questions_page.dart';

class ClassHomeScreenLecturerWidget extends StatefulWidget {
  const ClassHomeScreenLecturerWidget({
    Key key,
    this.className,
    this.classProfessor,
    this.classKey,
  }) : super(key: key);

  final String className;
  final String classProfessor;
  final String classKey;

  @override
  _ClassHomeScreenLecturerWidgetState createState() =>
      _ClassHomeScreenLecturerWidgetState();
}

class _ClassHomeScreenLecturerWidgetState
    extends State<ClassHomeScreenLecturerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePageLecturerWidget(),
              ),
              (r) => false,
            );
          },
          child: Icon(
            Icons.adaptive.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          widget.className,
          style: FlutterFlowTheme.title2,
        ),
        actions: [
          IconButton(
            color: FlutterFlowTheme.tertiaryColor,
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: ClassInfoWidget(
                      className: widget.className,
                      classProfessor: widget.classProfessor,
                      classKey: widget.classKey,
                    ),
                  );
                },
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleDown,
            ),
          ),
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: CreateNewLectureWidget(
                      className: widget.className,
                    ),
                  );
                },
              );
            },
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Classrooms')
            .doc(widget.className)
            .collection('Lectures')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.docs.isEmpty) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 300, 20, 20),
              child: Text(
                "No Lectures have been created yet \n :(",
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.title2.override(
                  fontFamily: 'Lexend Deca',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer,
                            color: FlutterFlowTheme.primaryColor,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LecturerQuestionsPageWidget(
                                      className: widget.className,
                                      lectureName: document['LectureTitle'],
                                      lectureKey: document['SecretKey'],
                                      isEnabledLecture: document['isEnabled'],
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 4, 10, 4),
                                    child: Container(
                                      width: 4,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 12, 0, 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: 290.0,
                                            maxWidth: 290.0,
                                            minHeight: 30.0,
                                            maxHeight: 100.0,
                                          ),
                                          child: Text(
                                            document['LectureTitle'],
                                            maxLines: 5,
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: document['isEnabled']
                                              ? () async {
                                                  var lecture =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Classrooms')
                                                          .doc(widget.className)
                                                          .collection(
                                                              'Lectures');

                                                  lecture
                                                      .doc(document[
                                                          'LectureTitle'])
                                                      .update(
                                                    {
                                                      'isEnabled': false,
                                                    },
                                                  );
                                                }
                                              : () async {
                                                  var lecture =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Classrooms')
                                                          .doc(widget.className)
                                                          .collection(
                                                              'Lectures');

                                                  lecture
                                                      .doc(document[
                                                          'LectureTitle'])
                                                      .update(
                                                    {
                                                      'isEnabled': true,
                                                    },
                                                  );
                                                },
                                          child: document['isEnabled']
                                              ? Icon(
                                                  Icons.check_circle_sharp,
                                                  color: Colors.green,
                                                )
                                              : Icon(Icons.undo,
                                                  color: Colors.red),
                                        ),
                                      ],
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
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
