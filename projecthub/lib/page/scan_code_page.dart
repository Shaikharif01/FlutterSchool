import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'generate_code_page.dart';

class ScanCodePage extends StatelessWidget {
  const ScanCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan QR Code', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GenerateCodePage()),
              );
            },
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              returnImage: true,
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              final image = capture.image;

              if (barcodes.isNotEmpty) {
                final value = barcodes.first.rawValue ?? "No data";

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text('QR Code Detected'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (image != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(image, height: 150),
                          ),
                        const SizedBox(height: 12),
                        SelectableText(value, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            width: 250,
            height: 250,
          ),
          Positioned(
            bottom: 30,
            child: Text(
              "Align QR inside the box",
              style: TextStyle(color: Colors.white.withAlpha(204)),
            ),
          )
        ],
      ),
    );
  }
}
