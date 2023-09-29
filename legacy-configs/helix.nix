{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    
    settings = {
      theme = "ayu_dark";

      keys.normal = {
        "h" = []; # Debind H
        "j" = ["move_char_left"]; # Left
        "k" = ["move_line_down"]; # Down
        "l" = ["move_line_up"]; # Up
        ";" = ["move_char_right"]; # Right

        "S-j" = ["move_prev_word_end"]; # Move back a word
        "S-k" = ["extend_to_line_bounds" "delete_selection" "paste_after"]; # Move line down        
        "S-l" = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"]; # Move line up
        "S-;" = ["move_next_word_end"]; # Move foward a word

        "S-left" = ["move_prev_word_end"]; # Move back a word
        "S-down" = ["extend_to_line_bounds" "delete_selection" "paste_after"]; # Move line down
        "S-up" = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"]; # Move line up
        "S-right" = ["move_next_word_end"]; # Move foward a word

        "C-j" = ["goto_line_start"]; # Move to the start of the line
        "C-;" = ["goto_line_end"]; # Move to the end of the line

        "tab" = ["extend_to_line_bounds" "indent"]; # Indent line
        "S-tab" = ["extend_to_line_bounds" "unindent"]; # Unindent line

        "C-backspace" = ["delete_word_backward"]; # Delete word
        "S-backspace" = ["kill_to_line_start"]; # Delete line

        "C-l" = [":write-all" ":buffer-close-others"]; # Save and close all buffers except current

        "C-left" = ["goto_line_start"]; # Move to the start of the line
        "C-right" = ["goto_line_end"]; # Move to the end of the line
      };

      keys.insert = {
        "A-j" = ["move_char_left"]; # Left
        "A-k" = ["move_line_down"]; # Down
        "A-l" = ["move_line_up"]; # Up
        "A-;" = ["move_char_right"]; # Right

        "C-j" = ["move_prev_word_end"]; # Move back a word
        "C-k" = ["extend_to_line_bounds" "delete_selection" "paste_after" "move_line_down"]; # Move line down
        "C-l" = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "move_line_up"]; # Move line up
        "C-;" = ["move_next_word_end"]; # Move foward a word

        "S-left" = ["move_prev_word_end"]; # Move back a word
        "S-down" = ["extend_to_line_bounds" "delete_selection" "paste_after" "move_line_down"]; # Move line down
        "S-up" = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "move_line_up"]; # Move line up
        "S-right" = ["move_next_word_end"]; # Move foward a word

        "C-A-j" = ["goto_line_start"]; # Move to the start of the line
        "C-A-;" = ["goto_line_end"]; # Move to the end of the line

        "C-left" = ["goto_line_start"]; # Move to the start of the line
        "C-right" = ["goto_line_end"]; # Move to the end of the line

        "S-tab" = ["extend_to_line_bounds" "unindent"]; # Unindent line

        "C-backspace" = ["delete_word_backward"]; # Delete previous word
        "S-backspace" = ["kill_to_line_start"]; # Delete line

      };
      
      keys.select = {
        "h" = []; # Debind H
        "j" = ["move_char_left"]; # Left
        "k" = ["move_line_down"]; # Down
        "l" = ["move_line_up"]; # Up
        ";" = ["move_char_right"]; # Right

        "S-j" = ["extend_prev_word_start"]; # Extend selection to the start of the previous word
        "S-k" = ["ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "add_newline_below" "move_line_down" "replace_with_yanked"]; # Move selection down 
        "S-l" = ["ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "move_line_up" "add_newline_above" "move_line_up" "replace_with_yanked"]; # Move selection up
        "S-;" = ["extend_next_word_end"]; # Extend selection to the end of the next word
        
        "S-left" = ["extend_prev_word_start"]; # Extend selection to the start of the previous word
        "S-down" = ["ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "add_newline_below" "move_line_down" "replace_with_yanked"]; # Move selection down 
        "S-up" = ["ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "move_line_up" "add_newline_above" "move_line_up" "replace_with_yanked"]; # Move selection up
        "S-right" = ["extend_next_word_end"]; # Extend selection to the end of the next word
        
        "C-j" = ["extend_to_line_start"]; # extend selection to the start of the line
        "C-;" = ["extend_to_line_end"]; # extend selection to the end of the line

        "C-left" = ["extend_to_line_start"]; # extend selection to the start of the line
        "C-right" = ["extend_to_line_end"]; # extend selection to the end of the line
      };

      editor = {
        line-number = "relative";
        idle-timeout = 650;
        completion-replace = true;
        bufferline = "multiple";
        auto-format = false;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";

          left = [
            "mode" "separator"
            "total-line-numbers" "file-base-name" "file-modification-indicator"
          ];

          center = [
            "position" "position-percentage" "spacer" "separator"
            "primary-selection-length"
          ];

          right = [
            "diagnostics" "separator" "spacer"
            "version-control" "spacer"
          ];
        };

        lsp.display-inlay-hints = true;
        indent-guides.render = true;
      };
    };
  };
}