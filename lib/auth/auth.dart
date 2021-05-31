import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_app/blocks/auth_block.dart';
import 'signin.dart';
import 'signup.dart';

class Auth extends StatelessWidget {
    AuthBlock authBlock;
    BuildContext _context;
    initState(){
        if (authBlock.isLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.popAndPushNamed(_context, '/card');
                // Navigator.popAndpushNamed(_context, '/card',
                    // arguments: 0
                // );
            });
        }
    }
    final List<Widget> tabs = [
        SignIn(),
        // SignUp()
    ];
    @override
    Widget build(BuildContext context) {
        authBlock = Provider.of<AuthBlock>(context);
        _context = context;
        //  final AuthBlock authBlock = Provider.of<AuthBlock>(context);



    return Scaffold(
      appBar: AppBar(
        title: Text(authBlock.currentIndex == 0 ? 'Sign In' : 'Create Account'),
        backgroundColor: Color.fromRGBO(0, 153, 182, 50),
      ),
//      bottomNavigationBar: BottomNavigationBar(
//        items: const <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.lock_open),
//            title: Text('Sign In'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.people_outline),
//            title: Text('Create Account'),
//          ),
//        ],
//        currentIndex: authBlock.currentIndex,
//        selectedItemColor: Colors.amber[800],
//        onTap: (num){
//           authBlock.currentIndex = num;
//        },
//      ),
            body: tabs[authBlock.currentIndex],
        );
    }
}