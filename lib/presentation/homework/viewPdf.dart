import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lerno/core/app_export.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class DocumentViewerScreen extends StatefulWidget {
  final String documentUrl;

  DocumentViewerScreen({required this.documentUrl});

  @override
  _DocumentViewerScreenState createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  PdfDocument? _document;
  List<PdfPageImage> _pdfPages = [];
  Uint8List? _imageData;
  bool _isLoading = false;
  bool _isPdf = false;

  Future<void> _loadDocument() async {
    final url = widget.documentUrl;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.bodyBytes;

        if (url.toLowerCase().endsWith('.pdf')) {
          await _handlePdf(data);
        } else {
          _handleImage(data);
        }
      } else {
        throw Exception('Failed to load document');
      }
    } catch (e) {
      print('Error loading document: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handlePdf(Uint8List data) async {
    final document = await PdfDocument.openData(data);
    final pdfPages = <PdfPageImage>[];

    for (int i = 0; i < document.pageCount; i++) {
      final page = await document.getPage(i + 1);
      final pageImage = await page.render(width: page.width.toInt(), height: page.height.toInt());
      pdfPages.add(pageImage);
    }

    setState(() {
      _document = document;
      _pdfPages = pdfPages;
      _isPdf = true;
    });
  }

  void _handleImage(Uint8List data) {
    setState(() {
      _imageData = data;
      _isPdf = false;
    });
  }

  Future<void> _downloadDocument() async {
    final url = widget.documentUrl;
    if (await Permission.storage.request().isGranted) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final dir = await getExternalStorageDirectory();
          final extension = _isPdf ? 'pdf' : 'jpg';
          final file = File('${dir?.path}/downloaded.$extension');
          await file.writeAsBytes(bytes);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Document downloaded to ${file.path}')),
          );
        } else {
          throw Exception('Failed to download document');
        }
      } catch (e) {
        print('Error downloading document: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to download files')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  @override
  void dispose() {
    _document?.dispose();
    for (var page in _pdfPages) {
      page.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade200,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _isPdf ? 'PDF Viewer' : 'Image Viewer',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download,size: 24,),
            onPressed: _downloadDocument,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isPdf
          ? _pdfPages.isEmpty
          ? Center(child: Text('No PDF loaded'))
          : ListView.builder(
        itemCount: _pdfPages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Image(image: MemoryImage(_pdfPages[index].pixels)),
          );
        },
      )
          : _imageData == null
          ? Center(child: Text('No image loaded',style: TextStyle(fontSize: 14),))
          : Image.memory(_imageData!),
    );
  }
}