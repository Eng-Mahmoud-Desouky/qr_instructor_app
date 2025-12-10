import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_instructor_app/features/auth/presentation/cubit/auth_cubit.dart';

class DashboardScreen extends StatelessWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Attendance System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[100],
      child: ListView(
        children: [
          _SidebarItem(
            icon: Icons.class_,
            label: 'My Courses',
            onTap: () => context.go('/dashboard/courses'),
            isSelected: GoRouterState.of(
              context,
            ).uri.toString().startsWith('/dashboard/courses'),
          ),
          // Add more items here
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }
}
