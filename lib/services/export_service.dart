import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../models/medicine.dart';
import '../models/family_member.dart';

class ExportService {
  static final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<void> exportToPdf({
    required List<FamilyMember> familyMembers,
    required List<Medicine> medicines,
  }) async {
    final pdf = pw.Document();

    // Create PDF content
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('MediAlert - Medicine Report',
                style: pw.TextStyle(fontSize: 24)),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Generated on: ${_dateFormatter.format(DateTime.now())}'),
          pw.SizedBox(height: 20),
          ...familyMembers.map((member) {
            final memberMedicines = medicines
                .where((m) => m.metadata['familyMemberId'] == member.id)
                .toList();

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 1,
                  child: pw.Text(member.name,
                      style: pw.TextStyle(fontSize: 20)),
                ),
                pw.Text('Relationship: ${member.relationship ?? "Not specified"}'),
                if (member.notes != null) pw.Text('Notes: ${member.notes}'),
                pw.SizedBox(height: 10),
                if (memberMedicines.isEmpty)
                  pw.Text('No medicines registered')
                else
                  pw.Table.fromTextArray(
                    context: context,
                    headers: [
                      'Medicine',
                      'Dosage',
                      'Frequency',
                      'Stock',
                      'Expiry Date'
                    ],
                    data: memberMedicines.map((medicine) => [
                      medicine.name,
                      medicine.dosage,
                      medicine.frequency,
                      medicine.currentQuantity.toString(),
                      medicine.expiryDate != null
                          ? _dateFormatter.format(medicine.expiryDate!)
                          : 'Not set',
                    ]).toList(),
                  ),
                pw.SizedBox(height: 20),
              ],
            );
          }).toList(),
        ],
      ),
    );

    // Save and share PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/medicine_report.pdf');
    await file.writeAsBytes(await pdf.save());
    await Share.shareXFiles([XFile(file.path)],
        subject: 'MediAlert - Medicine Report');
  }

  Future<void> exportToCsv({
    required List<FamilyMember> familyMembers,
    required List<Medicine> medicines,
  }) async {
    final List<List<dynamic>> rows = [];

    // Add header
    rows.add([
      'Family Member',
      'Relationship',
      'Medicine Name',
      'Dosage',
      'Frequency',
      'Current Stock',
      'Minimum Stock',
      'Expiry Date',
      'Instructions'
    ]);

    // Add data
    for (final member in familyMembers) {
      final memberMedicines = medicines
          .where((m) => m.metadata['familyMemberId'] == member.id)
          .toList();

      if (memberMedicines.isEmpty) {
        rows.add([
          member.name,
          member.relationship ?? '',
          '',
          '',
          '',
          '',
          '',
          '',
          ''
        ]);
      } else {
        for (final medicine in memberMedicines) {
          rows.add([
            member.name,
            member.relationship ?? '',
            medicine.name,
            medicine.dosage,
            medicine.frequency,
            medicine.currentQuantity,
            medicine.minimumQuantity,
            medicine.expiryDate != null
                ? _dateFormatter.format(medicine.expiryDate!)
                : '',
            medicine.instructions ?? ''
          ]);
        }
      }
    }

    // Convert to CSV
    final csvData = const ListToCsvConverter().convert(rows);

    // Save and share CSV
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/medicine_report.csv');
    await file.writeAsString(csvData);
    await Share.shareXFiles([XFile(file.path)],
        subject: 'MediAlert - Medicine Report');
  }

  Future<void> exportMemberReport(
    FamilyMember member,
    List<Medicine> medicines,
  ) async {
    final memberMedicines = medicines
        .where((m) => m.metadata['familyMemberId'] == member.id)
        .toList();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('Medicine Report - ${member.name}',
                style: pw.TextStyle(fontSize: 24)),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Generated on: ${_dateFormatter.format(DateTime.now())}'),
          pw.SizedBox(height: 10),
          pw.Text('Relationship: ${member.relationship ?? "Not specified"}'),
          if (member.notes != null) ...[
            pw.SizedBox(height: 10),
            pw.Text('Notes: ${member.notes}'),
          ],
          pw.SizedBox(height: 20),
          if (memberMedicines.isEmpty)
            pw.Text('No medicines registered')
          else ...[
            pw.Header(level: 1, child: pw.Text('Current Medications')),
            pw.Table.fromTextArray(
              context: context,
              headers: [
                'Medicine',
                'Dosage',
                'Frequency',
                'Stock',
                'Expiry Date'
              ],
              data: memberMedicines.map((medicine) => [
                medicine.name,
                medicine.dosage,
                medicine.frequency,
                medicine.currentQuantity.toString(),
                medicine.expiryDate != null
                    ? _dateFormatter.format(medicine.expiryDate!)
                    : 'Not set',
              ]).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Header(level: 1, child: pw.Text('Medication Details')),
            ...memberMedicines.map((medicine) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(medicine.name,
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text('Dosage: ${medicine.dosage}'),
                pw.Text('Frequency: ${medicine.frequency}'),
                if (medicine.instructions != null)
                  pw.Text('Instructions: ${medicine.instructions}'),
                pw.Text(
                    'Current Stock: ${medicine.currentQuantity} (Minimum: ${medicine.minimumQuantity})'),
                if (medicine.expiryDate != null)
                  pw.Text(
                      'Expiry Date: ${_dateFormatter.format(medicine.expiryDate!)}'),
                pw.SizedBox(height: 10),
              ],
            )).toList(),
          ],
        ],
      ),
    );

    // Save and share PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/medicine_report_${member.name}.pdf');
    await file.writeAsBytes(await pdf.save());
    await Share.shareXFiles([XFile(file.path)],
        subject: 'MediAlert - Medicine Report for ${member.name}');
  }
}

