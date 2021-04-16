
import 'package:http/http.dart' as http;
class API{
  static final String _url = "https://api.themoviedb.org/3/";
  var token;

  postData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        Uri.parse(fullUrl)
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
    );
  }
}