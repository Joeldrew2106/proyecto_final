
import 'dart:convert';

class Alimentos {
    Alimentos({
        this.parsed,
    });

    List<Parsed>? parsed;

    factory Alimentos.fromJson(String str) => Alimentos.fromMap(json.decode(str));
    factory Alimentos.fromMap(Map<String, dynamic> json) => Alimentos(
        parsed: List<Parsed>.from(json["parsed"].map((x) => Parsed.fromMap(x))),
    );
}
class Parsed {
    Parsed({
        this.food,
    });
    Food? food;
    factory Parsed.fromJson(String str) => Parsed.fromMap(json.decode(str));
        factory Parsed.fromMap(Map<String, dynamic> json) => Parsed(
        food: Food.fromMap(json["food"]),
    );
}

class Food {
    Food({
        required this.foodId,
        required this.label,
        required this.nutrients,
        required this.category,
        required this.categoryLabel,
        required this.image,
    });

    String foodId;
    String label;
    Nutrients nutrients;
    String category;
    String categoryLabel;
    String image;

    factory Food.fromJson(String str) => Food.fromMap(json.decode(str));

    factory Food.fromMap(Map<String, dynamic> json) => Food(
        foodId: json["foodId"],
        label: json["label"],
        nutrients: Nutrients.fromMap(json["nutrients"]),
        category: json["category"],
        categoryLabel: json["categoryLabel"],
        image: json["image"],
    );

    
}

class Nutrients {
    Nutrients({
        required this.enercKcal,
        required this.procnt,
        required this.fat,
        required this.chocdf,
        required this.fibtg,
    });

    int enercKcal;
    double procnt;
    double fat;
    double chocdf;
    double fibtg;

    factory Nutrients.fromJson(String str) => Nutrients.fromMap(json.decode(str));

    factory Nutrients.fromMap(Map<String, dynamic> json) => Nutrients(
        enercKcal: json["ENERC_KCAL"].toInt(),
        procnt: json["PROCNT"].toDouble(),
        fat: json["FAT"].toDouble(),
        chocdf: json["CHOCDF"].toDouble(),
        fibtg: json["FIBTG"].toDouble(),
    );

    
}
