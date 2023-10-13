import 'package:flutter/material.dart';
import 'package:list_crud/items.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem({
    super.key, required this.item, required this.updateItem,
  });
  final Items item;
  final Function(String,String) updateItem;

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  late final TextEditingController titleController = TextEditingController(text: widget.item.title);
  late final TextEditingController descriptionController = TextEditingController(text: widget.item.description);

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
         key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              validator: (String ? value){
                if(value?.isEmpty ?? true){
                  return 'Enter a title';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Add Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16), // Set the desired spacing between the TextFormField widgets
            TextFormField(
              controller: descriptionController,
              validator: (String ? value){
                if(value?.isEmpty ?? true){
                  return 'Enter a description';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Add Description',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  widget.updateItem(titleController.text.trim(),descriptionController.text.trim());
                  Navigator.pop(context);
                }
              },
              child: const Text('Edit Done'),
            ),
          ],
        ),
      ),
    );
  }
}