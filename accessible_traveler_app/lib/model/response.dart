class Response {

  final String data;
  final String content;

  Response({required this.data, required this.content});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      data: json['data'] ?? '',
      content: json['content'] ?? '',
    );
  }

}