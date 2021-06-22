import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_buddy/src/models/itemModel.dart';
import 'package:provider/provider.dart';
import '../src/providers/imageProvider.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewItemScreen extends StatefulWidget {
  @override
  _CreateNewItemScreenState createState() => _CreateNewItemScreenState();
}

class _CreateNewItemScreenState extends State<CreateNewItemScreen> {
  Uint8List _image;
  final ImagePicker _picker = ImagePicker();
  String _bodyPart;
  String _date;

  void initState(){
    super.initState();
    _date = "${DateTime.now().toString().split(" ").first}";
    _bodyPart="Biceps";
  }

  addToDataBase() async {
    ItemModel _imageToSave = ItemModel(
      image: _image,
      bodyPart: _bodyPart,
      date: _date,
    );
    Provider.of<PhotosProvider>(context, listen: false ).addImage(_imageToSave);
    Navigator.pop(context);
  }

  Future selectImage() async {
    PickedFile _pickedFile;

    _pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );

    _image = await _pickedFile.readAsBytes();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:_floatingActionBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _imageWidget(),
            _buildDropDownMenu(),
            Text(
              _date,
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionBar(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue.withOpacity(0.4),
      ),
      width: MediaQuery.of(context).size.width*0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        IconButton(
        tooltip: "Confirm Submit",
        icon: Icon(Icons.add),
        onPressed: _image==null ? null : addToDataBase,
      ),
        ],
      ),
    );
  }

  Widget _imageWidget(){
    return Center(
      child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: _image==null?
              GestureDetector(
                onTap: selectImage,
                child: Text(" Add Image "),
              ) :
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Image.memory(
                  _image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _image==null?
            Positioned(
              top: 200,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.redAccent[300],
                child: IconButton(
                  icon: Icon(Icons.camera_outlined),
                  onPressed: selectImage,
                ),
              ),
            ):
            Positioned(
              top: 10,
              left: 20,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.redAccent[300],
                child: IconButton(
                  icon: Icon(Icons.autorenew_outlined),
                  onPressed: selectImage,
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget _buildDropDownMenu(){
    return DropdownButton(
      value: _bodyPart,
      elevation: 20,
      isDense: true,
      dropdownColor: Colors.grey,
      onChanged: (value){
        setState(() {
          _bodyPart=value;
        });
      },
      items: [
        DropdownMenuItem(child: Text("Biceps"),value: "Biceps",),
        DropdownMenuItem(child: Text("Legs"),value: "Legs",),
        DropdownMenuItem(child: Text("Shoulders"),value: "Shoulders",),
        DropdownMenuItem(child: Text("Triceps"),value: "Triceps",),
        DropdownMenuItem(child: Text("Abs"),value: "Abs",),
        DropdownMenuItem(child: Text("Back"),value: "Back",),
        DropdownMenuItem(child: Text("Chest"),value: "Chest",),
      ],
    );
  }
}
