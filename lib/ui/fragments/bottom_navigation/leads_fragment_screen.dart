import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/model/Lead.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/cards/lead_card.dart';
import 'package:infoboxx/ui/components/custom_refresh_indicator.dart';
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
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await userService.getLeads();
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
