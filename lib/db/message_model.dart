class FCMessage{
  final int? messageId;
  final String title;
  final String body;
  FCMessage({this.messageId, required this.title, required this.body});

  Map<String,dynamic> toJson()=>{
    'messageId':messageId,
    'title':title,
    'body':body
  };
}
