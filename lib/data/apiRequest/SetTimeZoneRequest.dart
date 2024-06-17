
class SetTimeZoneRequest {
  final SetTimeZoneAttrs attrs;
  final String name;

  SetTimeZoneRequest({
    required this.attrs,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'attrs': attrs.toJson(),
      'name': name,
    };
  }
}

class SetTimeZoneAttrs {
  final String timezone;
  final String timezoneVal;

  SetTimeZoneAttrs({
    required this.timezone,
    required this.timezoneVal,
  });

  Map<String, dynamic> toJson() {
    return {
      'Timezone': timezone,
      'Timezone_val': timezoneVal,
    };
  }
}