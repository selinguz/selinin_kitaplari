import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// ! Çalışma Sayfası

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO #6 firebaseden shelf bilgileri çekilip, listeye atanacak
    //TODO #7 oluşan yeni listede aşağıdaki örnekteki gibi distinct yapılarak görüntüleme yapılmaya çalışılacak

    void getShelfData() {
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance.collection('library').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data!.docs[index].get('shelf'),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    }

    void getData() async {
      List dataList = [];

      await FirebaseFirestore.instance
          .collection('library')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  dataList.add(doc.data());
                }),
              });
    }

    List<String> countries = [
      "Nepal",
      "Nepal",
      "USA",
      "Canada",
      "Canada",
      "China",
      "Russia",
    ];

    var seen = <String>{};
    List<String> uniquelist =
        countries.where((country) => seen.add(country)).toList();
    print(uniquelist);

    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance.collection('library').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data!.docs[index].get('shelf'),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
