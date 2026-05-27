import 'package:flutter/material.dart'; // [cite: 283]

void main() { // [cite: 284]
  runApp(const MaterialApp( // [cite: 285]
    debugShowCheckedModeBanner: false, // [cite: 286]
    home: Scaffold( // [cite: 287]
      body: Center( // [cite: 288]
        child: Column( // [cite: 289]
          mainAxisAlignment: MainAxisAlignment.center, // [cite: 290]
          children: [ // [cite: 291]
            Text('Hello Flutter!', // [cite: 292]
              style: TextStyle( // [cite: 295]
                fontSize: 28, // [cite: 296]
                fontWeight: FontWeight.bold, // [cite: 296]
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text('Ini teks biasa dengan ukuran kecil',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  ));
}