import 'package:flutter/material.dart';
import 'package:infoboxx/model/Lead.dart';
import 'package:infoboxx/ui/cards/lead_card.dart';

class LeadsFragmentScreen extends StatelessWidget {
  const LeadsFragmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leads = [
      Lead(
        name: "John Doe",
        phone: "+233 24 123 4567",
        email: "john@example.com",
        status: "New",
        source: "Facebook",
        priority: "High",
        lastContacted: "2 days ago",
      ),
      Lead(
        name: "Jane Smith",
        phone: "+233 20 987 6543",
        email: "jane@example.com",
        status: "Qualified",
        source: "Website",
        priority: "Medium",
        lastContacted: "Yesterday",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leads"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: leads.length,
        itemBuilder: (context, index) {
          final lead = leads[index];

          return LeadCard(
            name: lead.name,
            phone: lead.phone,
            email: lead.email,
            status: lead.status,
            source: lead.source,
            priority: lead.priority,
            lastContacted: lead.lastContacted,

            onTap: () {
              print("Open ${lead.name}");
            },

            onCall: () {
              print("Call ${lead.phone}");
            },

            onWhatsapp: () {
              print("WhatsApp ${lead.phone}");
            },

            onEmail: () {
              print("Email ${lead.email}");
            },

            onNotes: () {
              print("Notes for ${lead.name}");
            },
          );
        },
      ),
    );
  }
}
