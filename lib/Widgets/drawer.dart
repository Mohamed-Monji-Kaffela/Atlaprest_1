import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/images/pngegg.png'),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Mohamed_Monji',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'mohamedmonjikaffela@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: Text('item1'),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('item2'),
            onTap: (){
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
