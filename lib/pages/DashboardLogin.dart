import 'package:flutter/material.dart';

class DashboardLogin extends StatelessWidget {
  DashboardLogin({Key? key}) : super(key: key);

  String? Email;
  String? Password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight > 600 && constraints.maxWidth > 800) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(5)),
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    ));
  }
}
