import 'package:flutter/material.dart';
import 'package:tpndine/configuration/size_config.dart';
import 'package:tpndine/view_models/site_viewmodel.dart';

class RestaurantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroceryStoreListState();
}

/// This class keeps track of the nearby grocery stores.
/// The Azure Maps Api is used to get the list of nearby grocery stores based on entered
/// location.
///
/// @author Aditya Varun Pratap
/// @version 1.0
class _GroceryStoreListState extends State<RestaurantPage> {
  double _height = 0;
  double _width = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _height = SizeConfig.screenHeight;
    _width = SizeConfig.screenWidth;

    SiteViewModel _siteViewModel = SiteViewModel();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(
              child: Text(
            "Nearby Restaurants",
            style: TextStyle(fontSize: _height * .05),
          )),
        ),
        body: FutureBuilder(
            future: _siteViewModel.getSiteList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GroceryCard(
                      address: snapshot.data[index].address,
                      contact: "Aditya Pratap",
                      description: snapshot.data[index].description,
                      name: snapshot.data[index].siteName,
                      status: snapshot.data[index].status,
                    );
                  });
            }));
  }
}

class GroceryCard extends StatelessWidget {
  double? _width;
  double? _height;
  String? name;
  String? contact;
  String? address;
  String? description;
  String? status;

  GroceryCard(
      {Key? key,
      this.contact,
      this.name,
      this.description,
      this.address,
      this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _height = SizeConfig.screenHeight;
    _width = SizeConfig.screenWidth;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            _width! * .03, _height! * .02, _width! * .03, _width! * .005),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),
          height: _height! * .25,
          width: _width! * .70,
          child: Stack(
            children: [
              ClipRect(
                child: Container(
                  color: const Color.fromARGB(200, 98, 207, 87),
                  height: 80,
                ),
              ),
              _showGroceryStoreName(name!),
              _showOccupancyAndAddress(20, address!)
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed('/details', arguments: {'heroTag': name}),
    );
  }

  Widget _showGroceryStoreName(String name) {
    return Padding(
      padding: EdgeInsets.only(top: .04 * _height!),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          name,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: _width! * .08),
        ),
      ),
    );
  }

  Widget _showOccupancyAndAddress(int occupancy, String address) {
    return Padding(
      padding: EdgeInsets.only(top: .11 * _height!, left: .02 * _width!),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            FittedBox(
              child: Text(
                "Address: " + address,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: _width! * .06),
              ),
            ),
            Text(
              "Description " + description.toString(),
              maxLines: 1,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                  fontSize: _width! * .06),
            ),
            FittedBox(
              child: Text(
                "Contact: " + contact!,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: _width! * .06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
