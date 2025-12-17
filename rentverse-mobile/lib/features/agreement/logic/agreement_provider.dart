import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:rentverse_mobile_admin/features/agreement/data/agreement_repository.dart';
import 'package:rentverse_mobile_admin/features/agreement/data/agreement_models.dart';

class AgreementProvider extends ChangeNotifier {
  final AgreementRepository repository;

  AgreementProvider({required this.repository});

  Uint8List? _pdfData;
  Uint8List? get pdfData => _pdfData;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> generatePdf(Lease lease, Signatures signatures) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _pdfData = await repository.generateAgreementPdf(
        lease: lease,
        signatures: signatures,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}