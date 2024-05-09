import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({super.key});

  @override
  ConsumerState<AddItem> createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace(){
    final enteredTitle = _titleController.text;
    if(enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null){
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle,_selectedImage!,_selectedLocation!);
    Navigator.of(context).pop();

  }
  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16,),
            ImageInput(onPickImage: (image){
              _selectedImage = image;
            },),
            const SizedBox(height: 16,),
            LocationInput(onSelectLocation: (location) {
              _selectedLocation = location;
            },),
            const SizedBox(height: 16,),
            ElevatedButton.icon(onPressed: _savePlace, label: const Text('Add Place'), icon: const Icon(Icons.add),),
            
          ],
        )
      ),
    );
  }
}
