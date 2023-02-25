import 'package:flutter/material.dart';
import 'package:sq_flite/DbHelper.dart';
import 'package:sq_flite/EditNotes.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading=true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.red("notes");
   notes.addAll(response);
   isLoading=false;
    if(this.mounted){
      setState(() {});
    };
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("notes");
          },
        ),
        body:isLoading ==true ?
        Center(child: CircularProgressIndicator(),)
            :  Container(
          child: ListView(
            children: [
              InkWell(
                child: MaterialButton(
                  onPressed: () async {
                    await sqlDb.myDeleteDatabase();
                  },
                  child: Text("delete database"),
                ),
              ),
              ListView.builder(
                  itemCount:notes.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text("${notes[index]['title']}"),
                        subtitle: Text("${notes[index]['note']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                // int response = await sqlDb.deleteData(
                                //     "DELETE FROM notes WHERE id = ${notes[index ]['id']}");
                                int response =await sqlDb.delete('notes', "id = ${notes[index ]['id']}");
                                if (response > 0) {
                                  notes.removeWhere((element) => element['id']==notes[index]['id']);
                                  setState(() {

                                  });
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>EditNotes(
                                      color: notes[index]['color'],
                                      note: notes[index]['note'],
                                      title: notes[index]['title'],
                                      id: notes[index]['id'],
                                )));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
