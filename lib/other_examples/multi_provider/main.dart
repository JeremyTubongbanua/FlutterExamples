import 'package:flutter/material.dart';
import './count_provider.dart';
import 'package:provider/provider.dart';

void main() {
  const MaterialApp materialApp = MaterialApp(
    home: App(),
  );
  final ChangeNotifierProvider<CountProvider> provider = ChangeNotifierProvider<CountProvider>(
    create: (context) => CountProvider(),
    child: materialApp,
  );
  final MultiProvider multiProvider = MultiProvider(
    providers: [
      ChangeNotifierProvider<CountProvider>(create: (context) => CountProvider()), // constructor is good for provider classes that are instantiated once.
      // ChangeNotifierProvider.value(value: CountProvider()), // .value is good for provider classes that are constantly being reinstantiated.
    ],
    child: materialApp,
  );
  runApp(provider);
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final int currentCount = Provider.of<CountProvider>(context).currentCount;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Current Count:', style: TextStyle(fontSize: 32)),
            Text(currentCount.toString(), style: TextStyle(fontSize: 32)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CountProvider>(context, listen: false).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
