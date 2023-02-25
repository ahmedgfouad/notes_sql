import 'package:flutter/material.dart';
import 'package:sq_flite/DbHelper.dart';
import 'package:sq_flite/Home.dart';

class NOtes extends StatefulWidget {
  const NOtes({Key? key}) : super(key: key);

  @override
  State<NOtes> createState() => _NOtesState();
}

class _NOtesState extends State<NOtes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(hintText: "title"),
              ),
              TextFormField(
                controller: note,
                decoration: InputDecoration(hintText: "note"),
              ),
              TextFormField(
                controller: color,
                decoration: InputDecoration(hintText: "color"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 20,
                width: 60,
                color: Colors.teal,
                child: MaterialButton(
                  textColor: Colors.white,
                  onPressed: () async {
                    // int response = await sqlDb.insertData('''
                    //            INSERT INTO notes ('title','note','color')
                    //            VALUES ("${title.text}", "${note.text}","${color.text}")
                    //            ''');

                    int response=await sqlDb.insert("notes",{
                      "note" : "${note.text}",
                      "title" : "${title.text}",
                      "color" : "${ color.text}",
                    });
                    print("response = $response");
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    }
                  },
                  child: Text("Add Notes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
