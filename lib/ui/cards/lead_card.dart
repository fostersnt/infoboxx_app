import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LeadCard extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String status;
  final String source;
  final String lastContacted;
  final String lastConverted;

  final VoidCallback? onTap;
  final VoidCallback? onCall;
  final VoidCallback? onWhatsapp;
  final VoidCallback? onEmail;
  final VoidCallback? onNotes;

  const LeadCard({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.source,
    required this.lastContacted,
    required this.lastConverted,
    this.onTap,
    this.onCall,
    this.onWhatsapp,
    this.onEmail,
    this.onNotes,
  });

  Color get statusColor {
    switch (status.toLowerCase()) {
      case "new":
        return Colors.blue;

      case "contacted":
        return Colors.orange;

      case "qualified":
        return Colors.green;

      case "closed":
        return Colors.grey;

      default:
        return Colors.purple;
    }
  }

  // Color get priorityColor {
  //   switch (priority.toLowerCase()) {
  //     case "high":
  //       return Colors.red;
  //
  //     case "medium":
  //       return Colors.orange;
  //
  //     default:
  //       return Colors.green;
  //   }
  // }

  String get initials {
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Widget chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget action(
      IconData icon,
      Color color,
      VoidCallback? onPressed,
      ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: color.withOpacity(.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 190,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(22),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      /// Header
                      Row(
                        children: [

                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  statusColor,
                                  statusColor.withOpacity(.6),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "Last converted • $lastConverted",
                                  style: TextStyle(
                                    color:
                                    Colors.grey.shade600,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 18),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [

                          chip(status, statusColor),

                          chip(source, Colors.indigo),

                          // chip(priority, priorityColor),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [

                          const Icon(Icons.phone,
                              size: 18),

                          const SizedBox(width: 8),

                          Expanded(child: Text(phone))
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [

                          const Icon(Icons.email_outlined,
                              size: 18),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(
                              email,
                              overflow:
                              TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 22),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [

                          action(
                            Icons.call,
                            Colors.green,
                            onCall,
                          ),

                          action(
                            Icons.chat,
                            Colors.teal,
                            onWhatsapp,
                          ),

                          action(
                            Icons.email,
                            Colors.blue,
                            onEmail,
                          ),

                          action(
                            Icons.sticky_note_2,
                            Colors.deepPurple,
                            onNotes,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: 500.ms)
        .slideY(begin: .2);
  }
}