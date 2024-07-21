class MeditationItem {
  final String title;
  final String description;
  final Button button;
  final String image;
  // final Theme theme;

  MeditationItem({
    required this.title,
    required this.description,
    required this.button,
    required this.image,
    // required this.theme,
  });

  // Factory method to create an instance from JSON
  factory MeditationItem.fromJson(Map<String, dynamic> json) {
    return MeditationItem(
      title: json['title'],
      description: json['description'],
      button: Button.fromJson(json['button']),
      image: json['image'],
      // theme: Theme.fromJson(json['theme']),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'button': button.toJson(),
      'image': image,
      // 'theme': theme.toJson(),
    };
  }
}

class Button {
  final String text;
  final String icon;

  Button({
    required this.text,
    required this.icon,
  });

  // Factory method to create an instance from JSON
  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      text: json['text'],
      icon: json['icon'],
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
    };
  }
}

// class Theme {
//   final String backgroundColor;
//   final String titleColor;
//   final String descriptionColor;
//   final String buttonColor;
//   final String buttonTextColor;

//   Theme({
//     required this.backgroundColor,
//     required this.titleColor,
//     required this.descriptionColor,
//     required this.buttonColor,
//     required this.buttonTextColor,
//   });

//   // Factory method to create an instance from JSON
//   factory Theme.fromJson(Map<String, dynamic> json) {
//     return Theme(
//       backgroundColor: json['background_color'],
//       titleColor: json['title_color'],
//       descriptionColor: json['description_color'],
//       buttonColor: json['button_color'],
//       buttonTextColor: json['button_text_color'],
//     );
//   }

//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'background_color': backgroundColor,
//       'title_color': titleColor,
//       'description_color': descriptionColor,
//       'button_color': buttonColor,
//       'button_text_color': buttonTextColor,
//     };
//   }
// }
