import 'package:flutter/material.dart';

import 'DbHelper.dart';
import 'Home.dart';

class EditNotes extends StatefulWidget {
  final title;
  final note;
  final color;
  final id;
  const EditNotes({Key? key, this.title, this.note, this.color, this.id}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {

  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note .text=widget.note;
    title.text=widget.title;
    color.text=widget.color;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
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
                    // int response = await sqlDb.updateData('''
                    //            UPDATE notes SET 
                    //            title = "${title.text}",
                    //            note  = "${note.text}",
                    //            color = "${color.text}"
                    //            WHERE id =${widget.id} 
                    //            ''');
                    int response =await sqlDb.update(
                        "notes",
                        {
                         " title" : "${title.text}",
                         " note " : "${note.text}",
                         " color" : "${color.text}"

                        },
                        "id =${widget.id}"
                    );
                    print("response = $response");
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                    }
                  },
                  child: Text("Save Notes"),
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }
}
