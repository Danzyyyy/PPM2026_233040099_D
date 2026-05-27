import 'package:flutter/material.dart'; // [cite: 307]

void main() { // [cite: 308]
  runApp(MaterialApp( // [cite: 309]
    debugShowCheckedModeBanner: false, // [cite: 310]
    home: Scaffold( // [cite: 311]
      body: Center( // [cite: 312]
        child: Container( // [cite: 313]
          width: 200, height: 200, // [cite: 314]
          padding: const EdgeInsets.all(20), // [cite: 315]
          decoration: BoxDecoration( // [cite: 316]
            color: Colors.blue, // [cite: 317]
            borderRadius: BorderRadius.circular(20), // [cite: 318]
            boxShadow: [ // [cite: 319]
              BoxShadow( // [cite: 320]
                color: Colors.blue.withValues(alpha: 0.3), // [cite: 321]
                blurRadius: 20, // [cite: 321]
                offset: const Offset(0, 10), // [cite: 322]
              ) // [cite: 323]
            ], // [cite: 325]
          ),
          child: const Center( // [cite: 326]
            child: Text('Box', // [cite: 327]
                style: TextStyle(color: Colors.white, fontSize: 24) // [cite: 328]
            ), // [cite: 329]
          ), // [cite: 330]
        ),
      ),
    ),
  ));
}