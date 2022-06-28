import 'package:changel/Models/user.dart';
import 'package:changel/mapPageChangel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../mapPage.dart';
import '../provider/navigation_provider.dart';
import '../widget/navigation_drawer_widget.dart';

class AcceuilPage extends StatefulWidget {

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> {
  var currUser =AppUser();
  @override
  void initState() {
    super.initState();
    /// get curr user from provider
    final provider = Provider.of<NavigationProviderUser>(context,listen: false);
    currUser = provider.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: currUser.isChan == 'false'? ClientMap():ChangelMap(),
    );
  }
}
