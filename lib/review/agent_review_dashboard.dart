import 'package:flutter/material.dart';

const royalBlue = Color(0xFF073B67);
const lightCyan = Color(0xFF76BED2);

/// This dashboard is a product-review simulator, not a banking application.
class AgentReviewDashboard extends StatefulWidget {
  const AgentReviewDashboard({super.key, this.onExit});
  final VoidCallback? onExit;
  @override
  State<AgentReviewDashboard> createState() => _AgentReviewDashboardState();
}

class _AgentReviewDashboardState extends State<AgentReviewDashboard> {
  int tab = 0;
  bool hideBalance = false;
  final activity = <String>[];
  String selectedMethod = 'IDC Number + Passcode';

  void action(String title) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          20, 12, 20, MediaQuery.viewInsetsOf(context).bottom + 24),
        child: _AgentActionSheet(
          title: title,
          method: selectedMethod,
          onComplete: (description) {
            setState(() => activity.insert(0, '$description • DEMO'));
            Navigator.pop(context);
            ScaffoldMessenger.of(this.context).showSnackBar(
              const SnackBar(content: Text('Demo completed locally. No wallet or ledger was changed.')));
          },
        ),
      ),
    );
  }

  Widget tile(String label, IconData icon, {bool emphasized = false}) => Card(
    color: emphasized ? const Color(0xFFE6F5FB) : Colors.white,
    child: InkWell(
      onTap: () => action(label),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: emphasized ? 32 : 28, color: royalBlue),
          const SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13,
              fontWeight: emphasized ? FontWeight.bold : FontWeight.w600)),
        ]),
      ),
    ),
  );

  Widget home() => ListView(padding: const EdgeInsets.all(16), children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('Agent dashboard', style: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: royalBlue)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE7B2),
          borderRadius: BorderRadius.circular(18)),
        child: const Text('DEMO', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ]),
    const SizedBox(height: 6),
    const Text('STATUS: REVIEW MODE — not connected to agent authentication'),
    const SizedBox(height: 18),
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(colors: [
          royalBlue, Color(0xFF3B82A0)])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Agent wallet balance', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        Row(children: [
          Text(hideBalance ? '₦•••••' : '₦0.00',
            style: const TextStyle(fontSize: 32,
              color: Colors.white, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () => setState(() => hideBalance = !hideBalance),
            icon: Icon(hideBalance ? Icons.visibility_off : Icons.visibility,
              color: Colors.white)),
        ]),
        const Text('Illustrative amount — no real funds',
          style: TextStyle(color: Colors.white70)),
      ]),
    ),
    const SizedBox(height: 20),
    Row(children: [
      Expanded(child: tile('Scan QR', Icons.qr_code_scanner)),
      Expanded(child: tile('My QR', Icons.qr_code)),
    ]),
    const SizedBox(height: 14),
    const Text('Transfers', style: TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: royalBlue)),
    Row(children: [
      Expanded(child: tile('ID-CASH to ID-CASH', Icons.swap_horiz)),
      Expanded(child: tile('ID-CASH to Bank', Icons.account_balance)),
    ]),
    const SizedBox(height: 16),
    const Text('Customer services', style: TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: royalBlue)),
    Row(children: [
      Expanded(child: tile('Withdraw', Icons.payments_outlined, emphasized: true)),
      Expanded(child: tile('Balance Inquiry', Icons.account_balance_wallet_outlined,
        emphasized: true)),
    ]),
    const SizedBox(height: 14),
    const Text('More services', style: TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: royalBlue)),
    GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        tile('Airtime', Icons.phone_android),
        tile('Data', Icons.wifi),
        tile('Bills', Icons.receipt_long),
      ],
    ),
    const SizedBox(height: 10),
    const ListTile(
      leading: Icon(Icons.privacy_tip_outlined, color: royalBlue),
      title: Text('Cash withdrawal security'),
      subtitle: Text(
        'Customer verification, amount preparation, and PIN authorization are simulated here.'),
    ),
  ]);

  Widget history() => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Agent activity', style: TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: royalBlue)),
    const SizedBox(height: 6),
    const Text('Demo events only — no actual financial transactions.'),
    if (activity.isEmpty)
      const Card(child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('No demo activity yet.'))),
    ...activity.map((item) => ListTile(
      leading: const Icon(Icons.receipt, color: royalBlue),
      title: Text(item),
    )),
  ]);

  Widget profile() => ListView(padding: const EdgeInsets.all(20), children: [
    const CircleAvatar(radius: 40, backgroundColor: Color(0xFFDDF4FA),
      child: Icon(Icons.store, color: royalBlue, size: 44)),
    const SizedBox(height: 14),
    const Center(child: Text('ID-CASH Agent', style: TextStyle(
      color: royalBlue, fontSize: 24, fontWeight: FontWeight.bold))),
    const ListTile(title: Text('Agent status'),
      subtitle: Text('Demo account — not authenticated')),
    const ListTile(title: Text('Settlement and commission'),
      subtitle: Text('Awaiting agent backend integration')),
    ListTile(title: const Text('Security settings'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => action('Security settings')),
    ListTile(title: const Text('Help and support'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => action('Support')),
    if (widget.onExit != null)
      OutlinedButton.icon(
        onPressed: widget.onExit,
        icon: const Icon(Icons.logout),
        label: const Text('Return to welcome')),
  ]);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('ID-CASH AGENT'),
      foregroundColor: royalBlue,
      actions: [
        IconButton(onPressed: () => action('Notifications'),
          icon: const Icon(Icons.notifications_none)),
      ],
    ),
    body: IndexedStack(index: tab, children: [home(), history(), profile()]),
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (value) => setState(() => tab = value),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.history), label: 'Activity'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Me'),
      ],
    ),
  );
}

