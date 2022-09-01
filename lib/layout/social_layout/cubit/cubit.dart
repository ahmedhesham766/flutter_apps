import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/models/social_app/message_model.dart';
import 'package:todo_app/models/social_app/post_model.dart';
import 'package:todo_app/models/social_app/social_user_model.dart';
import 'package:todo_app/modules/social_app/chats/chat_screen.dart';
import 'package:todo_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:todo_app/modules/social_app/new_posts/new_posts_screen.dart';
import 'package:todo_app/modules/social_app/users/users_screen.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../modules/social_app/settings/settings_screen.dart';

 class SocialCubit extends Cubit<SocialStates> {
   SocialCubit() : super(SocialInitialState());

   static SocialCubit get(context) => BlocProvider.of(context);

   int currentIndex = 0;

   List<Widget> Screens = [
     FeedsScreen(),
     ChatsScreen(),
     NewPostsScreen(),
     UsersScreen(),
     SettingsScreen()
   ];

   List<String> title =
   [
     'Home',
     'Chats',
     'Post',
     'Users',
     'Settings',
   ];

   Social_User_Model? model;

   void GetUserData() {
     emit(SocialGetUserLoadingState());
     FirebaseFirestore.instance.collection('users').doc(uid).get().then((
         value) {
       print(value.data());
       model = Social_User_Model.fromjson(value.data());
       emit(SocialGetUserSuccessState());
     }).catchError((error) {
       print(error.toString());
       emit(SocialGetUserErrorState(error));
     });
   }
   void ChangeBottomNav(int index) {
     if(index == 1)
       getUsers();
        currentIndex = index;
     if (index == 2)
       emit(SocialNewPostState());
     else {
       currentIndex = index;
       emit(SocialChangeBottomNavState());
     }
   }

   File? profileimage;

   var picker = ImagePicker();

   Future<void> getImage() async
   {
     XFile? pickedFile = await ImagePicker().pickImage(
         source: ImageSource.gallery);

     if (pickedFile != null) {
       profileimage = File(pickedFile.path);
       print("getImage:");
       print(pickedFile.path);
       emit(SocialProfileImagePickedSuccessState());
     }
     else {
       print('No image selected');
       emit(SocialProfileImagePickedErrorState());
     }
   }


   File? profilecover;

   Future<void> getCover() async
   {
     final pickedfile = await picker.getImage(source: ImageSource.gallery);

     if (pickedfile != null) {
       profilecover = File(pickedfile.path);
       emit(SocialProfileCoverPickedSuccessState());
     }
     else {
       print('No image selected');
       emit(SocialProfileCoverPickedErrorState());
     }
   }


   void uploadProfileImage({
     required String name,
     required String bio,
     required String phone,
   }) {
     firebase_storage.FirebaseStorage.instance
         .ref()
         .child('users/${Uri
         .file(profileimage!.path)
         .pathSegments
         .last}')
         .putFile(profileimage!)
         .then((value) {
       value.ref.getDownloadURL().then((value) {
         emit(SocialUploadProfileImageSuccessState());

         print("image photo: ");
         print(value);

         Social_User_Model modelupdate = Social_User_Model(
             name: name,
             bio: bio,
             phone: phone,
             cover: model!.cover,
             image: value,
             isEmailVerified: model!.isEmailVerified,
             uId: model!.uId,
             email: model!.email
         );
         FirebaseFirestore.instance
             .collection('users')
             .doc(model!.uId)
             .update(modelupdate.toMap())
             .then((value) {
           GetUserData();
         }).catchError((error) {
           emit(SocialUserUpdateErrorState());
         });
       }).catchError((error) {
         emit(SocialUploadProfileImageErrorState());
       });
     })
         .catchError((error) {
       emit(SocialUploadProfileImageErrorState());
     });
   }

   void uploadProfileCover({
     required String name,
     required String bio,
     required String phone
   }) {
     firebase_storage.FirebaseStorage.instance.
     ref()
         .child('users/${Uri
         .file(profilecover!.path)
         .pathSegments
         .last}')
         .putFile(profilecover!)
         .then((value) {
       value.ref.getDownloadURL().then((value) {
         emit(SocialUploadProfileCoverSuccessState());

         print("cover photo: ");
         print(value);

         Social_User_Model modelupdate = Social_User_Model(
             name: name,
             bio: bio,
             phone: phone,
             cover: value,
             image: model!.image,
             isEmailVerified: model!.isEmailVerified,
             uId: model!.uId,
             email: model!.email
         );
         FirebaseFirestore.instance
             .collection('users')
             .doc(model!.uId)
             .update(modelupdate.toMap())
             .then((value) {
           GetUserData();
         }).catchError((error) {
           emit(SocialUserUpdateErrorState());
         });
       }).catchError((error) {
         emit(SocialUploadProfileCoverErrorState());
       });
     }).catchError((error) {
       emit(SocialUploadProfileCoverErrorState());
     });
   }

   void UpdateUser({
     required String name,
     required String bio,
     required String phone,
     String? image,
     String? cover,
   }) {
     emit(SocialUserUpdateLoadingState());
     if (profileimage != null) {
       uploadProfileImage(name: name, bio: bio, phone: phone);
     }
     emit(SocialUserUpdateLoadingState());
     if (profilecover != null) {
       uploadProfileCover(name: name, bio: bio, phone: phone);
     }
     else {
       Social_User_Model modelupdate = Social_User_Model(
         name: name,
         bio: bio,
         phone: phone,
         email: model!.email,
         image: model!.image,
         cover: model!.cover,
         uId: model!.uId,
         isEmailVerified: model!.isEmailVerified,
       );
       FirebaseFirestore.instance
           .collection('users')
           .doc(model!.uId)
           .update(modelupdate.toMap())
           .then((value) {
         GetUserData();
       }).catchError((error) {
         emit(SocialUserUpdateErrorState());
       });
     }
   }

   File? postimage;

   Future<void> getPostImage() async
   {
     XFile? pickedFile = await ImagePicker().pickImage(
         source: ImageSource.gallery);

     if (pickedFile != null) {
       postimage = File(pickedFile.path);
       emit(SocialPostImagePickedSuccessState());
     }
     else {
       print('No image selected');
       emit(SocialPostImagePickedErrorState());
     }
   }

   void removePostImage() {
     postimage = null;
     emit(SocialRemovePostImageState());
   }

   void UploadPostImage({
     required String dateTime,
     required String text,
   }) {
     emit(SocialCreatePostUserLoadingState());

     firebase_storage.FirebaseStorage.instance
         .ref()
         .child('posts/${Uri
         .file(postimage!.path)
         .pathSegments
         .last}')
         .putFile(postimage!)
         .then((value) {
       value.ref.getDownloadURL().then((value) {
         print("postimage:");
         print(value);
         CreatePost(
             dateTime: dateTime,
             text: text,
             postImage: value
         );
       }).catchError((error) {
         emit(SocialCreatePostUserErrorState());
       });
     }).catchError((error) {
       emit(SocialCreatePostUserErrorState());
     });
   }

   void CreatePost({
     required String dateTime,
     required String text,
     String? postImage,
   }) {
     emit(SocialCreatePostUserLoadingState());
     Post_Model postmodel = Post_Model(
       name: model!.name,
       image: model!.image,
       uId: model!.uId,
       dateTime: dateTime,
       text: text,
       postImage: postImage,
     );
     FirebaseFirestore.instance
         .collection('posts')
         .add(postmodel.toMap())
         .then((value) {
       emit(SocialCreatePostUserSuccessState());
       print(postImage);
     }).catchError((error) {
       emit(SocialCreatePostUserErrorState());
     });
   }

   List<Post_Model> posts =[];
   List<String> postid = [];
   List<int> likes = [];

   void getPosts() {
     FirebaseFirestore.instance
         .collection('posts')
         .get()
         .then((value) {
       value.docs.forEach((element) {
         element.reference
             .collection('likes')
             .get()
             .then((value) {
           print(element.id);
           likes.add(value.docs.length);
           postid.add(element.id);
           posts.add(Post_Model.fromjson(element.data()));
         })
             .catchError((error) {

         });
       });
       emit(SocialGetPostsSuccessState());
     }).catchError((error) {
       emit(SocialGetPostsErrorState(error));
     });
   }

   void LikePost(String postid) {
     FirebaseFirestore.instance
         .collection('posts')
         .doc(postid)
         .collection('likes')
         .doc(model!.uId)
         .set({
       'like': true,
     })
         .then((value) {
       emit(SocialLikePostsSuccessState());
     })
         .catchError((error) {
       emit(SocialLikePostsErrorState(error.toString()));
     });
   }

   List<Social_User_Model> users = [];

   void getUsers() {
     users= [];
     FirebaseFirestore.instance
         .collection('users')
         .get()
         .then((value) {
           value.docs.forEach((element) {
             if(element.data()['uId'] != model!.uId)
               users.add(Social_User_Model.fromjson(element.data()));
           });
          emit(SocialGetAllUsersSuccessState());
     }).catchError((error) {
          print(error.toString());
          emit(SocialGetAllUsersErrorState(error));
     });
   }

   void SendMessage({
     required String receiverId,
     required String datetime,
     required String text
 })
   {
      MessageModel messagemodel = MessageModel(
        senderId: model!.uId,
        receiverId: receiverId,
        dateTime: datetime,
        text: text
      );
      //set my chats
      FirebaseFirestore.instance
      .collection('users')
      .doc(model!.uId)
      .collection('chats')
      .doc(receiverId)
      .collection('messages')
      .add(messagemodel.toMap())
      .then((value)
      {
        emit(SocialSendMessageSuccessState());
      }).catchError((error)
      {
        emit(SocialSendMessageErrorState());
      });
      //set recevier chats
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(model!.uId)
          .collection('messages')
          .add(messagemodel.toMap())
          .then((value)
      {
        emit(SocialSendMessageSuccessState());
      }).catchError((error)
      {
        emit(SocialSendMessageErrorState());
      });
   }

   List<MessageModel> messages =[];

   void GetMessage({
     String? receiverId
   })
   {
     FirebaseFirestore.instance
         .collection('users')
         .doc(model!.uId)
         .collection('chats')
         .doc(receiverId)
         .collection('messages')
          .orderBy('dateTime')
         .snapshots()
         .listen((event) {
           messages = [];
           event.docs.forEach((element) {
                messages.add(MessageModel.fromjson(element.data()));
           });

           emit(SocialGetMessageSuccessState());
     });
         
   }
 }


