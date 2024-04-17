import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

import 'cach_helper.dart';

File? _image;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  get image => null;

  @override
  State<HomePage> createState() => _HomePageState();
}

class myImageProvider extends ChangeNotifier {
  File? get image => _image;

  void setImage(File image) {
    _image = image;
    notifyListeners();
  }
}

class _HomePageState extends State<HomePage> {
  List? _outputs;
  bool _isModelLoaded = false;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _outputs = output!;
      CachHelper.saveData(
          key: 'output', value: _outputs![0]["label"].toString().substring(2));
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    setState(() {
      _isModelLoaded = true;
    });
  }

  Future getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        classifyImage(_image!);
      });
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 150,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? Image(
                    image: AssetImage('assets/Icon.jpg'),
                    width: 500,
                    height: 500,
                  )
                : null,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.green[100],
                textColor: Colors.black,
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: const Text('Take Photo'),
              ),
              const SizedBox(width: 20),
              MaterialButton(
                color: Colors.green[100],
                textColor: Colors.black,
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: const Text('Pick Photo'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _isModelLoaded
              ? (_outputs != null && _outputs!.isNotEmpty)
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          _outputs![0]["label"].toString().substring(2),
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : const Text(
                      '',
                    )
              : const CircularProgressIndicator(), // Show loading indicator if model is not loaded yet
        ],
      ),
    );
  }
}
