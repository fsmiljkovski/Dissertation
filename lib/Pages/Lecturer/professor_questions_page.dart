import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/Creating/ask_question_widget.dart';
import '../../components/Info/lecture_info.dart';
import '../../components/chat/chat_screen.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class LecturerQuestionsPageWidget extends StatefulWidget {
  const LecturerQuestionsPageWidget({
    Key key,
    this.className,
    this.lectureName,
    this.lectureKey,
    this.isEnabledLecture,
  }) : super(key: key);

  final String className;
  final String lectureName;
  final String lectureKey;
  final bool isEnabledLecture;

  @override
  _LecturerQuestionsPageWidgetState createState() =>
      _LecturerQuestionsPageWidgetState();
}

class _LecturerQuestionsPageWidgetState
    extends State<LecturerQuestionsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.adaptive.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          widget.lectureName,
          style: FlutterFlowTheme.title1,
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
                    child: LectureInfoWidget(
                      lectureName: widget.lectureName,
                      lectureKey: widget.lectureKey,
                      className: widget.className,
                    ),
                  );
                },
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleDown,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.isEnabledLecture
            ? () async {
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
              }
            : null,
        backgroundColor: widget.isEnabledLecture
            ? FlutterFlowTheme.primaryColor
            : Colors.grey,
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
                                            minWidth: 270.0,
                                            maxWidth: 270.0,
                                            minHeight: 30.0,
                                            maxHeight: 100.0,
                                          ),
                                          child: Text(
                                            document['QuestionText'],
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
                                                  var question =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Classrooms')
                                                          .doc(widget.className)
                                                          .collection(
                                                              'Lectures')
                                                          .doc(widget
                                                              .lectureName)
                                                          .collection(
                                                              'Questions');
                                                  question
                                                      .doc(document[
                                                          'QuestionText'])
                                                      .update(
                                                    {
                                                      'isEnabled': false,
                                                    },
                                                  );
                                                }
                                              : () async {
                                                  var question =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Classrooms')
                                                          .doc(widget.className)
                                                          .collection(
                                                              'Lectures')
                                                          .doc(widget
                                                              .lectureName)
                                                          .collection(
                                                              'Questions');
                                                  question
                                                      .doc(document[
                                                          'QuestionText'])
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
                                                  size: 25,
                                                )
                                              : Icon(Icons.undo,
                                                  color: Colors.red),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: InkWell(
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Delete Question'),
                                                    content: Text(
                                                      'Are you sure you want to delete this question?',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              alertDialogContext);
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Classrooms')
                                                              .doc(widget
                                                                  .className)
                                                              .collection(
                                                                  'Lectures')
                                                              .doc(widget
                                                                  .lectureName)
                                                              .collection(
                                                                  'Questions')
                                                              .doc(document[
                                                                  'QuestionText'])
                                                              .delete();
                                                        },
                                                        child: Text('Confirm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.delete_forever_sharp,
                                              color: Colors.red,
                                              size: 25,
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
