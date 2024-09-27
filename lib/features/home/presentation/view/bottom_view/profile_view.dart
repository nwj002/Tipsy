import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/profilelist/presentaion/view/edit_profile_view.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cureent_user_viewmodel.dart';
import 'package:liquor_ordering_system/features/orders/presentation/view/order_view.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(currentUserViewModelProvider.notifier).initialize());
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/pfp.jpg'),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 15,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _getGreeting(),
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                currentUserState.isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : currentUserState.error != null
                        ? Text(
                            currentUserState.error!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: size.width * 0.045,
                            ),
                          )
                        : Text(
                            currentUserState.authEntity?.fullname ??
                                'Username not fetched',
                            style: TextStyle(
                              fontSize: size.width * 0.06,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
              ],
            ),
            const SizedBox(height: 32),

            // Profile Options Section
            Column(
              children: [
                ProfileOption(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Order',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ProfileOption(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Handle notification toggle
                    },
                  ),
                ),
                const SizedBox(height: 8),
                ProfileOption(
                  icon: Icons.edit_outlined,
                  title: 'Edit Profile',
                  onTap: () {
                    // Handle Edit Profile tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ProfileOption(
                  icon: Icons.payment_outlined,
                  title: 'Payment',
                  onTap: () {
                    // Handle Payment tap
                  },
                ),
                const SizedBox(height: 8),
                ProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help',
                  onTap: () {
                    // Handle Help tap
                  },
                ),
                const SizedBox(height: 8),
                ProfileOption(
                  icon: Icons.logout_outlined,
                  title: 'Log Out',
                  onTap: () {
                    // Handle Log Out tap and ask are you sure want to logout
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Logout'),
                              onPressed: () {
                                ref
                                    .read(currentUserViewModelProvider.notifier)
                                    .logout();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Profile Option Widget
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            if (trailing != null) trailing!,
            if (trailing == null)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black54,
              ),
          ],
        ),
      ),
    );
  }
}
