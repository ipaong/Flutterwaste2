import 'package:flutter/material.dart';

import '../widgets/dev_placeholder_dialog.dart';
import '../widgets/glass_panel.dart';

class WasteEntryPage extends StatefulWidget {
  const WasteEntryPage({super.key});

  @override
  State<WasteEntryPage> createState() => _WasteEntryPageState();
}

class _WasteEntryPageState extends State<WasteEntryPage> {
  final List<String> _wasteTypes = const [
    'I: Special waste',
    'VI: Heavy metal waste',
    'VII: Acid waste',
    'III: Oxidizing waste',
    'IX: Petroleum products',
    'X: Oxygenated waste',
    'XIII: Incombustible solid',
    'XVI: Biological waste',
  ];

  final List<String> _hazards = const [
    'เปลวไฟ',
    'กัดกร่อน',
    'พิษร้ายแรง',
    'ตัวออกซิไดส์',
  ];

  final List<_ChemicalComponent> _components = const [
    _ChemicalComponent(name: 'Sulfuric Acid', percent: 65.0),
    _ChemicalComponent(name: 'Nitric Acid', percent: 35.0),
  ];

  String _selectedType = 'I: Special waste';
  String _unit = 'g';

  Future<void> _showDev(String actionName) {
    return showUnderDevelopmentDialog(context, actionName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ClipRect(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 390,
                    height: constraints.maxHeight,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1.5,
                          colors: [
                            Color(0xFFC8DAEE),
                            Color(0xFF8AA3BE),
                            Color(0xFF3A4D65),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(painter: _CircuitPainter()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                            child: Column(
                              children: [
                                _TopBar(onAvatarPressed: () => _showDev('โปรไฟล์')),
                                const SizedBox(height: 10),
                                _HeaderForm(onPressed: _showDev),
                                const SizedBox(height: 10),
                                _GeneralInfo(onPressed: _showDev),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _WasteTypePanel(
                                          selectedType: _selectedType,
                                          wasteTypes: _wasteTypes,
                                          onSelectType: (value) {
                                            setState(() => _selectedType = value);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            _HazardPanel(
                                              hazards: _hazards,
                                              onPressed: _showDev,
                                            ),
                                            const SizedBox(height: 10),
                                            _ComponentPanel(
                                              components: _components,
                                              onPressed: _showDev,
                                            ),
                                            const SizedBox(height: 10),
                                            _QuantityPanel(
                                              unit: _unit,
                                              onUnitChanged: (value) {
                                                setState(() => _unit = value);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _BottomActions(onPressed: _showDev),
                                const SizedBox(height: 10),
                                _BottomNav(onPressed: _showDev),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onAvatarPressed});

  final VoidCallback onAvatarPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.science_outlined, color: Color(0xFFE4EEFF), size: 30),
        const SizedBox(width: 10),
        Text(
          'LabFlow',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFFF0F5FF),
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.18),
          ),
          onPressed: onAvatarPressed,
          icon: const Icon(Icons.account_circle, size: 30),
        ),
      ],
    );
  }
}

class _HeaderForm extends StatelessWidget {
  const _HeaderForm({required this.onPressed});

  final Future<void> Function(String actionName) onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GlassPanel(
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withValues(alpha: 0.22),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                  ),
                  child: const Icon(Icons.science_outlined),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'บันทึกข้อมูลของเสียอันตราย',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF152233),
                        ),
                      ),
                      Text(
                        'Vessel Classification #WL-0021',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF273852),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => onPressed('เปิดรายละเอียด Vessel'),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              _FieldButton(
                label: 'Waste (ของเสีย)',
                onTap: () => onPressed('เลือก Waste'),
              ),
              const SizedBox(height: 8),
              _FieldButton(
                label: 'Track ID (รหัสติดตาม)',
                onTap: () => onPressed('เลือก Track ID'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GeneralInfo extends StatelessWidget {
  const _GeneralInfo({required this.onPressed});

  final Future<void> Function(String actionName) onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ข้อมูลทั่วไป',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(child: _GhostInput(text: 'Center for Scientific Instruments')),
              const SizedBox(width: 8),
              Expanded(
                child: _FieldButton(
                  label: 'ผู้รับผิดชอบ',
                  onTap: () => onPressed('เลือกผู้รับผิดชอบ'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FieldButton(
                  label: 'หมายเลขโทรศัพท์',
                  onTap: () => onPressed('เลือกหมายเลขโทรศัพท์'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(child: _GhostInput(text: 'Phone/Fax')),
              const SizedBox(width: 8),
              Expanded(
                child: _FieldButton(
                  label: 'วันที่เริ่มบรรจุ',
                  icon: Icons.calendar_month,
                  onTap: () => onPressed('เลือกวันที่เริ่มบรรจุ'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FieldButton(
                  label: 'วันที่หยุดบรรจุ',
                  icon: Icons.calendar_month,
                  onTap: () => onPressed('เลือกวันที่หยุดบรรจุ'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WasteTypePanel extends StatelessWidget {
  const _WasteTypePanel({
    required this.selectedType,
    required this.wasteTypes,
    required this.onSelectType,
  });

  final String selectedType;
  final List<String> wasteTypes;
  final ValueChanged<String> onSelectType;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'การเลือกประเภทของเสีย',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Container(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withValues(alpha: 0.22),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedType,
                isExpanded: true,
                borderRadius: BorderRadius.circular(14),
                dropdownColor: const Color(0xFFD8E4F4),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                items: wasteTypes
                    .map(
                      (type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    onSelectType(value);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withValues(alpha: 0.73),
                border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: wasteTypes.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final item = wasteTypes[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? const Color(0xFFDEE6F1)
                          : const Color(0xFFF1F5FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(item),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HazardPanel extends StatelessWidget {
  const _HazardPanel({required this.hazards, required this.onPressed});

  final List<String> hazards;
  final Future<void> Function(String actionName) onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'การระบุอันตราย',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: hazards
                  .map(
                    (hazard) => InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => onPressed('เลือกอันตราย: $hazard'),
                      child: Container(
                        width: 82,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFF2E3B4F).withValues(alpha: 0.35),
                          border: Border.all(
                            color: const Color(0xFF8CF2D2).withValues(alpha: 0.7),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.warning_amber_rounded, size: 20),
                            const SizedBox(height: 4),
                            Text(
                              hazard,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF1B2B42),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 6),
            const _GhostInput(text: 'อื่นๆ (ระบุ)'),
          ],
        ),
      ),
    );
  }
}

class _ComponentPanel extends StatelessWidget {
  const _ComponentPanel({required this.components, required this.onPressed});

  final List<_ChemicalComponent> components;
  final Future<void> Function(String actionName) onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ส่วนประกอบทางเคมี',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ...components.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Expanded(child: _GhostInput(text: item.name)),
                    const SizedBox(width: 6),
                    Container(
                      width: 76,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      child: Text('${item.percent.toStringAsFixed(1)} %'),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => onPressed('เพิ่มสารเคมี'),
              child: const Text('+ Add Component'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityPanel extends StatelessWidget {
  const _QuantityPanel({required this.unit, required this.onUnitChanged});

  final String unit;
  final ValueChanged<String> onUnitChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ปริมาณทั้งหมด',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Quantity:'),
                const SizedBox(width: 6),
                const Expanded(child: _GhostInput(text: '5.2')),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: unit,
                        borderRadius: BorderRadius.circular(12),
                        isExpanded: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        items: const [
                          DropdownMenuItem(value: 'g', child: Text('g')),
                          DropdownMenuItem(value: 'L', child: Text('L')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            onUnitChanged(value);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.onPressed});

  final Future<void> Function(String actionName) onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => onPressed('สร้างฉลาก'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.75)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              minimumSize: const Size.fromHeight(52),
            ),
            child: const Text('สร้างฉลาก'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FilledButton(
            onPressed: () => onPressed('บันทึกข้อมูล'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFD6E5FA),
              foregroundColor: const Color(0xFF1A2A3D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              minimumSize: const Size.fromHeight(52),
            ),
            child: const Text('บันทึก'),
          ),
        ),
      ],
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.onPressed});

  final Future<void> Function(String actionName) onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.inventory_2_outlined, label: 'STOCK', onTap: () => onPressed('STOCK')),
          _NavItem(icon: Icons.delete_sweep_outlined, label: 'DISPOSE', onTap: () => onPressed('DISPOSE')),
          _NavItem(icon: Icons.shield_outlined, label: 'SAFETY', onTap: () => onPressed('SAFETY')),
          _NavItem(icon: Icons.description_outlined, label: 'LOGS', onTap: () => onPressed('LOGS')),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: 0.88)),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.88),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GhostInput extends StatelessWidget {
  const _GhostInput({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withValues(alpha: 0.3),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF24344C),
        ),
      ),
    );
  }
}

class _FieldButton extends StatelessWidget {
  const _FieldButton({required this.label, required this.onTap, this.icon});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withValues(alpha: 0.2),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEFF5FF),
                ),
              ),
            ),
            if (icon != null) Icon(icon, size: 16, color: const Color(0xFFEFF5FF)),
          ],
        ),
      ),
    );
  }
}

class _ChemicalComponent {
  const _ChemicalComponent({required this.name, required this.percent});

  final String name;
  final double percent;
}

class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.2)
      ..lineTo(size.width * 0.18, size.height * 0.45)
      ..lineTo(size.width * 0.44, size.height * 0.45)
      ..lineTo(size.width * 0.44, size.height * 0.62)
      ..lineTo(size.width * 0.8, size.height * 0.62);

    final path2 = Path()
      ..moveTo(size.width * 0.83, size.height * 0.1)
      ..lineTo(size.width * 0.83, size.height * 0.45)
      ..lineTo(size.width * 0.72, size.height * 0.45)
      ..lineTo(size.width * 0.72, size.height * 0.82);

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);

    final nodePaint = Paint()..color = const Color(0xFFB8FFF8).withValues(alpha: 0.45);
    for (final offset in <Offset>[
      Offset(size.width * 0.44, size.height * 0.45),
      Offset(size.width * 0.83, size.height * 0.45),
      Offset(size.width * 0.72, size.height * 0.82),
    ]) {
      canvas.drawCircle(offset, 2.8, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
