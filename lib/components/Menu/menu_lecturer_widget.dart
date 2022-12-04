import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/auth_util.dart';
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../Pages/landing_page_widget.dart';
import 'package:flutter/material.dart';

class MenuLecturerWidget extends StatefulWidget {
  const MenuLecturerWidget({Key key}) : super(key: key);

  @override
  _MenuLecturerWidgetState createState() => _MenuLecturerWidgetState();
}

class _MenuLecturerWidgetState extends State<MenuLecturerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFF14181B),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: currentUserPhoto.isNotEmpty
                      ? Image.network(
                          currentUserPhoto,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/usericon.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthUserStreamWidget(
                    child: StreamBuilder<List<UsersRecord>>(
                      stream: queryUsersRecord(
                        singleRecord: true,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.primaryColor,
                              ),
                            ),
                          );
                        }
                        List<UsersRecord> textUsersRecordList = snapshot.data;
                        // Return an empty Container when the document does not exist.
                        if (snapshot.data.isEmpty) {
                          return Container();
                        }
                        // ignore: unused_local_variable
                        final textUsersRecord = textUsersRecordList.isNotEmpty
                            ? textUsersRecordList.first
                            : null;

                        return Text(
                          'User: $currentUserDisplayName',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await signOut();
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandingPageWidget(),
                            ),
                            (r) => false,
                          );
                        },
                        text: 'Log Out',
                        options: FFButtonOptions(
                          width: 150,
                          height: 40,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.secondaryColor,
                              fontWeight: FontWeight.w500),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 100),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Delete Account'),
                                content: Text(
                                    'Are you sure you want to delete your account?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(alertDialogContext);
                                      currentUserReference.delete();
                                      await FirebaseAuth.instance.currentUser
                                          .delete();
                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LandingPageWidget(),
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
                        text: 'Delete Account',
                        options: FFButtonOptions(
                          width: 150,
                          height: 40,
                          color: Color(0xFFDE1212),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.secondaryColor,
                              fontWeight: FontWeight.w500),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
