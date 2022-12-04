import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/chat/chat_screen.dart';
import '../../components/Creating/ask_question_widget.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class StudentQuestionsPageWidget extends StatefulWidget {
  const StudentQuestionsPageWidget({
    Key key,
    this.className,
    this.lectureName,
    this.lectureKey,
  }) : super(key: key);

  final String className;
  final String lectureName;
  final String lectureKey;

  @override
  _QuestionsPageWidgetState createState() => _QuestionsPageWidgetState();
}

class _QuestionsPageWidgetState extends State<StudentQuestionsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
              child: Text(
                widget.lectureName,
                style: FlutterFlowTheme.title1,
              ),
            ),
          ],
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: AskQuestionWidget(
                  className: widget.className,
                  lectureName: widget.lectureName,
                ),
              );
            },
          );
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        icon: Icon(
          Icons.add,
        ),
        elevation: 8,
        label: Text(
          'Ask',
          style: FlutterFlowTheme.bodyText1,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            //.collection('Classrooms/Mobile Development/Lectures/Lecture 1/Questions')
            .collection('Classrooms')
            .doc(widget.className)
            .collection('Lectures')
            .doc(widget.lectureName)
            .collection('Questions')
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
                "No questions have been asked yet \n :(",
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
                                    builder: (context) => ChatScreenWidget(
                                      className: widget.className,
                                      lectureName: widget.lectureName,
                                      questionName: document['QuestionText'],
                                      isEnabledQuestion: document['isEnabled'],
                                    ),
                                  ),
                                );
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          9, 4, 4, 4),
                                      child: Container(
                                        width: 4,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 16, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 300.0,
                                              maxWidth: 300.0,
                                              minHeight: 30.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: Text(
                                              document['QuestionText'],
                                              style: FlutterFlowTheme.title2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFF090F13),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
