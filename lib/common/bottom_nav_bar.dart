import 'package:flutter/material.dart';

Widget bottomNavBar(BuildContext context) {

     int _selectedIndex=0;
    return BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blue,
        items: [
            BottomNavigationBarItem(

                icon: new Icon(Icons.home),
                title: new Text('Home'),

            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.card_giftcard),
                title: new Text('Products'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text('Categories')

            )
        ],
        onTap: (int index)
        {
            // setState(() {
            //   // _selectedIndex = index;
            //   // print(_selectedIndex);
            // });
            switch(index) {
                case 0:
                    Navigator.pushNamed(context, '/');
                    break;
                case 1:
                    Navigator.pushNamed(context, '/worldlist');
                    break;
                case 2:
                    Navigator.pushNamed(context, '/category');
                    break;

            }

        }
    );
}

class BottomNavBar extends StatefulWidget {
    @override
    BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
    @override



    int _selectedIndex=0;
    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
            print(_selectedIndex);
        });
        switch(_selectedIndex) {
            case 0:
                Navigator.pushNamed(context, '/');
                break;
            case 1:
                Navigator.pushNamed(context, '/worldlist');
                break;
            case 2:
                Navigator.pushNamed(context, '/category');
                break;

        }

    }

    Widget build(BuildContext context) {
        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: 0, // this will be set when a new tab is tapped
                backgroundColor: Colors.white,
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.blue,
                items: [
                    BottomNavigationBarItem(

                        icon: new Icon(Icons.home),
                        title: new Text('Home'),

                    ),
                    BottomNavigationBarItem(
                        icon: new Icon(Icons.card_giftcard),
                        title: new Text('Products'),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category),
                        title: Text('Categories')

                    )
                ],
                onTap:  _onItemTapped,

            ),
        );
    }
}


