import 'package:extension_utils/extension_utils.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Extension Utils Demo',
        theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
        home: const TimingExample(),
      );
}

class TimingExample extends StatefulWidget {
  const TimingExample({super.key});

  @override
  State<TimingExample> createState() => _TimingExampleState();
}

class _TimingExampleState extends State<TimingExample> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 400));
  final _throttler = Throttler(interval: const Duration(seconds: 1));
  String _query = '';
  int _searches = 0;
  int _accepted = 0;
  int _ignored = 0;

  @override
  void dispose() {
    _debouncer.dispose();
    _throttler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Debounce and throttle')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Debounced search',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
                'Type a query. It updates after you stop typing for 400 ms.'),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Search', border: OutlineInputBorder()),
              onChanged: (value) => _debouncer.run(() {
                setState(() {
                  _query = value;
                  _searches++;
                });
              }),
            ),
            const SizedBox(height: 8),
            Text('Last query: $_query'),
            Text('Search calls: $_searches'),
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                    onPressed: _debouncer.flush, child: const Text('Run now')),
                TextButton(
                    onPressed: _debouncer.cancel,
                    child: const Text('Cancel pending search')),
              ],
            ),
            const Divider(height: 40),
            Text('Throttled action',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
                'Tap repeatedly. Only the first tap each second runs; ignored taps are not queued.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                final ran = _throttler.run(() => _accepted++);
                setState(() {
                  if (!ran) _ignored++;
                });
              },
              child: const Text('Try action'),
            ),
            Text('Accepted: $_accepted · Ignored: $_ignored'),
          ],
        ),
      );
}
