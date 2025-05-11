import 'package:flutter/material.dart';
import 'focus_chart.dart'; // Grafik dosyasını dahil ediyoruz

void main() {
  runApp(FocusScoreApp());
}

class FocusScoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Score App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: FocusHomePage(),
    );
  }
}

class FocusHomePage extends StatefulWidget {
  @override
  _FocusHomePageState createState() => _FocusHomePageState();
}

class _FocusHomePageState extends State<FocusHomePage> {
  double _currentScore = 50;
  List<Map<String, dynamic>> _scoreList = [];

  void _saveScore() {
    final today = DateTime.now().toString().split(" ")[0];
    setState(() {
      _scoreList.add({'date': today, 'score': _currentScore.toInt()});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Focus Score')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Today's Focus Score: ${_currentScore.toInt()}",
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              value: _currentScore,
              min: 0,
              max: 100,
              divisions: 100,
              label: _currentScore.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _currentScore = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _saveScore,
              child: Text("Save"),
            ),
            Divider(height: 30),
            SizedBox(
              height: 200,
              child: FocusBarChart(data: _scoreList),
            ),
            Divider(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _scoreList.length,
                itemBuilder: (context, index) {
                  final item = _scoreList[index];
                  return ListTile(
                    leading: Icon(Icons.today),
                    title: Text("${item['date']}"),
                    trailing: Text("${item['score']} / 100"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
