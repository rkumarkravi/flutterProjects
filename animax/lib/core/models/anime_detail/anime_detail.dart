class ApiResponse {
  String? status;
  String? message;
  String? path;
  String? timeStamp;
  AnimeRespone? data;

  ApiResponse(
      {this.status, this.message, this.path, this.timeStamp, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    path = json['path'];
    timeStamp = json['timeStamp'];
    data = json['data'] != null ? AnimeRespone.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['path'] = path;
    data['timeStamp'] = timeStamp;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class AnimeRespone<T> {
  List<AnimeDetail>? content;
  String? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  AnimeRespone(
      {this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.sort,
      this.numberOfElements,
      this.first,
      this.empty});

  AnimeRespone.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(AnimeDetail.fromJson(v));
      });
    }
    pageable = json['pageable'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content?.map((v) => v.toJson()).toList();
    }
    data['pageable'] = pageable;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['last'] = last;
    data['size'] = size;
    data['number'] = number;
    if (sort != null) {
      data['sort'] = sort?.toJson();
    }
    data['numberOfElements'] = numberOfElements;
    data['first'] = first;
    data['empty'] = empty;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['empty'] = empty;
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    return data;
  }
}

class AnimeDetail {
  String? animeType;
  String? name;
  String? dateOfRelease;
  String? credits;
  String? description;
  String? animeBackdrop;
  String? poster;
  String? originCountry;
  String? likes;
  String? trailerLink;
  List<Video>? videos;
  int? aid;

  AnimeDetail(
      {this.animeType,
      this.name,
      this.dateOfRelease,
      this.credits,
      this.description,
      this.animeBackdrop,
      this.poster,
      this.originCountry,
      this.likes,
      this.trailerLink,
      this.videos,
      this.aid});

  AnimeDetail.fromJson(Map<String, dynamic> json) {
    animeType = json['animeType'];
    name = json['name'];
    dateOfRelease = json['dateOfRelease'];
    credits = json['credits'];
    description = json['description'];
    animeBackdrop = json['animeBackdrop'];
    poster = json['poster'];
    originCountry = json['originCountry'];
    likes = json['likes'];
    trailerLink = json['trailerLink'];
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Video.fromJson(v));
      });
    }
    aid = json['aid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animeType'] = animeType;
    data['name'] = name;
    data['dateOfRelease'] = dateOfRelease;
    data['credits'] = credits;
    data['description'] = description;
    data['animeBackdrop'] = animeBackdrop;
    data['poster'] = poster;
    data['originCountry'] = originCountry;
    data['likes'] = likes;
    data['trailerLink'] = trailerLink;
    if (videos != null) {
      data['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    data['aid'] = aid;
    return data;
  }
}

class Video {
  String? totalTime;
  String? title;
  VideoBlobFile? videoBlobFile;
  Thumbnail? thumbnail;
  int? vid;
  int? seasonNo;

  Video(
      {this.totalTime,
      this.title,
      this.videoBlobFile,
      this.thumbnail,
      this.vid,
      this.seasonNo});

  Video.fromJson(Map<String, dynamic> json) {
    totalTime = json['totalTime'];
    title = json['title'];
    videoBlobFile = (json['videoBlobFile'] != null
        ? VideoBlobFile.fromJson(json['videoBlobFile'])
        : null)!;
    thumbnail = (json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null)!;
    vid = json['vid'];
    seasonNo = json['seasonNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalTime'] = totalTime;
    data['title'] = title;
    if (videoBlobFile != null) {
      data['videoBlobFile'] = videoBlobFile?.toJson();
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail?.toJson();
    }
    data['vid'] = vid;
    data['seasonNo'] = seasonNo;
    return data;
  }
}

class VideoBlobFile {
  int? vbId;
  String? vblob;
  String? vfile;

  VideoBlobFile({this.vbId, this.vblob, this.vfile});

  VideoBlobFile.fromJson(Map<String, dynamic> json) {
    vbId = json['vbId'];
    vblob = json['vblob'];
    vfile = json['vfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vbId'] = vbId;
    data['vblob'] = vblob;
    data['vfile'] = vfile;
    return data;
  }
}

class Thumbnail {
  String? file;
  int? tid;
  String? tblob;

  Thumbnail({this.file, this.tid, this.tblob});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    tid = json['tid'];
    tblob = json['tblob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['tid'] = tid;
    data['tblob'] = tblob;
    return data;
  }
}
