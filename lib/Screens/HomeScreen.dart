import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_buddy/Screens/CreateNewItemScreen.dart';
import 'package:gym_buddy/Screens/FiltereItemScreen.dart';
import 'package:gym_buddy/src/models/itemModel.dart';
import 'package:gym_buddy/src/providers/imageProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void getItemList() {
    print("GET ITEM LIST CALLED");
    Provider.of<PhotosProvider>(context).updatePhotos();
  }

  @override
  Widget build(BuildContext context) {
    getItemList();
    return Scaffold(
      floatingActionButton: _floatingActionBar(),     // floating action Bar arranged by me
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Provider.of<PhotosProvider>(context).photosList.length!=0?
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<PhotosProvider>(context).photosList.length,
              itemBuilder: (BuildContext context,int index){
                print("$index");
                return _buildCard(Provider.of<PhotosProvider>(context).photosList[index]);
              }
          )
              :
          Center(child: Text("Add Items"),),
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
      width: MediaQuery.of(context).size.width*0.4,
      height: MediaQuery.of(context).size.width*0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            tooltip: "Refresh",
            icon: Icon(Icons.refresh),
            onPressed: (){
              setState(() {});
            },
          ),
          IconButton(
            tooltip: "Add New Data",
            icon: Icon(Icons.filter),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return FilteredScreen();
              }));
            },
          ),
          IconButton(
            tooltip: "Add New Data",
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CreateNewItemScreen();
              }));
            },
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
                      Provider.of<PhotosProvider>(context,listen: false).deleteImage(itemModel.id);
                      setState(() {});
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
