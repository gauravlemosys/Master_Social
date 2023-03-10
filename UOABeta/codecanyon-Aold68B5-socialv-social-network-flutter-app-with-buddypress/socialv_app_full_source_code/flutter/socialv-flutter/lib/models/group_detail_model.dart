class GroupDetailModel {
  String? dateCreated;
  String? description;
  String? groupAvatarImage;
  String? groupCoverImage;
  String? groupCreatedBy;
  int? groupCreatedById;
  String? groupType;
  int? id;
  bool? isGroupAdmin;
  bool? isGroupMember;
  int? isRequestSent;
  int? hasInvite;
  String? memberCount;
  List<Member>? memberList;
  String? name;
  String? postCount;

  GroupDetailModel({
    this.dateCreated,
    this.description,
    this.groupAvatarImage,
    this.groupCoverImage,
    this.groupCreatedBy,
    this.groupCreatedById,
    this.groupType,
    this.id,
    this.isGroupAdmin,
    this.isGroupMember,
    this.isRequestSent,
    this.memberCount,
    this.memberList,
    this.name,
    this.postCount,
    this.hasInvite,
  });

  factory GroupDetailModel.fromJson(Map<String, dynamic> json) {
    return GroupDetailModel(
      dateCreated: json['date_created'],
      description: json['description'],
      groupAvatarImage: json['group_avtar_image'],
      groupCoverImage: json['group_cover_image'],
      groupCreatedBy: json['group_created_by'],
      groupCreatedById: json['group_created_by_id'],
      groupType: json['group_type'],
      id: json['id'],
      isGroupAdmin: json['is_group_admin'],
      isGroupMember: json['is_group_member'],
      isRequestSent: json['is_request_sent'],
      hasInvite: json['has_invite'],
      memberCount: json['member_count'],
      memberList: json['member_list'] != null ? (json['member_list'] as List).map((i) => Member.fromJson(i)).toList() : null,
      name: json['name'],
      postCount: json['post_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_created'] = this.dateCreated;
    data['description'] = this.description;
    data['group_avtar_image'] = this.groupAvatarImage;
    data['group_cover_image'] = this.groupCoverImage;
    data['group_created_by'] = this.groupCreatedBy;
    data['group_created_by_id'] = this.groupCreatedById;
    data['group_type'] = this.groupType;
    data['id'] = this.id;
    data['is_group_admin'] = this.isGroupAdmin;
    data['is_group_member'] = this.isGroupMember;
    data['is_request_sent'] = this.isRequestSent;
    data['has_invite'] = this.hasInvite;
    data['member_count'] = this.memberCount;
    data['name'] = this.name;
    data['post_count'] = this.postCount;
    if (this.memberList != null) {
      data['member_list'] = this.memberList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Member {
  String? userAvatar;
  int? userId;
  String? userName;

  Member({this.userAvatar, this.userId, this.userName});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userAvatar: json['user_avatar'],
      userId: json['user_id'],
      userName: json['user_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_avatar'] = this.userAvatar;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    return data;
  }
}
