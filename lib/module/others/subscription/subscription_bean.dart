class Subscription {
  int? _id;
  String? _name;
  String? _url;
  dynamic _schedule;
  IntervalSchedule? _intervalSchedule;
  String? _type;
  String? _whitelist;
  String? _blacklist;
  int? _status;
  String? _dependences;
  dynamic _extensions;
  dynamic _subBefore;
  dynamic _subAfter;
  String? _branch;
  dynamic _pullType;
  dynamic _pullOption;
  int? _pid;
  int? _isDisabled;
  String? _logPath;
  String? _scheduleType;
  String? _alias;
  String? _createdAt;
  String? _updatedAt;

  Subscription(
      {int? id,
      String? name,
      String? url,
      dynamic schedule,
      IntervalSchedule? intervalSchedule,
      String? type,
      String? whitelist,
      String? blacklist,
      int? status,
      String? dependences,
      dynamic extensions,
      dynamic subBefore,
      dynamic subAfter,
      String? branch,
      dynamic pullType,
      dynamic pullOption,
      int? pid,
      int? isDisabled,
      String? logPath,
      String? scheduleType,
      String? alias,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (url != null) {
      this._url = url;
    }
    if (schedule != null) {
      this._schedule = schedule;
    }
    if (intervalSchedule != null) {
      this._intervalSchedule = intervalSchedule;
    }
    if (type != null) {
      this._type = type;
    }
    if (whitelist != null) {
      this._whitelist = whitelist;
    }
    if (blacklist != null) {
      this._blacklist = blacklist;
    }
    if (status != null) {
      this._status = status;
    }
    if (dependences != null) {
      this._dependences = dependences;
    }
    if (extensions != null) {
      this._extensions = extensions;
    }
    if (subBefore != null) {
      this._subBefore = subBefore;
    }
    if (subAfter != null) {
      this._subAfter = subAfter;
    }
    if (branch != null) {
      this._branch = branch;
    }
    if (pullType != null) {
      this._pullType = pullType;
    }
    if (pullOption != null) {
      this._pullOption = pullOption;
    }
    if (pid != null) {
      this._pid = pid;
    }
    if (isDisabled != null) {
      this._isDisabled = isDisabled;
    }
    if (logPath != null) {
      this._logPath = logPath;
    }
    if (scheduleType != null) {
      this._scheduleType = scheduleType;
    }
    if (alias != null) {
      this._alias = alias;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get url => _url;

  set url(String? url) => _url = url;

  dynamic get schedule => _schedule;

  set schedule(dynamic schedule) => _schedule = schedule;

  IntervalSchedule? get intervalSchedule => _intervalSchedule;

  set intervalSchedule(IntervalSchedule? intervalSchedule) =>
      _intervalSchedule = intervalSchedule;

  String? get type => _type;

  set type(String? type) => _type = type;

  String? get whitelist => _whitelist;

  set whitelist(String? whitelist) => _whitelist = whitelist;

  String? get blacklist => _blacklist;

  set blacklist(String? blacklist) => _blacklist = blacklist;

  int? get status => _status;

  set status(int? status) => _status = status;

  String? get dependences => _dependences;

  set dependences(String? dependences) => _dependences = dependences;

  dynamic get extensions => _extensions;

  set extensions(dynamic extensions) => _extensions = extensions;

  dynamic get subBefore => _subBefore;

  set subBefore(dynamic subBefore) => _subBefore = subBefore;

  dynamic get subAfter => _subAfter;

  set subAfter(dynamic subAfter) => _subAfter = subAfter;

  String? get branch => _branch;

  set branch(String? branch) => _branch = branch;

  dynamic get pullType => _pullType;

  set pullType(dynamic pullType) => _pullType = pullType;

  dynamic get pullOption => _pullOption;

  set pullOption(dynamic pullOption) => _pullOption = pullOption;

  int? get pid => _pid;

  set pid(int? pid) => _pid = pid;

  int? get isDisabled => _isDisabled;

  set isDisabled(dynamic isDisabled) => _isDisabled = isDisabled;

  String? get logPath => _logPath;

  set logPath(String? logPath) => _logPath = logPath;

  String? get scheduleType => _scheduleType;

  set scheduleType(String? scheduleType) => _scheduleType = scheduleType;

  String? get alias => _alias;

  set alias(String? alias) => _alias = alias;

  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

  String? get updatedAt => _updatedAt;

  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Subscription.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
    _schedule = json['schedule'];
    _intervalSchedule = json['interval_schedule'] != null
        ? new IntervalSchedule.fromJson(json['interval_schedule'])
        : null;
    _type = json['type'];
    _whitelist = json['whitelist'];
    _blacklist = json['blacklist'];
    _status = json['status'];
    _dependences = json['dependences'];
    _extensions = json['extensions'];
    _subBefore = json['sub_before'];
    _subAfter = json['sub_after'];
    _branch = json['branch'];
    _pullType = json['pull_type'];
    _pullOption = json['pull_option'];
    _pid = json['pid'];
    _isDisabled = json['is_disabled'];
    _logPath = json['log_path'];
    _scheduleType = json['schedule_type'];
    _alias = json['alias'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['url'] = this._url;
    data['schedule'] = this._schedule;
    if (this._intervalSchedule != null) {
      data['interval_schedule'] = this._intervalSchedule!.toJson();
    }
    data['type'] = this._type;
    data['whitelist'] = this._whitelist;
    data['blacklist'] = this._blacklist;
    data['status'] = this._status;
    data['dependences'] = this._dependences;
    data['extensions'] = this._extensions;
    data['sub_before'] = this._subBefore;
    data['sub_after'] = this._subAfter;
    data['branch'] = this._branch;
    data['pull_type'] = this._pullType;
    data['pull_option'] = this._pullOption;
    data['pid'] = this._pid;
    data['is_disabled'] = this._isDisabled;
    data['log_path'] = this._logPath;
    data['schedule_type'] = this._scheduleType;
    data['alias'] = this._alias;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    return data;
  }
  static Subscription jsonConversion(Map<String, dynamic> json) {
    return Subscription.fromJson(json);
  }
}

class IntervalSchedule {
  String? _type;
  int? _value;

  IntervalSchedule({String? type, int? value}) {
    if (type != null) {
      this._type = type;
    }
    if (value != null) {
      this._value = value;
    }
  }

  String? get type => _type;

  set type(String? type) => _type = type;

  int? get value => _value;

  set value(int? value) => _value = value;

  IntervalSchedule.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['value'] = this._value;
    return data;
  }


}
