import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/medicine.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final lowStockMedicines = appState.getLowStockMedicines();
        final expiringMedicines = appState.getExpiringMedicines();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 16),
                _buildMedicineList(
                  context,
                  'Low Stock Medicines',
                  lowStockMedicines,
                ),
                const SizedBox(height: 16),
                _buildMedicineList(
                  context,
                  'Expiring Medicines',
                  expiringMedicines,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMedicineList(
    BuildContext context,
    String title,
    List<Medicine> medicines,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        if (medicines.isEmpty)
          const Text('No medicines to display')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return ListTile(
                title: Text(medicine.name),
                subtitle: Text(
                  '${medicine.dosage} - Quantity: ${medicine.quantity}',
                ),
                trailing: Text(
                  'Expires: ${medicine.expiryDate.toString().split(' ')[0]}',
                ),
              );
            },
          ),
      ],
    );
  }
}

