import 'package:exemple4/pages/Alertes_Page.dart';
import 'package:exemple4/pages/Realises_page.dart';
import 'package:exemple4/pages/historique_page.dart';
import 'package:exemple4/pages/planifies_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({super.key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int currentPageIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        key:_bottomNavigationKey ,
        // indicatorColor: Colors.amber,
        // selectedIndex: currentPageIndex,
        // elevation: 15,
        // destinations: const <Widget>[
        items:[
          CurvedNavigationBarItem(
              child: Icon(Icons.calendar_month_outlined,size: 30),
              label: 'Planifiés',
              labelStyle: TextStyle(fontSize: 16),
          ),
          CurvedNavigationBarItem(
            child:Icon (Icons.fact_check,size: 30,),
            label: 'Réalisés',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.warning_amber_outlined,size: 30),
            label: 'Alertes',
          ),
          CurvedNavigationBarItem(
            child:Icon (Icons.history,size: 30),
            label: 'Historique',
          ),
        ],
      //],
      ),
      body: <Widget>[
        /// appel page de Planification
        PlanifiesPage(),

        /// appel page de Tache Realisés
        RealisesPage(),

        /// appel page d'Alertes
        AlertsesPage(),

        /// appel page d'Historique
        HistoriquePage(),

      ][currentPageIndex],
    );
  }
}

























//
// import 'package:flutter/material.dart';
//
// import '../pages/planifies_page.dart';
//
// class MyBottomNavigationBar extends StatefulWidget {
//   const MyBottomNavigationBar({super.key});
//
//   @override
//   State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
// }
//
// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//
//
//   int _currentIndex = 0;
//
//   setCurrentIndex(int index){
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         unselectedLabelStyle: TextStyle(
//           fontSize: 14.0,
//           fontWeight: FontWeight.normal,
//         ),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.grey[500],
//         unselectedItemColor: Colors.grey[800],
//         iconSize: 25,
//         elevation: 10,
//         currentIndex: _currentIndex,
//         onTap: (index)=> setCurrentIndex(index),
//         items:const [
//           BottomNavigationBarItem(icon: Icon(Icons.calendar_today),
//             label:'Planifiés',
//             backgroundColor: Color(0xffFDFDFDFF),
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.fact_check),
//             label: 'Realises',
//             backgroundColor: Color(0xffFDFDFDFF),
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.warning_amber),
//             label: 'Alerts',
//             backgroundColor: Color(0xffFDFDFDFF),  // 0xffFDFDFDFF
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.history),
//             label: 'Historiques',
//             backgroundColor: Color(0xffFDFDFDFF),
//           ),
//         ],
//       );
//   }
// }
