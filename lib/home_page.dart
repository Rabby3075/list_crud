import 'package:flutter/material.dart';
import 'package:list_crud/add_items.dart';
import 'package:list_crud/items.dart';
import 'package:list_crud/update_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> itemList = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions:  const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search,color: Colors.blue),
          )
        ],
        backgroundColor: Colors.white,
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AddItems(onAddItem: (Items items){
                addItem(items);
              }),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return  Card(
                      color: Colors.white30,
                      child: ListTile(
                        onLongPress: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text('Action'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showModalBottomSheet(context: context, builder: (context){
                                                return UpdateItem(
                                                    item: itemList[index],
                                                    updateItem: (String updateTitle, String updateDescription){
                                                      updateItemList(index, updateTitle, updateDescription);

                                                });
                                              });
                                            },
                                            child: const Text('Edit',style: TextStyle(color: Colors.teal),),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              deleteItem(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete',style: TextStyle(color: Colors.teal)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                        leading: const CircleAvatar(backgroundColor: Colors.red,),
                        title: Text(itemList[index].title.toString()),
                        subtitle: Text(itemList[index].description.toString()),
                        trailing: const Icon(Icons.arrow_right_alt),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        )

    );
  }
  void updateItemList(int index, String newTitle, String newDescription) {
    setState(() {
      itemList[index] = Items(title: newTitle, description: newDescription);
    });
  }


  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }
  void addItem(Items item){
    itemList.add(item);
    setState(() {});
  }
}




