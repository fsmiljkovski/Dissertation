import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diss_prototype/auth/auth_util.dart';

import '../../components/Join/join_class_module_widget.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../components/Menu/menu_widget.dart';
import 'package:flutter/material.dart';

import 'student_lectures_page.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key key, this.className, this.classKey})
      : super(key: key);

  final String className;
  final String classKey;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _joinGroup(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => JoinClassModuleWidget())));
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () async {
            scaffoldKey.currentState.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'Classrooms',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Color(0xFF303030),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      drawer: Drawer(
        elevation: 16,
        child: MenuWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: JoinClassModuleWidget(),
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
          'Join Class',
          style: FlutterFlowTheme.bodyText1,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Classrooms')
            .where('Members', arrayContains: currentUserUid)
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
                "You have not joined any classrooms yet \n :(",
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
                        color: FlutterFlowTheme.secondaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer,
                            color: FlutterFlowTheme.primaryColor,
                            offset: Offset(0, 2),
                          ),
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
                                    builder: (context) => ClassHomeScreenWidget(
                                      className: document.id,
                                      lectureKey: document['SecretKey'],
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      9,
                                      4,
                                      4,
                                      4,
                                    ),
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
                                        12, 12, 0, 12),
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
                                            document['ClassroomTitle'],
                                            style: FlutterFlowTheme.title2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 300.0,
                                              maxWidth: 300.0,
                                              minHeight: 30.0,
                                              maxHeight: 100.0,
                                            ),
                                            child: Text(
                                              document['Lecturer'],
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFF090F13),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
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
