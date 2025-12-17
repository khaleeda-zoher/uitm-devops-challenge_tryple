import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';
import 'agreement_models.dart'; // contains Lease, Signatures

class AgreementRepository {
  /// Generates a PDF from the HTML template using the lease & signatures
  Future<Uint8List> generateAgreementPdf({
    required Lease lease,
    required Signatures signatures,
  }) async {
    // 1. Load HTML template from assets
    String htmlTemplate = await rootBundle.loadString('assets/templates/agreement.html');

    // 2. Fill template placeholders
    htmlTemplate = htmlTemplate
        .replaceAll('<%- lease.landlord.name %>', lease.landlord.name)
        .replaceAll('<%- lease.tenant.name %>', lease.tenant.name)
        .replaceAll('<%- lease.property.address %>', lease.property.address)
        // ...repeat for other fields
        ;

    // 3. Convert HTML to PDF using printing package
    final pdf = await Printing.convertHtml(
      format: PdfPageFormat.a4,
      html: htmlTemplate,
    );

    return pdf;
  }
}