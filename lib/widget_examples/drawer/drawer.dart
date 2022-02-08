import 'package:flutter/material.dart';

class DrawerExample extends StatelessWidget {
  const DrawerExample();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {
        'title': 'Home',
        'icondata': Icons.home,
        'fn': () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Beep Boop! (Home)')));
        },
      },
      {
        'title': 'Data',
        'icondata': Icons.book,
        'fn': () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Beep Boop! (Data)')));
        },
      },
      {
        'title': 'Settings',
        'icondata': Icons.settings,
        'fn': () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Beep Boop! (Settings)')));
        },
      },
    ];

    final Size size = MediaQuery.of(context).size;

    // Parameters
    final double drawerWidth = size.width * 0.55; // 55% of the screen width
    const double leftPadding = 36.0;
    const double rightPadding = 12.0;
    const double topPadding = 96.0;

    return Container(
      decoration: const BoxDecoration(color: Colors.amber),
      width: drawerWidth,
      padding: const EdgeInsets.only(left: leftPadding, right: rightPadding, top: topPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Drawer Example', style: TextStyle(fontSize: 36)),
          const Text('By Jeremy', style: TextStyle(fontSize: 18)),
          const Divider(),
          ...buttons
              .map((buttonData) => ListTile(
                    leading: Icon(buttonData['icondata']),
                    title: Text(buttonData['title']),
                    onTap: buttonData['fn'],
                  ))
              .toList(),
        ],
      ),
    );
  }
}
