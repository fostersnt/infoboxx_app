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
      Lead(
        name: "Michael Brown",
        phone: "+233 55 321 7890",
        email: "michael.brown@example.com",
        status: "Contacted",
        source: "Referral",
        priority: "Low",
        lastContacted: "5 hours ago",
      ),
      Lead(
        name: "Sarah Johnson",
        phone: "+233 54 765 4321",
        email: "sarah.johnson@example.com",
        status: "Closed",
        source: "Instagram",
        priority: "High",
        lastContacted: "1 week ago",
      ),
      Lead(
        name: "Daniel Wilson",
        phone: "+233 27 456 1122",
        email: "daniel.wilson@example.com",
        status: "New",
        source: "Google Ads",
        priority: "Medium",
        lastContacted: "Today",
      ),
      Lead(
        name: "Emily Davis",
        phone: "+233 59 876 3344",
        email: "emily.davis@example.com",
        status: "Qualified",
        source: "LinkedIn",
        priority: "High",
        lastContacted: "3 days ago",
      ),
      Lead(
        name: "Kevin Anderson",
        phone: "+233 50 654 7788",
        email: "kevin.anderson@example.com",
        status: "Contacted",
        source: "WhatsApp",
        priority: "Low",
        lastContacted: "6 hours ago",
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Leads")),
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
