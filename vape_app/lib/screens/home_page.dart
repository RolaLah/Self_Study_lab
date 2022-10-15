import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference Vape =
      FirebaseFirestore.instance.collection('Vape');

  final TextEditingController TypeController = TextEditingController();

  final TextEditingController PriceController = TextEditingController();
  // Update method
  Future<void> Update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      TypeController.text = documentSnapshot['Type'];
      PriceController.text = documentSnapshot['Price'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: TypeController,
                  decoration: InputDecoration(
                    label: Text(
                      'Type',
                      style: TextStyle(
                        fontFamily: "AbyssinicaSIL",
                        fontSize: 25,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 20, color: Color.fromARGB(255, 164, 6, 179)),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gapPadding: 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: PriceController,
                  decoration: InputDecoration(
                    label: Text(
                      'Prise',
                      style: TextStyle(
                        fontFamily: "AbyssinicaSIL",
                        fontSize: 25,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 20, color: Color.fromARGB(255, 164, 6, 179)),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gapPadding: 20),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String Type = TypeController.text;
                      final String Price = PriceController.text;
                      if (Price != null) {
                        await Vape.doc(documentSnapshot!.id)
                            .update({"Type": Type, "Price": Price});
                        TypeController.text = '';
                        PriceController.text = '';
                      }
                    },
                    child: Text("Update"))
              ],
            ),
          );
        });
  }

//Create method
  Future<void> Create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      TypeController.text = documentSnapshot['Type'];
      PriceController.text = documentSnapshot['Price'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: TypeController,
                  decoration: InputDecoration(
                    label: Text(
                      'Type',
                      style: TextStyle(
                        fontFamily: "AbyssinicaSIL",
                        fontSize: 25,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 20, color: Color.fromARGB(255, 164, 6, 179)),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gapPadding: 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: PriceController,
                  decoration: InputDecoration(
                    label: Text(
                      'Prise',
                      style: TextStyle(
                        fontFamily: "AbyssinicaSIL",
                        fontSize: 25,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 20, color: Color.fromARGB(255, 164, 6, 179)),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gapPadding: 20),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String Type = TypeController.text;
                      final String Price = PriceController.text;
                      if (Price != null) {
                        await Vape.add({"Type": Type, "Price": Price});
                        TypeController.text = '';
                        PriceController.text = '';
                      }
                    },
                    child: Text("Update"))
              ],
            ),
          );
        });
  }

//Delete method
  Future<void> Delete(String productId) async {
    await Vape.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully deleted a vape")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 172, 205, 224),
        onPressed: () => Create(),
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: StreamBuilder(
          stream: Vape.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> StreamSnapshot) {
            if (StreamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: StreamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final DocumentSnapshot documentSnapshot =
                        StreamSnapshot.data!.docs[index];
                    return Card(
                      color: Color.fromARGB(255, 231, 239, 255),
                      margin: EdgeInsets.all(15),
                      child: ListTile(
                        title: Text(documentSnapshot['Type']),
                        subtitle: Text(documentSnapshot['Price'].toString()),
                        trailing: SizedBox(
                          width: 170,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => Update(documentSnapshot),
                                  icon: Icon(Icons.edit, color: Colors.red)),
                              IconButton(
                                  onPressed: () => Delete(documentSnapshot.id),
                                  icon: Icon(Icons.delete, color: Colors.red))
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
