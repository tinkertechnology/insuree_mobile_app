class HealthFacilityCoordinates {
  Data data;

  HealthFacilityCoordinates({this.data});

  HealthFacilityCoordinates.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<HealthFacilityCoordinate> healthFacilityCoordinate;

  Data({this.healthFacilityCoordinate});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['healthFacilityCoordinate'] != null) {
      healthFacilityCoordinate = new List<HealthFacilityCoordinate>();
      json['healthFacilityCoordinate'].forEach((v) {
        healthFacilityCoordinate.add(new HealthFacilityCoordinate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthFacilityCoordinate != null) {
      data['healthFacilityCoordinate'] =
          this.healthFacilityCoordinate.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthFacilityCoordinate {
  String id;
  double distance;
  HealthFacility healthFacility;

  HealthFacilityCoordinate({this.id, this.distance, this.healthFacility});

  HealthFacilityCoordinate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distance = json['distance'];
    healthFacility = json['healthFacility'] != null
        ? new HealthFacility.fromJson(json['healthFacility'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['distance'] = this.distance;
    if (this.healthFacility != null) {
      data['healthFacility'] = this.healthFacility.toJson();
    }
    return data;
  }
}

class HealthFacility {
  String id;

  HealthFacility({this.id});

  HealthFacility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}