import 'package:dart_openai/dart_openai.dart';

Future<OpenAIChatCompletionModel?> callChatGPT(String prompt) async {
  // const apiKey = "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";
  // const apiUrl = "https://api.openai.com/v1/completions";
  //
  // final headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer $apiKey'
  // };
  //
  // final body = json.encode({
  //   "model": "text-davinci-003",
  //   'prompt': prompt,
  //   'max_tokens': 500,
  // });
  //
  // try {
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: headers,
  //     body: body,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     final String result = jsonResponse['choices'][0]['text'];
  //     return result.trim();
  //   } else {
  //     print("Failed to call chatgpt api: ${response.statusCode}");
  //   }
  // } catch (e) {
  //   print(e.toString());
  // }
  // return null;
  try {
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: prompt,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    return chatCompletion;
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<Map?> getModels() async {
  // final headers = {'Authorization': 'Bearer $apiKey'};
  // final fetchedData = await http.get(
  //   Uri.parse("https://api.openai.com/v1/models"),
  //   headers: headers,
  // );
  // final modelsData = jsonDecode(fetchedData.body);
  // List<dynamic> models = modelsData['data'];
  // for (final mdl in models){
  //   print(mdl['id']);
  // }

  List<OpenAIModelModel> models = await OpenAI.instance.model.list();

  for (final mdl in models) {
    print(mdl.id);
  }
}

Future<OpenAIImageModel?> generateImage(String prompt) async {
  try {
    OpenAIImageModel image = await OpenAI.instance.image.create(
      prompt: prompt,
      n: 1,
      size: OpenAIImageSize.size512,
      responseFormat: OpenAIImageResponseFormat.url,
    );
    print(image);
    return image;
  } catch (e) {
    print(e.toString());
  }
  return null;
}
