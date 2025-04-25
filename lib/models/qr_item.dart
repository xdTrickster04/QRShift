class QRItem {
  final String link;
  final DateTime createdAt;

  QRItem({required this.link, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'link': link,
    'createdAt': createdAt.toIso8601String(),
  };

  factory QRItem.fromJson(Map<String, dynamic> json) => QRItem(
    link: json['link'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
