// To parse this JSON data, do
//
//     final claims = claimsFromJson(jsonString);

import 'dart:convert';

Claims claimsFromJson(String str) => Claims.fromJson(json.decode(str));

String claimsToJson(Claims data) => json.encode(data.toJson());

class Claims {
	Claims({
		this.data,
	});
	
	Data data;
	
	factory Claims.fromJson(Map<String, dynamic> json) => Claims(
		data: Data.fromJson(json["data"]),
	);
	
	Map<String, dynamic> toJson() => {
		"data": data.toJson(),
	};
}

class Data {
	Data({
		this.insureeProfile,
	});
	
	InsureeProfile insureeProfile;
	
	factory Data.fromJson(Map<String, dynamic> json) => Data(
		insureeProfile: InsureeProfile.fromJson(json["insureeProfile"]),
	);
	
	Map<String, dynamic> toJson() => {
		"insureeProfile": insureeProfile.toJson(),
	};
}

class InsureeProfile {
	InsureeProfile({
		this.insureeClaim,
	});
	
	List<InsureeClaim> insureeClaim;
	
	factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
		insureeClaim: List<InsureeClaim>.from(json["insureeClaim"].map((x) => InsureeClaim.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"insureeClaim": List<dynamic>.from(insureeClaim.map((x) => x.toJson())),
	};
}

class InsureeClaim {
	InsureeClaim({
		this.id,
		this.dateClaimed,
		this.claimed,
		this.healthFacility,
	});
	
	String id;
	DateTime dateClaimed;
	double claimed;
	HealthFacility healthFacility;
	
	factory InsureeClaim.fromJson(Map<String, dynamic> json) => InsureeClaim(
		id: json["id"],
		dateClaimed: DateTime.parse(json["dateClaimed"]),
		claimed: json["claimed"],
		healthFacility: HealthFacility.fromJson(json["healthFacility"]),
	);
	
	Map<String, dynamic> toJson() => {
		"id": id,
		"dateClaimed": "${dateClaimed.year.toString().padLeft(4, '0')}-${dateClaimed.month.toString().padLeft(2, '0')}-${dateClaimed.day.toString().padLeft(2, '0')}",
		"claimed": claimed,
		"healthFacility": healthFacility.toJson(),
	};
}

class HealthFacility {
	HealthFacility({
		this.name,
	});
	
	String name;
	
	factory HealthFacility.fromJson(Map<String, dynamic> json) => HealthFacility(
		name: json["name"],
	);
	
	Map<String, dynamic> toJson() => {
		"name": name,
	};
}
