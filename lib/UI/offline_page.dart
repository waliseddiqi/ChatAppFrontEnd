import 'package:flutter/material.dart';


class OfflinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple[400],
                      Colors.blue[600],
                      Colors.indigo[800],
                    ],
                    begin: Alignment(0.5, -1.0),
                    end: Alignment(0.5, 1.0)
                )
            ),
            child: Stack(
              children: <Widget>[
                
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Evinden 404 Işık yılı uzaklaştın",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          child: Text(
                            "Geri dön ve internetini kontrol et",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                ),
              ],
            )
        )
    );
  }
}
