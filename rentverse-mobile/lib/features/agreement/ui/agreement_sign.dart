import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:rentverse_mobile/features/agreement/logic/agreement_provider.dart';
import 'package:rentverse_mobile/features/agreement/data/agreement_models.dart';

class AgreementSignScreen extends StatelessWidget {
  final Lease lease; // Pass the lease when opening this screen
  final Signatures signatures; // And the signatures to generate PDF

  const AgreementSignScreen({
    super.key,
    required this.lease,
    required this.signatures,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgreementProvider>();

    // Trigger PDF generation if not already done
    if (provider.pdfData == null && !provider.loading && provider.error == null) {
      provider.generatePdf(lease, signatures);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Agreement')),
      body: Center(
        child: Builder(
          builder: (_) {
            if (provider.loading) {
              return const CircularProgressIndicator();
            }

            if (provider.error != null) {
              return Text('Error: ${provider.error}');
            }

            if (provider.pdfData == null) {
              return const Text('Generating agreement...');
            }

            // Show PDF preview
            return PdfPreview(
              build: (format) => provider.pdfData!,
            );
          },
        ),
      ),
    );
  }
}