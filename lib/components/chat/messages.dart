import 'package:diss_prototype/components/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({
    Key key,
    this.className,
    this.lectureName,
    this.questionName,
  }) : super(key: key);

  final String className;
  final String lectureName;
  final String questionName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Classrooms')
              .doc(className)
              .collection('Lectures')
              .doc(lectureName)
              .collection('Questions')
              .doc(questionName)
              .collection('chat')
              .orderBy('sentAt', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) => MessageBubble(
                snapshot.data.docs[index]['text'],
                snapshot.data.docs[index]['uid'] == futureSnapshot.data.uid,
              ),
            );
          },
        );
      },
    );
  }
}
