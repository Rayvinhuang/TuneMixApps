import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunemix_apps/model/story.dart';
import 'package:tunemix_apps/services/location_services.dart';
import 'package:tunemix_apps/services/story_service.dart';

class StoryEditScreen extends StatefulWidget {
  final Story? story;
  const StoryEditScreen({super.key, this.story});

  @override
  State<StoryEditScreen> createState() => _StoryEditScreenState();
}

class _StoryEditScreenState extends State<StoryEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    if (widget.story != null) {
      _titleController.text = widget.story!.title;
      _descriptionController.text = widget.story!.description;
    }
  }


  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickLocation() async {
    final currentPosition = await LocationService.getCurrentPosition();
    // final currentAddress = await LocationService.getAddressFromLatLng(_currentPosition!);
    setState(() {
      _currentPosition = currentPosition;
      // _currentAddress = currentAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story == null ? 'Add Story' : 'Update Story'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title: ',
                textAlign: TextAlign.start,
              ),
              TextField(
                controller: _titleController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Description: ',
                ),
              ),
              TextField(
                controller: _descriptionController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Image: '),
              ),
              _imageFile != null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.file(_imageFile!, fit: BoxFit.cover),
                    )
                  : (widget.story?.imageUrl != null &&
                          Uri.parse(widget.story!.imageUrl!).isAbsolute
                      ? Image.network(widget.story!.imageUrl!, fit: BoxFit.cover)
                      : Container()),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              TextButton(
                onPressed: _pickLocation,
                child: const Text('Get Current Location'),
              ),
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),

              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String? imageUrl;
                      if (_imageFile != null) {
                        imageUrl = await StoryService.uploadImage(_imageFile!);
                      } else {
                        imageUrl = widget.story?.imageUrl;
                      }
                      Story story = Story(
                        id: widget.story?.id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        imageUrl: imageUrl,
                        latitude: _currentPosition?.latitude,
                        longitude: _currentPosition?.longitude,
                        createdAt: widget.story?.createdAt,
                      );

                      if (widget.story == null) {
                        StoryService.addStory(story)
                            .whenComplete(() => Navigator.of(context).pop());
                      } else {
                        StoryService.updateStory(story)
                            .whenComplete(() => Navigator.of(context).pop());
                      }
                    },
                    child: Text(widget.story == null ? 'Add' : 'Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
