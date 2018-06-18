typedef BooleanOptionSetter(bool enable);

typedef ColorSetter(int pin, int color);

typedef ColorSelector(int pin);

enum GameType {
  UNDEFINED,

  CLASSIC,
  SUPER
}

typedef GameStarter(GameType type);