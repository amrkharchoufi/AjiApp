import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/services/tourisme_service/controller/tourisme_binding.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitMorrocoView extends GetView<TourismeController> {
  const VisitMorrocoView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize binding
    TourismeBinding().dependencies();

    ScreenSize.init(context);
    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const MyappbarWidget(title: "Visit Morocco"),
                  Column(
                    children: [
                      // Filter section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.height / 60,
                          vertical: ScreenSize.height / 80,
                        ),
                        child: FilterChipsRow(),
                      ),
                      // Dynamic content (city view, all view, etc.)
                      Obx(() => controller.custom.value),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height / 60),
                ],
              ),
            ),
            // Fixed app bar at the top
            const MyappbarWidget(title: "Visit Morocco"),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FilterChipsRow extends GetView<TourismeController> {
  FilterChipsRow({super.key});

  final LayerLink _cityLayerLink = LayerLink();
  final LayerLink _interestLayerLink = LayerLink();
  final RxBool _isCityOpen = false.obs;
  final RxBool _isInterestOpen = false.obs;
  OverlayEntry? _cityOverlay;
  OverlayEntry? _interestOverlay;

  void _removeOverlays() {
    _cityOverlay?.remove();
    _cityOverlay = null;
    _interestOverlay?.remove();
    _interestOverlay = null;
    _isCityOpen.value = false;
    _isInterestOpen.value = false;
  }

  void _toggleCityDropdown(BuildContext context) {
    if (_isInterestOpen.value) {
      _interestOverlay?.remove();
      _interestOverlay = null;
      _isInterestOpen.value = false;
    }

    if (_isCityOpen.value) {
      _removeOverlays();
    } else {
      _cityOverlay = _createCityOverlay(context);
      Overlay.of(context).insert(_cityOverlay!);
      _isCityOpen.value = true;
    }
  }

  void _toggleInterestDropdown(BuildContext context) {
    if (_isCityOpen.value) {
      _cityOverlay?.remove();
      _cityOverlay = null;
      _isCityOpen.value = false;
    }

    if (_isInterestOpen.value) {
      _removeOverlays();
    } else {
      _interestOverlay = _createInterestOverlay(context);
      Overlay.of(context).insert(_interestOverlay!);
      _isInterestOpen.value = true;
    }
  }

  OverlayEntry _createCityOverlay(BuildContext context) {
    final cities = controller.cityNames.toList()..sort();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removeOverlays,
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _cityLayerLink,
              showWhenUnlinked: false,
              offset: Offset(0, 45),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      final isSelected = controller.selectedCity.value == city;
                      return InkWell(
                        onTap: () {
                          controller.filterByCity(city);
                          _removeOverlays();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                // ignore: deprecated_member_use
                                ? ajired.withOpacity(0.1)
                                : Colors.transparent,
                            border: index != cities.length - 1
                                ? Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200))
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: isSelected ? ajired : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                city,
                                style: TextStyle(
                                  color: isSelected ? ajired : Colors.black87,
                                  fontSize: ScreenSize.width / 30,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                              if (isSelected) ...[
                                const Spacer(),
                                Icon(Icons.check, color: ajired, size: 16),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry _createInterestOverlay(BuildContext context) {
    final interests = controller.interestTypes;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removeOverlays,
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _interestLayerLink,
              showWhenUnlinked: false,
              offset: Offset(0, 45),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: interests.length,
                    itemBuilder: (context, index) {
                      final interest = interests[index];
                      final isSelected =
                          controller.selectedInterests.contains(interest);
                      final isAll = interest == "All";
                      return InkWell(
                        onTap: () {
                          controller.selectedInterests.clear();
                          if (!isAll) {
                            controller.toggleInterest(interest);
                          }
                          _removeOverlays();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ||
                                    (isAll &&
                                        controller.selectedInterests.isEmpty)
                                // ignore: deprecated_member_use
                                ? ajired.withOpacity(0.1)
                                : Colors.transparent,
                            border: index != interests.length - 1
                                ? Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200))
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isAll ? Icons.clear_all : Icons.interests,
                                size: 16,
                                color: (isSelected ||
                                        (isAll &&
                                            controller
                                                .selectedInterests.isEmpty))
                                    ? ajired
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                interest,
                                style: TextStyle(
                                  color: (isSelected ||
                                          (isAll &&
                                              controller
                                                  .selectedInterests.isEmpty))
                                      ? ajired
                                      : Colors.black87,
                                  fontSize: ScreenSize.width / 30,
                                  fontWeight: (isSelected ||
                                          (isAll &&
                                              controller
                                                  .selectedInterests.isEmpty))
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                              if (isSelected ||
                                  (isAll &&
                                      controller
                                          .selectedInterests.isEmpty)) ...[
                                const Spacer(),
                                Icon(Icons.check, color: ajired, size: 16),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          // City Filter Chip
          Expanded(
            child: CompositedTransformTarget(
              link: _cityLayerLink,
              child: GestureDetector(
                onTap: () => _toggleCityDropdown(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _isCityOpen.value ? ajired : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: ajired),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: _isCityOpen.value ? Colors.white : ajired,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.selectedCity.value,
                            style: TextStyle(
                              color: _isCityOpen.value ? Colors.white : ajired,
                              fontSize: ScreenSize.width / 30,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        _isCityOpen.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: _isCityOpen.value ? Colors.white : ajired,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Interest Filter Chip
          Expanded(
            child: CompositedTransformTarget(
              link: _interestLayerLink,
              child: GestureDetector(
                onTap: () => _toggleInterestDropdown(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _isInterestOpen.value ? ajired : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: ajired),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            controller.selectedInterests.isEmpty
                                ? Icons.clear_all
                                : Icons.interests,
                            size: 16,
                            color:
                                _isInterestOpen.value ? Colors.white : ajired,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.selectedInterests.isEmpty
                                ? 'All Interests'
                                : controller.selectedInterests.first,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  _isInterestOpen.value ? Colors.white : ajired,
                              fontSize: ScreenSize.width / 30,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        _isInterestOpen.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: _isInterestOpen.value ? Colors.white : ajired,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
