import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

// ============================================================
// ADDRESS BOOK SCREEN
// ============================================================

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  final List<Map<String, String>> addresses = [
    {
      'name': 'Sophia Laurent',
      'address': 'No. 25, Flower Road',
      'city': 'Colombo',
      'phone': '+94 77 123 4567',
    },
  ];

  void _showAddressForm({int? index}) {
    final existing = index != null ? addresses[index] : null;

    final nameController =
        TextEditingController(text: existing?['name'] ?? '');
    final addressController =
        TextEditingController(text: existing?['address'] ?? '');
    final cityController =
        TextEditingController(text: existing?['city'] ?? '');
    final phoneController =
        TextEditingController(text: existing?['phone'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: warmIvory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  index == null ? 'Add New Address' : 'Edit Address',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                const SizedBox(height: 20),

                _inputField(
                  controller: nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 12),

                _inputField(
                  controller: addressController,
                  label: 'Address',
                  icon: Icons.location_on_outlined,
                ),

                const SizedBox(height: 12),

                _inputField(
                  controller: cityController,
                  label: 'City',
                  icon: Icons.location_city_outlined,
                ),

                const SizedBox(height: 12),

                _inputField(
                  controller: phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.trim().isEmpty ||
                          addressController.text.trim().isEmpty ||
                          cityController.text.trim().isEmpty ||
                          phoneController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill in all fields.',
                            ),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        final newAddress = {
                          'name': nameController.text.trim(),
                          'address': addressController.text.trim(),
                          'city': cityController.text.trim(),
                          'phone': phoneController.text.trim(),
                        };

                        if (index == null) {
                          addresses.add(newAddress);
                        } else {
                          addresses[index] = newAddress;
                        }
                      });

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: azaleaPink,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      index == null ? 'Save Address' : 'Update Address',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: azaleaPink,
          size: 20,
        ),
        labelStyle: const TextStyle(
          color: subtitleColor,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: inputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: azaleaPink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete Address',
            style: TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to remove this address?',
            style: TextStyle(
              color: subtitleColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: darkCharcoal,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addresses.removeAt(index);
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: azaleaPink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,

      appBar: AppBar(
        backgroundColor: warmIvory,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Address Book',
          style: TextStyle(
            color: darkCharcoal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: darkCharcoal,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: [
          const Text(
            'Saved Addresses',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          ...List.generate(
            addresses.length,
            (index) {
              final address = addresses[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: blushPink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: azaleaPink,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            address['name']!,
                            style: const TextStyle(
                              color: darkCharcoal,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: subtitleColor,
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showAddressForm(index: index);
                            } else if (value == 'delete') {
                              _deleteAddress(index);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      address['address']!,
                      style: const TextStyle(
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      address['city']!,
                      style: const TextStyle(
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      address['phone']!,
                      style: const TextStyle(
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: sageGreen.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Default Address',
                        style: TextStyle(
                          color: sageGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 5),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {
                _showAddressForm();
              },
              icon: const Icon(
                Icons.add,
                color: azaleaPink,
              ),
              label: const Text(
                'Add New Address',
                style: TextStyle(
                  color: azaleaPink,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: azaleaPink,
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}