
// library for I/O and network sockets
import 'dart:io';

// library for converting charactersets
import 'dart:convert';

// import 'package:http/http.dart' as http;
// https://pub.dartlang.org/packages/http
// Another library to perform http requests
//

main() {
  print ("This is the beginning");

   //var api_url = "https://fastapi.metacpan.org/v1";
   var api_url = "https://fastapi.metacpan.org/v1/modules/_search?";
   var hc = new HttpClient();
   print( api_url);
   print(Uri.parse(api_url));

   // hc.post(api_url, body: JSON.encode({'module': "Data::Dumper" }) )
   //   .then( (HttpClientRequest request)  {
   //        print ("Response body: ${response.body}");
   //   });

   hc.getUrl( Uri.parse(api_url) )
     .then( (HttpClientRequest request) {
       // Optionally set up headers...
       // Optionally write to the request object
       // Then call close.

       return request.close();
     })
     .then( (HttpClientResponse response ){
       //Process the response.
      if ( response.statusCode==HttpStatus.OK){
        print( response.statusCode );
        response.listen((contents) {
         // handle data
         print(UTF8.decode(contents) );
       });
      }
     });

}
