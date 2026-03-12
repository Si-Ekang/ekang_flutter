enum QuizCategory {
  animals,
  birds,
  clothes,
  home,
  food,
  none;
}

extension ToQuizCategory on String {
  QuizCategory toQuizCategory() {
    switch (this) {
      case "animals":
        return QuizCategory.animals;
      case "birds":
        return QuizCategory.birds;
      case "clothes":
        return QuizCategory.clothes;
      case "home":
        return QuizCategory.home;
      case 'food':
        return QuizCategory.food;
      default:
        return QuizCategory.none;
    }
  }
}
