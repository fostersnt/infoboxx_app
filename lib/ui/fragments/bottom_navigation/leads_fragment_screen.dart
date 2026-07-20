import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/model/Lead.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/lead_card.dart';
import 'package:infoboxx/ui/components/empty_leads_view.dart';
import 'package:infoboxx/ui/components/pagination_buttons.dart';
import 'package:infoboxx/util/app_colors.dart';

class LeadsFragmentScreen extends StatefulWidget {
  const LeadsFragmentScreen({super.key});

  @override
  State<LeadsFragmentScreen> createState() => _LeadsFragmentScreenState();
}

class _LeadsFragmentScreenState extends State<LeadsFragmentScreen> {
  final userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    var canSearch = false.obs;
    final leads = userService.leads;

    // final leads = [
    //   Lead(
    //     name: "John Doe",
    //     phone: "+233 24 123 4567",
    //     email: "john@example.com",
    //     status: "New",
    //     source: "Facebook",
    //     priority: "High",
    //     lastContacted: "2 days ago",
    //   ),
    //   Lead(
    //     name: "Jane Smith",
    //     phone: "+233 20 987 6543",
    //     email: "jane@example.com",
    //     status: "Qualified",
    //     source: "Website",
    //     priority: "Medium",
    //     lastContacted: "Yesterday",
    //   ),
    //   Lead(
    //     name: "Michael Brown",
    //     phone: "+233 55 321 7890",
    //     email: "michael.brown@example.com",
    //     status: "Contacted",
    //     source: "Referral",
    //     priority: "Low",
    //     lastContacted: "5 hours ago",
    //   ),
    //   Lead(
    //     name: "Sarah Johnson",
    //     phone: "+233 54 765 4321",
    //     email: "sarah.johnson@example.com",
    //     status: "Closed",
    //     source: "Instagram",
    //     priority: "High",
    //     lastContacted: "1 week ago",
    //   ),
    //   Lead(
    //     name: "Daniel Wilson",
    //     phone: "+233 27 456 1122",
    //     email: "daniel.wilson@example.com",
    //     status: "New",
    //     source: "Google Ads",
    //     priority: "Medium",
    //     lastContacted: "Today",
    //   ),
    //   Lead(
    //     name: "Emily Davis",
    //     phone: "+233 59 876 3344",
    //     email: "emily.davis@example.com",
    //     status: "Qualified",
    //     source: "LinkedIn",
    //     priority: "High",
    //     lastContacted: "3 days ago",
    //   ),
    //   Lead(
    //     name: "Kevin Anderson",
    //     phone: "+233 50 654 7788",
    //     email: "kevin.anderson@example.com",
    //     status: "Contacted",
    //     source: "WhatsApp",
    //     priority: "Low",
    //     lastContacted: "6 hours ago",
    //   ),
    // ];
    return Scaffold(
      backgroundColor: AppColors.whitePure,
      appBar: AppBar(
        // title: const Text("Leads"),
        backgroundColor: AppColors.whitePure,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Row(
              children: [
                InkWell(
                  child: Obx(() {
                    return Icon(
                      canSearch.value == true ? Icons.search_off : Icons.search,
                    );
                  }),
                  onTap: () {
                    canSearch.value = !canSearch.value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return userService.getLeads();
        },
        child: Column(
          children: [
            Obx(() {
              return canSearch.value == true
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8FAFC),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: TextField(
                        controller: searchController,
                        // onChanged: (true),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff0F172A),
                        ),
                        decoration: InputDecoration(
                          hintText: "Search here...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),

                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey.shade600,
                          ),

                          suffixIcon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: true
                                ? IconButton(
                                    key: const ValueKey("clear"),
                                    onPressed: () {},
                                    icon: const Icon(Icons.close_rounded),
                                    color: Colors.grey.shade600,
                                  )
                                : const SizedBox(key: ValueKey("empty")),
                          ),

                          border: InputBorder.none,

                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            Obx(() {
              if (leads.isEmpty) {
                return EmptyLeadsView(onRefresh: () => userService.getLeads());
              } else {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: leads.length,
                    itemBuilder: (context, index) {
                      final lead = leads[index];
                      String name = '${lead.firstName} ${lead.lastName}';

                      return LeadCard(
                        name: name,
                        phone: lead.msisdn,
                        email: lead.email,
                        status: lead.status,
                        source: lead.comment,
                        lastContacted: lead.createdAt,
                        lastConverted: lead.convertedAt,

                        onTap: () {
                          print("Open ${name}");
                        },

                        onCall: () {
                          print("Call ${lead.msisdn}");
                        },

                        onWhatsapp: () {
                          print("WhatsApp ${lead.msisdn}");
                        },

                        onEmail: () {
                          print("Email ${lead.email}");
                        },

                        onNotes: () {
                          print("Notes for ${name}");
                        },
                      );
                    },
                  ),
                );
              }
            }),
            // LeadPagination(
            //   currentPage: 2,
            //   totalPages: 15,
            //
            //   onPrevious: () {
            //   },
            //
            //   onNext: () {
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
