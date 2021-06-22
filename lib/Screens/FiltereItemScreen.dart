import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_buddy/src/models/itemModel.dart';
import 'package:gym_buddy/src/providers/imageProvider.dart';
import 'package:provider/provider.dart';

class FilteredScreen extends StatefulWidget {
  @override
  _FilteredScreenState createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {

  void getItemList() {
    print("GET ITEM LIST CALLED");
    Provider.of<PhotosProvider>(context,listen: false).updateFilteredPhotos();
  }

  @override
  Widget build(BuildContext context) {
    getItemList();
    return Scaffold(
      floatingActionButton: _floatingActionBar(),     // floating action Bar arranged by me
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Provider.of<PhotosProvider>(context,listen: true).filteredphotosList.length!=0?
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<PhotosProvider>(context).filteredphotosList.length,
              itemBuilder: (BuildContext context,int index){
                print("$index");
                return _buildCard(Provider.of<PhotosProvider>(context).filteredphotosList[index]);
              }
          ):
          Center(child: Text("No images of this category"),),
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
      width: MediaQuery.of(context).size.width*0.40,
      height: MediaQuery.of(context).size.width*0.15,
      child: Row(
        children: [
          IconButton(
            tooltip: "Refresh",
            icon: Icon(Icons.refresh),
            onPressed: (){
              setState(() {});
            },
          ),
          Center(
            child: DropdownButton(
              value: Provider.of<PhotosProvider>(context).filtere,
              elevation: 20,
              isDense: false,
              dropdownColor: Colors.grey,
              onChanged: (value){
                  Provider.of<PhotosProvider>(context,listen: false).setfilter(value);
                  setState(() {});
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(ItemModel itemModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.8,
          margin: EdgeInsets.all(10),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: itemModel.image!=null?
                  Image.memory(
                    itemModel.image,
                    fit: BoxFit.cover,
                  )
                      : Text(
                      "Image currupted"
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.redAccent[300],
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      setState(() {
                        Provider.of<PhotosProvider>(context,listen: false).deleteImage(itemModel.id);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height*0.11,
            width: MediaQuery.of(context).size.width*0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("id : ${itemModel.id}"),
                Text("${itemModel.date}"),
                SizedBox(height: 5,),
                Text("${itemModel.bodyPart}"),
                // Text("${Provider.of<PhotosProvider>(context,listen: true).photosList.length}"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
