import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_from_tensorflow_api/api/mobilenet.api.dart';
import 'package:get_from_tensorflow_api/models/prediction_result.model.dart';
import 'package:get_from_tensorflow_api/widgets/pick_image.widget.dart';
import 'package:get_from_tensorflow_api/widgets/results.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

class PredictPictureScreen extends StatefulWidget {
  const PredictPictureScreen({Key? key}) : super(key: key);

  @override
  State<PredictPictureScreen> createState() => _PredictPictureScreenState();
}

class _PredictPictureScreenState extends State<PredictPictureScreen> {
  ImagePicker imagePicker = ImagePicker();
  File? _image;
  bool _isLoading = false;
  List<PredictionResult>? results;
  Color backgroundColor = Colors.blue[200]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Reconocimento de una imagen '),
            backgroundColor: backgroundColor),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Center(
                  child: PickImage(
                image: _image,
                onTap: pickImage,
                backgroundColor: backgroundColor,
              )),
              const SizedBox(height: 25),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (results != null)
                Results(results: results!)
              else
                const Text('Selecciona una imagen',
                    style: TextStyle(fontSize: 18))
            ],
          ),
        ));
  }

  Future<void> pickImage() async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });

    final newBackgroundColor = await getImageColor();
    backgroundColor = newBackgroundColor;

    getMobilenetresults();
  }

  Future<void> getMobilenetresults() async {
    setState(() {
      _isLoading = true;
    });

    if (_image != null) {
      results = await MobilenetApi().getPredictionResults(_image!);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<Color> getImageColor() async {
    if (_image == null) return Colors.blue[200]!;

    final img = FileImage(File(_image!.path));

    final paletteGenerator = await PaletteGenerator.fromImageProvider(img);

    return paletteGenerator.dominantColor!.color;
  }
}
