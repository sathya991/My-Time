import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImagePart extends StatefulWidget {
  const ImagePart({Key? key}) : super(key: key);

  @override
  State<ImagePart> createState() => _ImagePartState();
}

class _ImagePartState extends State<ImagePart> {
  String curUserUID = FirebaseAuth.instance.currentUser!.uid;
  String profPic = "";
  setStorageNFirebase(final ref, final imageTemp) async {
    await ref.putFile(imageTemp).then((p0) async {
      final url = await ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profPic': value});
      });
    });
  }

  displayOptions(Widget iconNow, Text txt) {
    return Column(
      children: [txt, iconNow],
    );
  }

  storageRefFunc(image, imageTemp) {
    if (image == null) return;
    imageTemp = File(image.path);
    Reference ref =
        FirebaseStorage.instance.ref().child('profPics/$curUserUID');
    if (profPic != "") {
      ref.delete().then((value) async {
        setStorageNFirebase(ref, imageTemp);
      });
    } else {
      setStorageNFirebase(ref, imageTemp);
    }
  }

  selectNUpdateProfilePic() async {
    var imageTemp;
    var image;
    var contextNow;
    AlertDialog a = AlertDialog(
      title: const Text("Choose"),
      content: const Text("Upload a picture of click one with camera"),
      actions: [
        GestureDetector(
          onTap: () async {
            image = await ImagePicker().pickImage(source: ImageSource.gallery);
            Navigator.of(context).pop(contextNow);
            storageRefFunc(image, imageTemp);
          },
          child: displayOptions(
              const FaIcon(FontAwesomeIcons.boxArchive), const Text("Gallery")),
        ),
        GestureDetector(
          onTap: () async {
            image = await ImagePicker().pickImage(source: ImageSource.camera);
            Navigator.of(context).pop(contextNow);
            storageRefFunc(image, imageTemp);
          },
          child: displayOptions(
              const FaIcon(FontAwesomeIcons.camera), const Text("Camera")),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext contextN) {
          contextNow = contextN;
          return a;
        });
  }

  @override
  Widget build(BuildContext context) {
    final userUID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userUID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          profPic = snapshot.data?.get('profPic');
          return GestureDetector(
            onTap: selectNUpdateProfilePic,
            child: profPic == ""
                ? const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/userProfile.png'),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(profPic),
                  ),
          );
        });
  }
}

// .then((value2) {
//           FirebaseFirestore.instance
//               .collection('posts')
//               .doc('ZgkrWcpNzHo7wVNhEpkB')
//               .collection('comments')
//               .where('uid', isEqualTo: curUserUID)
//               .get()
//               .then((value) => value.docs.forEach((element) {
//                     element.data().update('userURL', (value) => "url");
//                   }));
//         });