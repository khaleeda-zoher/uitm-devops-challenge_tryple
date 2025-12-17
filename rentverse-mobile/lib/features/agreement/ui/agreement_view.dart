import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:rentverse_mobile/features/agreement/logic/agreement_provider.dart';

class AgreementView extends StatelessWidget {
  const AgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgreementProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text('Error: ${provider.error}'));
    }

    if (provider.pdfData == null) {
      return const Center(child: Text('No agreement generated yet.'));
    }

    return PdfPreview(
      build: (format) => provider.pdfData!,
    );
  }
}