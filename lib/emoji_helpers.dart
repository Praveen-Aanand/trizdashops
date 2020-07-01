enum Emoji { electronics, babycare, homeappliances,fasion ,fruits,vegitables}

String emojiSelected(Emoji emoji) {
  switch (emoji) {
    case Emoji.electronics:
      return '💡';
    case Emoji.babycare:
      return '👶🏽';
    case Emoji.homeappliances:
      return '📺';
      case Emoji.fasion:
      return '👗';
      case Emoji.fruits:
      return '🍎';
      case Emoji.vegitables:
      return '🥕';
    default:
      return '';
  }
}
