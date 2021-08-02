import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var doc = snapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: doc.length,
                itemBuilder: (ctx, index) {
                  return MessageBubble(
                    message: doc[index]['text'].toString(),
                    isMe: doc[index]['userId'] == futureSnapShot.data.uid,
                    key: ValueKey(doc[index].documentID),
                    userId: doc[index]['userId'],
                    userImgUrl: doc[index]['userImg'],
                    userName: doc[index]['userName'],
                  );
                },
              );
            },
          );
        });
  }
}
