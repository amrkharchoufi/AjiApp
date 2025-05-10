import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

/// An overlay filter widget that shows a dropdown panel on top of other content
/// Clicking "Filters" toggles the filter panel visibility
class ExpandableFilterWidget extends StatefulWidget {
  /// Callback when filters are applied
  final Function(String? city) CitySelected;
  final Function(String? city) InterestSelected;

  const ExpandableFilterWidget({
    super.key,
    required this.CitySelected, required this.InterestSelected,
  });

  @override
  State<ExpandableFilterWidget> createState() => _ExpandableFilterWidgetState();
}

class _ExpandableFilterWidgetState extends State<ExpandableFilterWidget> {
  // State for the filter panel visibility
  bool _isFilterVisible = false;

  // State for selected city and interest
  String? selectedCity;
  String? selectedInterest;

  // Global key for positioning the overlay
  final GlobalKey _filterButtonKey = GlobalKey();

  // Overlay entry
  OverlayEntry? _overlayEntry;

  // City options
  final List<String> cities = [
    'All the Country',
    'Rabat',
    'Casablanca',
    'Fes',
    'Tangier',
    'Marrakech',
    'Agadir',
  ];

  // Interest options
  final List<String> interests = [
    'Architecture',
    'History',
    'Religion',
    'Culture',
  ];

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
          right: 10, // Align with the right side like in your design
          width: MediaQuery.of(context).size.width *
              0.55, // Adjust width as needed
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
    SizeConfig().init(context);
    return GestureDetector(
      key: _filterButtonKey,
      onTap: _toggleFilterPanel,
      child: Text(
        'Filters',
        style: TextStyle(
          fontSize: SizeConfig.getBlockSizeHorizontal(6),
          fontWeight: FontWeight.bold,
          color: _isFilterVisible == false ? Colors.grey : ajired,
        ),
      ),
    );
  }

  // Expandable filter panel
  Widget _buildFilterPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: SizeConfig.getBlockSizeVertical(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // City filter section
            Text(
              'City:',
              style: TextStyle(
                fontSize: SizeConfig.getBlockSizeHorizontal(5),
                fontWeight: FontWeight.bold,
                color: ajired,
              ),
            ),
            const SizedBox(height: 8),
            ...cities.map((city) => _buildRadioOption(
                  title: city,
                  groupValue: selectedCity,
                  value: city,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                      widget.CitySelected(value);
                      _removeOverlay();
                      _isFilterVisible = false;
                    });
                  },
                )),
            const Divider(),

            // Interest filter section
            Text(
              'Interest:',
              style: TextStyle(
                fontSize: SizeConfig.getBlockSizeHorizontal(5),
                fontWeight: FontWeight.bold,
                color: ajired,
              ),
            ),
            const SizedBox(height: 8),
            ...interests.map((interest) => _buildRadioOption(
                  title: interest,
                  groupValue: selectedInterest,
                  value: interest,
                  onChanged: (value) {
                    setState(() {
                      selectedInterest = value;
                      widget.InterestSelected(value);
                      _removeOverlay();
                      _isFilterVisible = false;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }

  // Helper method to build radio option
  Widget _buildRadioOption({
    required String title,
    required String? groupValue,
    required String value,
    required Function(String?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: ajired,
                visualDensity: VisualDensity.compact,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Add a divider after each option except the last one
          if (value != cities.last || title == interests.last)
            const Divider(height: 1),
        ],
      ),
    );
  }
}
