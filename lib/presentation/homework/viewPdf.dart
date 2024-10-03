import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lerno/core/app_export.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../apiHelper/GlobalData.dart';

class DocumentViewerScreen extends StatefulWidget {
  final String documentUrl;

  DocumentViewerScreen({required this.documentUrl});

  @override
  _DocumentViewerScreenState createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  bool _isLoading = true;
  bool _isPdf = false;
  String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  @override
  void initState() {
    super.initState();
    _checkDocumentType();
  }

  Future<void> _checkDocumentType() async {
    final url = widget.documentUrl;
    if (url.toLowerCase().endsWith('.pdf')) {
      setState(() {
        _isPdf = true;
      });
    } else {
      setState(() {
        _isPdf = false;
      });
    }
    setState(() {
      _isLoading = false;
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
  void dispose() {
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
          _isPdf?'Pdf View': 'Image View',
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),
        ),

      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isPdf
          ? SfPdfViewer.network(widget.documentUrl)
          : Image.network(widget.documentUrl),
    );
  }
}
