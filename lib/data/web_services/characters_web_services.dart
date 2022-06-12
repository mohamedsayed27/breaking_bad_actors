import 'package:dio/dio.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    // dio = Dio(BaseOptions(
    //   baseUrl: baseUrl,
    //   connectTimeout: 20*1000,
    //   receiveTimeout: 20*1000,
    // ));

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      // print(response.data.toString());
      return response.data;
    } catch (e) {
      return [];
    }
  }


  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio.get('quote',queryParameters: {'author' : charName});
      // print(response.data.toString());
      return response.data;
    } catch (e) {
      return [];
    }
  }


  // Future<List<dynamic>> getQuotes(String charName) async {
  //   try {
  //     Response response = await dio.get('quote',queryParameters: {'author': charName});
  //     // print(response.data.toString());
  //     return response.data;
  //   } catch (e) {
  //     return [];
  //   }
  // }

// Future<Response> getCharacters()async{
//     return dio.get('characters');
// }
}
