class BannerInfo {
  final String id;
  final String desc;
  final String url;

  BannerInfo(this.id, this.desc, this.url);


  factory BannerInfo.formJson(Map<String, String> map){
    return BannerInfo(map['id'] ?? '', map['desc'] ?? '', map['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'url': url
    };
  }
}
