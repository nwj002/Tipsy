import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cureent_user_viewmodel.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: currentUserState.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : currentUserState.error != null
                ? Center(
                    child: Text(
                      currentUserState.error!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: size.width * 0.045,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      _buildTextField(
                        label: 'Full Name',
                        initialValue:
                            currentUserState.authEntity?.fullname ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Email',
                        initialValue: currentUserState.authEntity?.email ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Phone',
                        initialValue:
                            currentUserState.authEntity?.phone.toString() ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Username',
                        initialValue:
                            currentUserState.authEntity?.username ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Age',
                        initialValue:
                            currentUserState.authEntity?.age.toString() ?? '',
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(context, ref);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFD29062), // Update button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Save'),
          content: const Text('Are you sure you want to save changes?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _saveChanges(context, ref); // Save changes
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges(BuildContext context, WidgetRef ref) {
    // Implement the save logic here
    // After saving the changes, show a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Changes saved successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xFFD29062), // Label text color
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFD29062)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFD29062)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFD29062)),
        ),
      ),
    );
  }
}
