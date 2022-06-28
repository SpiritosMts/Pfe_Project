import 'package:changel/Models/user.dart';
import 'package:changel/Models/navigation_item.dart';
import 'package:changel/Screens/login/login.dart';
import 'package:changel/provider/navigation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:provider/provider.dart';

import '../page/deconnection_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  static final padding = EdgeInsets.symmetric(horizontal: 20);

  Widget buildMenuItem(
      BuildContext context, {
        required NavigationItem item,
        required String text,
      }) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    final color = isSelected ? Colors.orangeAccent : Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.white24,
        title: Text(text, style: TextStyle(color: color, fontSize: 16)),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }

  Widget buildHeader(
      BuildContext context, {
        required String urlImage,
        required String name,
        required String email,
      }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          //onTap: () => selectItem(context, NavigationItem.header),
          child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(urlImage)),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                  child: Icon(Icons.add_comment_outlined, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          color: Color.fromRGBO(50, 55, 205, 1),
          child: ListView(
            children: <Widget>[
              buildHeader(
                context,
                urlImage: urlImage,
                name: name,
                email: email,
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      item: NavigationItem.Acceuil,
                      text: 'Acceuil',
                    ),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      item: NavigationItem.Mes_depanneurs,
                      text: 'Historique',
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavigationItem.Mes_voitures,
                      text: 'Mes_voitures',
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavigationItem.Mot_de_passe,
                      text: 'Mot_de_passe',
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavigationItem.Parametre,
                      text: 'Paramètres',
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      item: NavigationItem.aide,
                      text: 'Aide',
                    ),
                    const SizedBox(height: 16),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        //selected: isSelected,
                        selectedTileColor: Colors.white24,
                        title: Text('Deconnection', style: TextStyle(color: Colors.white, fontSize: 16)),
                        onTap: () =>  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Expanded(
                              child: AlertDialog(
                                title: Text('Deconnection'),
                                content: Text('Voulez-Vous Vraiement Se Deconnecter?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Fluttertoast.showToast(
                                      msg: "Au revoir ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                      Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                    },
                                    child: Text('oui', style: TextStyle(color: Colors.black),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('non', style: TextStyle(color: Colors.black),),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // buildMenuItem(
                    //   context,
                    //   item: NavigationItem.deconnection,
                    //   text: 'Deconnection',
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );


}