class _AgentActionSheet extends StatefulWidget {
  const _AgentActionSheet({
    required this.title, required this.method, required this.onComplete,
  });
  final String title;
  final String method;
  final ValueChanged<String> onComplete;
  @override
  State<_AgentActionSheet> createState() => _AgentActionSheetState();
}

class _AgentActionSheetState extends State<_AgentActionSheet> {
  late String method = widget.method;
  final idc = TextEditingController();
  final amount = TextEditingController();

  @override
  void dispose() {
    idc.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWithdrawal = widget.title == 'Withdraw' ||
      widget.title == 'Balance Inquiry';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.title, style: const TextStyle(
          fontSize: 22, color: royalBlue, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text('SIMULATED — no customer identity is verified, no real cash is authorized.',
          style: TextStyle(color: Color(0xFF955000), fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        if (isWithdrawal) DropdownButtonFormField<String>(
          initialValue: method,
          decoration: const InputDecoration(
            labelText: 'Customer verification method',
            border: OutlineInputBorder()),
          items: const [
            DropdownMenuItem(value: 'IDC Number + Passcode',
              child: Text('IDC Number + Passcode')),
            DropdownMenuItem(value: 'Face/3D liveness + Passcode',
              child: Text('Face/3D liveness + Passcode')),
          ],
          onChanged: (value) => setState(() => method = value ?? method),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: idc,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: isWithdrawal ? 'Customer IDC Number (sample)' :
              'Reference / recipient (sample)'),
        ),
        if (widget.title != 'Balance Inquiry') ...[
          const SizedBox(height: 12),
          TextField(
            controller: amount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixText: '₦ ',
              labelText: 'Amount (demo)'),
          ),
        ],
        const SizedBox(height: 12),
        if (isWithdrawal)
          const Text('Real flow: verify identity → temporary customer session '
            '→ select amount → customer confirms with 4-digit Transaction PIN '
            '→ close session. This screen does not execute those actions.'),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: () {
            if (idc.text.trim().isEmpty ||
                (widget.title != 'Balance Inquiry' &&
                  ((double.tryParse(amount.text) ?? 0) <= 0))) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Enter sample reference and valid amount.')));
              return;
            }
            widget.onComplete('${widget.title}: ${idc.text.trim()}');
          },
          child: const Text('Record simulated action'),
        ),
      ],
    );
  }
}
