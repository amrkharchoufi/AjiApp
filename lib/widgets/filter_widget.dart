import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandableFilterWidget extends StatefulWidget {
  /// Callback when filters are applied
  final Function(String? city) CitySelected;
  final Function(String? city) InterestSelected;

  const ExpandableFilterWidget({
    super.key,
    required this.CitySelected,
    required this.InterestSelected,
  });

  @override
  State<ExpandableFilterWidget> createState() => _ExpandableFilterWidgetState();
}

class _ExpandableFilterWidgetState extends State<ExpandableFilterWidget> {
  // State for the filter panel visibility
  bool _isFilterVisible = false;

  // Global key for positioning the overlay
  final GlobalKey _filterButtonKey = GlobalKey();

  // Overlay entry
  OverlayEntry? _overlayEntry;

  // Controller to get dynamic data
  late TourismeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<TourismeController>();
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleFilterPanel() {
    if (_isFilterVisible) {
      _removeOverlay();
    } else {
      _showOverlay();
    }

    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    // Get the render box of the filter button
    final RenderBox? renderBox =
        _filterButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    // Calculate the position for the overlay
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    // Create the overlay entry
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position.dy + size.height,
          right: 10,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12),
            child: _buildFilterPanel(),
          ),
        );
      },
    );

    // Insert the overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return GestureDetector(
      key: _filterButtonKey,
      onTap: _toggleFilterPanel,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              _isFilterVisible ? ajired.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isFilterVisible ? ajired : Colors.grey,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_list,
              color: _isFilterVisible ? ajired : Colors.grey,
              size: ScreenSize.width / 22,
            ),
            SizedBox(width: 4),
            Text(
              'Filters',
              style: TextStyle(
                fontSize: ScreenSize.width / 25,
                fontWeight: FontWeight.w500,
                color: _isFilterVisible ? ajired : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Expandable filter panel
  Widget _buildFilterPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final cities = _controller.cityNames.toList()..sort();
        final interests = _controller.interestTypes;
        final selectedCity = _controller.selectedCity.value;
        final selectedInterests = _controller.selectedInterests;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // City filter section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'City',
                  style: TextStyle(
                    fontSize: ScreenSize.width / 24,
                    fontWeight: FontWeight.bold,
                    color: ajired,
                  ),
                ),
                if (selectedCity != "All the Country")
                  TextButton(
                    onPressed: () {
                      widget.CitySelected("All the Country");
                      _removeOverlay();
                      setState(() {
                        _isFilterVisible = false;
                      });
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: ScreenSize.width / 30,
                        color: ajired,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: cities
                  .map((city) => ChoiceChip(
                        label: Text(city),
                        selected: selectedCity == city,
                        onSelected: (selected) {
                          if (selected) {
                            widget.CitySelected(city);
                            _removeOverlay();
                            setState(() {
                              _isFilterVisible = false;
                            });
                          }
                        },
                        selectedColor: ajired.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: selectedCity == city ? ajired : Colors.black87,
                          fontSize: ScreenSize.width / 30,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Interest filter section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Interests',
                  style: TextStyle(
                    fontSize: ScreenSize.width / 24,
                    fontWeight: FontWeight.bold,
                    color: ajired,
                  ),
                ),
                if (selectedInterests.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      _controller.clearInterests();
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: ScreenSize.width / 30,
                        color: ajired,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: interests
                  .map((interest) => FilterChip(
                        label: Text(interest),
                        selected: selectedInterests.contains(interest),
                        onSelected: (selected) {
                          _controller.toggleInterest(interest);
                        },
                        selectedColor: ajired.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: selectedInterests.contains(interest)
                              ? ajired
                              : Colors.black87,
                          fontSize: ScreenSize.width / 30,
                        ),
                        checkmarkColor: ajired,
                      ))
                  .toList(),
            ),
          ],
        );
      }),
    );
  }
}
