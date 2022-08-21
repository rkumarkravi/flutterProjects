import 'dart:convert';

import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class DashboarController extends GetxController {
  var nameOfApp = Rx<String>("abcjkskdjfsd");
  var jwt = Rx<String>("");
  /* var jsonvalue = Rx<Map<String, dynamic>>(jsonDecode("""{
    "content": [
        {
            "animeType": "season",
            "name": "The Sandman",
            "dateOfRelease": "2022",
            "credits": "Series",
            "description": "After years of imprisonment, Morpheus — the King of Dreams — embarks on a journey across worlds to find what was stolen from him and restore his power.",
            "animeBackdrop": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
            "poster": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/q54qEgagGOYCq5D1903eBVMNkbo.jpg",
            "originCountry": null,
            "likes": null,
            "trailerLink": "https://dl109.dlmate33.xyz/?file=M3R4SUNiN3JsOHJ6WWQ3aTdPRFA4NW1rRVJIOG12STJqdEEyakNNM0ZLOUZxWjVrOCt1ak44WmRaWlFiMzR1c0Z0c2YvRENUWmRpT2V5S2N1b3d2VkhhVDVOTjJ0am1FM284a1Y4eGlSVjJ6dE9DbG56Si9pQXUrU3NyTUhMUlRmMGdxOHhnencyaWUzS1dTdnh6MHRrSzlwbG1MTVdGWWxDSUVLT0hGODVvTmgwL0dmNk9oZ2JaUjZIUzU0NjFUMXNIUG1sZm4wclVCNll3dERsUTZmb0FKbjUzdzBLM2xpd0VjbUlrVnlFaXdvTytqVzg5alNmektMRzRvYlhCUCt2bXlXQmxL",
            "videos": [
                {
                    "totalTime": "32:39",
                    "title": "Naruto EP 3",
                    "videoBlobFile": {
                        "vbId": 11,
                        "vblob": null,
                        "vfile": "a9fc9e9a-86a8-3a43-bcec-9dec64e822a1.mp4"
                    },
                    "thumbnail": {
                        "file": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
                        "tid": 10,
                        "tblob": null
                    },
                    "vid": 9
                },{
                    "totalTime": "32:39",
                    "title": "Naruto EP 3",
                    "videoBlobFile": {
                        "vbId": 11,
                        "vblob": null,
                        "vfile": "a9fc9e9a-86a8-3a43-bcec-9dec64e822a1.mp4"
                    },
                    "thumbnail": {
                        "file": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
                        "tid": 10,
                        "tblob": null
                    },
                    "vid": 9
                },{
                    "totalTime": "32:39",
                    "title": "Naruto EP 3",
                    "videoBlobFile": {
                        "vbId": 11,
                        "vblob": null,
                        "vfile": "a9fc9e9a-86a8-3a43-bcec-9dec64e822a1.mp4"
                    },
                    "thumbnail": {
                        "file": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
                        "tid": 10,
                        "tblob": null
                    },
                    "vid": 9
                },{
                    "totalTime": "32:39",
                    "title": "Naruto EP 3",
                    "videoBlobFile": {
                        "vbId": 11,
                        "vblob": null,
                        "vfile": "a9fc9e9a-86a8-3a43-bcec-9dec64e822a1.mp4"
                    },
                    "thumbnail": {
                        "file": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
                        "tid": 10,
                        "tblob": null
                    },
                    "vid": 9
                },{
                    "totalTime": "32:39",
                    "title": "Naruto EP 3",
                    "videoBlobFile": {
                        "vbId": 11,
                        "vblob": null,
                        "vfile": "a9fc9e9a-86a8-3a43-bcec-9dec64e822a1.mp4"
                    },
                    "thumbnail": {
                        "file": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
                        "tid": 10,
                        "tblob": null
                    },
                    "vid": 9
                },{
                    "totalTime": "32:39",
                    "title": "Naruto EP 3",
                    "videoBlobFile": {
                        "vbId": 11,
                        "vblob": null,
                        "vfile": "a9fc9e9a-86a8-3a43-bcec-9dec64e822a1.mp4"
                    },
                    "thumbnail": {
                        "file": "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/6KyJeOW7vTW0czdR0S6wzXAcfmw.jpg",
                        "tid": 10,
                        "tblob": null
                    },
                    "vid": 9
                }
            ],
            "aid": 1
        },
        {
            "animeType": "single",
            "name": "Naruto",
            "dateOfRelease": "07/28/2012",
            "credits": "Ravi Kumar",
            "description": "Naruto is a Japanese manga series written and illustrated by Masashi Kishimoto. It tells the story of Naruto Uzumaki, a young ninja who seeks recognition from his peers and dreams of becoming the Hoka…",
            "animeBackdrop": "https://image.tmdb.org/t/p/original/hBIZ6RiaCWszRbdvHAy6RWHyT3c.jpg",
            "poster": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/xLal6fXNtiJN6Zw6qk21xAtdOeN.jpg",
            "originCountry": null,
            "likes": null,
            "trailerLink": "https://youtu.be/WhPOcizrFqg",
            "videos": [],
            "aid": 12
        },
        {
            "animeType": "single",
            "name": "Doctor Strange in the Multiverse of Madness",
            "dateOfRelease": "2022-05-04",
            "credits": "Manga",
            "description": "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
            "animeBackdrop": "https://image.tmdb.org/t/p/original/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg",
            "poster": "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg",
            "originCountry": null,
            "likes": null,
            "trailerLink": "https://dl109.dlmate33.xyz/?file=M3R4SUNiN3JsOHJ6WWQ3aTdPRFA4NW1rRVJIOG12STJqdEEyakNNM0ZLOUZxWjVrOCt1ak44WmRaWlFiMzR1c0Z0c2YvRENUWmRpT2V5S2N1b3d2VkhhVDVOTjJ0am1FM284a1Y4eGlSVjJ6dE9DbG56Si9pQXUrU3NyTUhMUlRmMGdxOHhnencyaWUzS1dTdnh6MHRrSzlwbG1MTVdGWWxDSUVLT0hGODVvTmgwL0dmNk9oZ2JaUjZIUzU0NjFUMXNIUG1sZm4wclVCNll3dERsUTZmb0FKbjUzdzBLM2xpd0VjbUlrVnlFaXdvTytqVzg5alNmektMRzRvYlhCUCt2bXlXQmxL",
            "videos": [],
            "aid": 13
        },
        {
            "animeType": "single",
            "name": "Thor: Love and Thunder",
            "dateOfRelease": "2022-07-06",
            "credits": "Manga",
            "description": "After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now inexplicably wields Mjolnir as the Mighty Thor.",
            "animeBackdrop": "https://image.tmdb.org/t/p/original/p1F51Lvj3sMopG948F5HsBbl43C.jpg",
            "poster": "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg",
            "originCountry": null,
            "likes": null,
            "trailerLink": "https://dl84.dlmate04.xyz/?file=M3R4SUNiN3JsOHJ6WWQ3aTdPRFA4NW1rRVJIOG12STJqdEEyakNNM0ZLOUZxWjVrNCt5dk1ZSmpJYkVLaG91c0ZaVmcvU3ZXZGRXWmUwU21zSjR2UVhxQSs1MEpxejdHLzRzeVpwZ2hEa2JvMWV1enduZHdnQXZ3UWNqTUFiQUxLQ1ZkdWs5Mnh6T1J5YlNHbnhqbzV6ai9nUlhHUGdJdHZXTUZDZmpXNDY1TWpWYWFQNiswdzk0SXZYTFo1WjlHaDltejhnVHUwN3NzdmNoOFUwRXBJc1lJZ002ampxS2Q5d0VLbHNRWTJCcz0%3D",
            "videos": [],
            "aid": 14
        }
    ],
    "pageable": "INSTANCE",
    "totalPages": 1,
    "totalElements": 4,
    "last": true,
    "size": 4,
    "number": 0,
    "sort": {
        "empty": true,
        "sorted": false,
        "unsorted": true
    },
    "numberOfElements": 4,
    "first": true,
    "empty": false
}"""));*/

  Future<AnimeRespone> fetchData(page, size) async {
    //http://localhost:8080/anime/api/v1/anime/getAll
    final response = await http.post(
        Uri(
            scheme: 'http',
            host: 'localhost',
            port: 8080,
            path: 'anime/api/v1/anime/getAll'),
        headers: {
          'Content-type': 'application/json',
          "Authorization": "Bearer ${jwt.value}"
        },
        body: '{"page": $page,"size": $size}');
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return AnimeRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
