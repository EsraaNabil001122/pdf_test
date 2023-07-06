import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobil_pdf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _createPDF,
          child: const Text("Create PDF"),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    document.pages.add();
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 3);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "id";
    header.cells[1].value = "age";
    header.cells[2].value = "owner";
    PdfGridRow row = grid.rows.add();
    row = grid.rows.add();
    row.cells[0].value = '000';
    row.cells[1].value = '3 month';
    row.cells[2].value = 'salam';
    row = grid.rows.add();
    row.cells[0].value = '001';
    row.cells[1].value = '2 month';
    row.cells[2].value = 'salam2';
    row = grid.rows.add();
    row.cells[0].value = '002';
    row.cells[1].value = '2 month';
    row.cells[2].value = 'salam2';
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = await document.save();
    document.dispose();

    saveAndLunchFile(bytes, 'Output.pdf');
  }
}
