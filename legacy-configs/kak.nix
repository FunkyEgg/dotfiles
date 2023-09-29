{
  programs.kakoune = {
    enable = true;

    config = { 
      autoComplete = ["insert" "prompt"];
      autoInfo = ["command" "onkey"];
      autoReload = "ask";
      
      colorScheme = "tomorrow-night";

      indentWidth = 4;

      numberLines = {
      	enable = true;
      	separator = "|";
      };

      scrollOff = {
        columns = 3;
        lines = 1;
      };
      
      tabStop = 4;

      ui = {
        enableMouse = true;
        assistant = "cat";
        setTitle = true;
        shiftFunctionKeys = 12;
      };

      hooks = [];
      keyMappings = [];
    };
  };
}
