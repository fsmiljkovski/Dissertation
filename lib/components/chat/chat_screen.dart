import '../chat/new_message.dart';
import '../chat/messages.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget(
      {Key key,
      this.className,
      this.lectureName,
      this.questionName,
      this.isEnabledQuestion})
      : super(key: key);

  final String className;
  final String lectureName;
  final String questionName;
  final bool isEnabledQuestion;

  @override
  _ChatScreenWidgetState createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(widget.questionName, style: FlutterFlowTheme.title1),
        actions: [],
      ),
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(
                className: widget.className,
                lectureName: widget.lectureName,
                questionName: widget.questionName,
              ),
            ),
            NewMessage(
              className: widget.className,
              lectureName: widget.lectureName,
              questionName: widget.questionName,
              isEnabledQuestion: widget.isEnabledQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
