import 'package:flutter/material.dart';
import 'package:list_crud/items.dart';

class AddItems extends StatefulWidget {
  const AddItems({
    super.key, required this.onAddItem,
  });
  final Function (Items) onAddItem;
  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
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
                Items item = Items(title: titleController.text.trim(), description: descriptionController.text.trim());
                widget.onAddItem(item);
                titleController.text = descriptionController.text = '';
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}