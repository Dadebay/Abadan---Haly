import 'dart:convert';

CarpetData carpetDataFromJson(String str) =>
    CarpetData.fromJson(json.decode(str));

String carpetDataToJson(CarpetData data) => json.encode(data.toJson());

class CarpetData {
  final List<Edge> edges;
  final Settings settings;
  final List<Intro> intros;
  final About about;
  final List<Contact> contacts;
  final List<Category> categories;
  final List<Product> products;

  CarpetData({
    required this.edges,
    required this.settings,
    required this.intros,
    required this.about,
    required this.contacts,
    required this.categories,
    required this.products,
  });

  factory CarpetData.fromJson(Map<String, dynamic> json) => CarpetData(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
        settings: Settings.fromJson(json["settings"]),
        intros: List<Intro>.from(json["intros"].map((x) => Intro.fromJson(x))),
        about: About.fromJson(json["about"]),
        contacts: List<Contact>.from(
            json["contacts"].map((x) => Contact.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
        "settings": settings.toJson(),
        "intros": List<dynamic>.from(intros.map((x) => x.toJson())),
        "about": about.toJson(),
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

// ---------------- EDGES ----------------
class Edge {
  final int id;
  final String name;

  Edge({
    required this.id,
    required this.name,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

// ---------------- SETTINGS ----------------
class Settings {
  final SizeRange sizeRange;

  Settings({required this.sizeRange});

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        sizeRange: SizeRange.fromJson(json["size_range"]),
      );

  Map<String, dynamic> toJson() => {
        "size_range": sizeRange.toJson(),
      };
}

class SizeRange {
  final MinMax height;
  final MinMax width;

  SizeRange({required this.height, required this.width});

  factory SizeRange.fromJson(Map<String, dynamic> json) => SizeRange(
        height: MinMax.fromJson(json["height"]),
        width: MinMax.fromJson(json["width"]),
      );

  Map<String, dynamic> toJson() => {
        "height": height.toJson(),
        "width": width.toJson(),
      };
}

class MinMax {
  final int min;
  final int max;

  MinMax({required this.min, required this.max});

  factory MinMax.fromJson(Map<String, dynamic> json) => MinMax(
        min: int.parse(json["min"].toString()),
        max: int.parse(json["max"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

// ---------------- INTROS ----------------
class Intro {
  final int id;
  final String title;
  final String description;
  final String image;
  final String logo;

  Intro({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.logo,
  });

  factory Intro.fromJson(Map<String, dynamic> json) => Intro(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "logo": logo,
      };
}

// ---------------- ABOUT ----------------
class About {
  final String title;
  final String description;
  final List<String> files;

  About({
    required this.title,
    required this.description,
    required this.files,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        title: json["title"],
        description: json["description"],
        files: List<String>.from(json["files"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

// ---------------- CONTACTS ----------------
class Contact {
  final int id;
  final String title;
  final String description;
  final String link;
  final int position;
  final String icon;

  Contact({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.position,
    required this.icon,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        position: json["position"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "link": link,
        "position": position,
        "icon": icon,
      };
}

// ---------------- CATEGORIES ----------------
class Category {
  final int id;
  final String name;
  final String image;
  final int position;
  final List<Subcategory> subcategories;
  final List<Attribute> attributes;
  final List<int> topSellingProductsIds;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.position,
    required this.subcategories,
    required this.attributes,
    required this.topSellingProductsIds,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        position: json["position"],
        subcategories: json["subcategories"] == null
            ? []
            : List<Subcategory>.from(
                json["subcategories"].map((x) => Subcategory.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromJson(x))),
        topSellingProductsIds: json["top_selling_products_ids"] == null
            ? []
            : List<int>.from(json["top_selling_products_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "position": position,
        "subcategories":
            List<dynamic>.from(subcategories.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "top_selling_products_ids":
            List<dynamic>.from(topSellingProductsIds.map((x) => x)),
      };
}

class Subcategory {
  final int id;
  final String name;
  final String image;

  Subcategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Attribute {
  final String name;
  final String value;

  Attribute({
    required this.name,
    required this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

// ---------------- PRODUCTS ----------------
class Product {
  final int id;
  final String code;
  final String? description;
  final int categoryId;
  final int subCategoryId;
  final List<Figure> figures;
  final List<int> edgesIds;

  Product({
    required this.id,
    required this.code,
    this.description,
    required this.categoryId,
    required this.subCategoryId,
    required this.figures,
    required this.edgesIds,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        figures: json["figures"] == null
            ? []
            : List<Figure>.from(json["figures"].map((x) => Figure.fromJson(x))),
        edgesIds: json["edges_ids"] == null
            ? []
            : List<int>.from(json["edges_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "figures": List<dynamic>.from(figures.map((x) => x.toJson())),
        "edges_ids": List<dynamic>.from(edgesIds.map((x) => x)),
      };
}

class Figure {
  final int id;
  final String name;
  final String image;
  final List<CarpetColor> colors;
  final List<Size> sizes;

  Figure({
    required this.id,
    required this.name,
    required this.image,
    required this.colors,
    required this.sizes,
  });

  factory Figure.fromJson(Map<String, dynamic> json) => Figure(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        colors: json["colors"] == null
            ? []
            : List<CarpetColor>.from(
                json["colors"].map((x) => CarpetColor.fromJson(x))),
        sizes: json["sizes"] == null
            ? []
            : List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
      };
}

class CarpetColor {
  final int id;
  final String name;
  final String hexCode;
  final String image;

  CarpetColor({
    required this.id,
    required this.name,
    required this.hexCode,
    required this.image,
  });

  factory CarpetColor.fromJson(Map<String, dynamic> json) => CarpetColor(
        id: json["id"],
        name: json["name"],
        hexCode: json["hex_code"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hex_code": hexCode,
        "image": image,
      };
}

class Size {
  final int id;
  final int height;
  final int width;
  final String measurementUnit;

  Size({
    required this.id,
    required this.height,
    required this.width,
    required this.measurementUnit,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        height: json["height"],
        width: json["width"],
        measurementUnit: json["measurement_unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
        "width": width,
        "measurement_unit": measurementUnit,
      };
}
