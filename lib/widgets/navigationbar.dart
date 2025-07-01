import 'package:career/api/api_methods.dart';
import 'package:career/screens/Login.dart';
import 'package:career/screens/signUpScreen.dart';
import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/profile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    print("NAVBAR CALLED");
    //final name = profileData["firstName"]+profileData["lastName"]??"Partho Parekh";
    final name = "Partho Parekh";
    //final email = profileData["email"]??"user123@gmail.com";
    final email = "user123@gmail.com";
    final urlImage =
        'https://static.vecteezy.com/system/resources/thumbnails/000/439/863/small/Basic_Ui__28186_29.jpg';

    return Drawer(
      child: Material(
        color: AppColors.primaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),));
              },),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                 // buildSearchField(),
                  //const SizedBox(height: 24),
                  buildExpansionMenuItem(
                    text: "Courses",
                    icon: Icons.settings,
                    children: [
                      buildMenuItem(
                        text: "6th",
                        icon: Icons.account_circle,
                        onClicked: () {} ,
                      ),
                      buildMenuItem(
                        text: "7th",
                        icon: Icons.lock,
                        onClicked: () {} ,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Course enrolled',
                    icon: Icons.text_snippet_outlined,
                    onClicked: () {} ,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Mock Test and questioning',
                    icon: Icons.workspaces_outline,
                    onClicked: () {} ,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'My Ranking',
                    icon: Icons.update,
                    onClicked: () {} ,
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Payment Details',
                    icon: Icons.payment,
                    onClicked: () {} ,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Share/Referral',
                    icon: Icons.share,
                    onClicked: () {} ,
                  ),
                 // const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Upcoming Exams',
                    icon: Icons.account_tree_outlined,
                    onClicked: () {} ,
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'settings',
                    icon: Icons.notifications_outlined,
                    onClicked: () {} ,
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.notifications_outlined,
                    onClicked: () {
                      clearSharedPref();
Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
                    } ,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              //Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.error,
                child: Icon(Icons.edit, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
  Widget buildExpansionMenuItem({
    required String text,
    required IconData icon,
    required List<Widget> children,
    VoidCallback? onExpansionChanged,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

      return ExpansionTile(
        // Main tile properties
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color)),

        // Style properties
        iconColor: color,
        collapsedIconColor: color,
        textColor: color,
        collapsedTextColor: color,

        // Layout properties
        tilePadding: EdgeInsets.symmetric(horizontal: 16), // Match default ListTile
        childrenPadding: EdgeInsets.only(left: 24), // Indent children

        // Interaction properties
        onExpansionChanged: (expanded) {
          if (onExpansionChanged != null) onExpansionChanged();
        },

        // Children
        children: children.map((child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1), // Slight background for children
            ),
            child: child,
          );
        }).toList(),
    );
  }
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
        break;
    }
  }
}