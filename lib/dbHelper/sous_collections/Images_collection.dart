class Images {
  List<Messages> messages;

  Images({ required this.messages});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      messages: (json['Messages'] ).map((messageJson) => Messages.fromJson(messageJson)).toList(),
    );
  }
}

class Messages {
  List<String> contenu_message;

  Messages({required this.contenu_message});

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      contenu_message: List<String>.from(json as Iterable),
    );
  }
}
