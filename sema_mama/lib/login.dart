import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Login Screen'),
      ),
      body:Center(
        child:Column(
          mainAxisAlignment:mainAxisAlignment,center,
          children: [
            const TextField(
              decoration:InputDecoration(
                labelText:'Email',
              ),
            ),
            const SizedBox(height:16),
            const TextField(
              obscureText:true,
              decoration:InputDecoration(
                labelText: 'Password',
              ),
            ),
            const  SizedBox(height:16),
            ElevatedButton(
              onPressed:() {},
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}