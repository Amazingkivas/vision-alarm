import 'package:flutter/material.dart';

class SelectSymbolScreen extends StatelessWidget {
  final List<String> symbols = [
    'α', 'β', 'γ', 'δ', 'ε', 'ζ', 'η', 'θ', 'ι', 'κ', 'λ', 'μ', 'ν', 'ξ', 'ο', 'π', 'ρ', 'σ', 'τ', 'υ', 'φ', 'χ', 'ψ', 'ω'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Symbol'),
      ),
      body: ListView.builder(
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(symbols[index]),
            onTap: () {
              Navigator.pop(context, symbols[index]);
            },
          );
        },
      ),
    );
  }
}
