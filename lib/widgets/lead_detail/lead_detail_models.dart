enum LeadFileType { pdf, audio, image, other }

class LeadFile {
  final String name;
  final String meta;
  final LeadFileType type;

  const LeadFile({required this.name, required this.meta, required this.type});
}

class LeadNote {
  final String agent;
  final String time;
  final String text;
  final bool isPinned;

  const LeadNote({
    required this.agent,
    required this.time,
    required this.text,
    this.isPinned = false,
  });
}

enum LeadFollowUpType { call, whatsApp, email, sms, meeting }

enum LeadFollowUpStatus {
  connected,
  pending,
  newStatus,
  followUp,
  closed,
  contacted,
}

class LeadActivity {
  final String toStatus;
  final String? fromStatus;
  final String agent;
  final String time;

  const LeadActivity({
    required this.toStatus,
    this.fromStatus,
    required this.agent,
    required this.time,
  });
}

class LeadFollowUp {
  final LeadFollowUpType type;
  final LeadFollowUpStatus status;
  final String time;
  final String agent;
  final String note;
  final LeadFile? attachment;

  const LeadFollowUp({
    required this.type,
    required this.status,
    required this.time,
    required this.agent,
    required this.note,
    this.attachment,
  });
}
