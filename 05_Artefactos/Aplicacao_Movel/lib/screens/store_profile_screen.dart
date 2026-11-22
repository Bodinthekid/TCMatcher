import 'package:flutter/material.dart';
import '../models/store_profile_data.dart';
import '../services/auth_services.dart';
import '../theme/app_colors.dart';
import '../widgets/store/profile/store_menu_drawer.dart';
import '../widgets/store/profile/store_profile_content_tabs.dart';
import '../widgets/store/profile/store_profile_header_card.dart';
import 'edit_store_profile_screen.dart';

class StoreProfileScreen extends StatefulWidget {
  final StoreProfileData? storeData;
  final bool showBackButton;

  const StoreProfileScreen({
    super.key,
    this.storeData,
    this.showBackButton = false,
  });

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  static StoreProfileData? _savedStore;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StoreProfileData _store;

  @override
  void initState() {
    super.initState();

    if (widget.storeData != null) {
      _store = widget.storeData!;
    } else if (_savedStore != null) {
      _store = _savedStore!;
    } else {
      final loggedName = AuthService.currentUserName;
      final base = StoreProfileData.defaultStore;
      _store = (loggedName != null && loggedName.trim().isNotEmpty)
          ? base.copyWith(
              name: loggedName,
              username: loggedName.toLowerCase().replaceAll(' ', ''),
            )
          : base;
      _savedStore = _store;
    }
  }

  void _handleStoreEdited(EditStoreProfileResult result) {
    setState(() {
      _store = _store.copyWith(
        name: result.name,
        username: result.username,
        bio: result.bio,
        address: result.address,
        openingHours: result.openingHours,
        phone: result.phone,
        avatarUrl: result.avatarUrl,
        bannerUrl: result.bannerUrl,
      );
      if (!widget.showBackButton) {
        _savedStore = _store;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditable = !widget.showBackButton;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: widget.showBackButton
          ? null
          : StoreMenuDrawer(
              storeName: _store.name,
              avatarUrl: _store.avatarUrl,
            ),
      body: SafeArea(
        top: widget.showBackButton,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StoreProfileHeaderCard(
                storeData: _store,
                isEditable: isEditable,
                showBackButton: widget.showBackButton,
                onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                onStoreEdited: _handleStoreEdited,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StoreProfileContentTabs(storeData: _store),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}