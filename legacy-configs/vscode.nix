{ pkgs, ... }:
let
  system = builtins.currentSystem;
  nixvsce =
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/nix-vscode-extensions";
      ref = "refs/heads/master";
      rev = "c43d9089df96cf8aca157762ed0e2ddca9fcd71e";
    })).extensions.${system};
in {
  programs.vscode = {
    enable = true;

    extensions = with nixvsce.vscode-marketplace; [
      siris01.ayu-green
      aaron-bond.better-comments
      ultram4rine.vscode-choosealicense
      minherz.copyright-inserter
      icrawl.discord-vscode
      usernamehw.errorlens
      tamasfe.even-better-toml
      mhutchie.git-graph
      rreverser.llvm
      emilast.logfilehighlighter
      yzhang.markdown-all-in-one
      bierner.markdown-preview-github-styles
      doinkythederp.nasm-language-support
      amatilda.vscode-fasm
      bbenoist.nix
      christian-kohler.path-intellisense
      gruntfuggly.todo-tree
      ziglang.vscode-zig
      danielgavin.ols
      cschlosser.doxdocgen
    ];

    userSettings = {
      editor = {
        lineNumbers = "on";
        # minimap.enabled = false;
        inlineSuggest.enabled = true;
        linkedEditing = true;

        guides.bracketPairs = "active";
        multiCursorModifier = "ctrlCmd";

        cursorSmoothCaretAnimation = "on";
        cursorBlinking = "smooth";

        fontSize = 14;
        fontFamily = "'Cascadia Code'";
        codeLensFontFamily = "'Cascadia Code'";
        inlayHints.fontFamily = "'Cascadia Code'";
        fontLigatures = true;

        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };
      };

      explorer = {
        confirmDelete = false;
        confirmDragAndDrop = false;
        compactFolders = false;
      };

      errorLens = {
        enabled = true;
        fontFamily = "'Cascadia Code'";
      };

      terminal.intergrated = {
        fontFamily = "'Cascadia Code'";
        gpuAcceleration = "on";
      };

      git = {
        autofetch = true;
        enableSmartCommit = true;
      };

      license = {
        author = "FunkyEgg <funkyeggdev@proton.me>";
        default = "apache-2.0";
        extension = ".md";
      };

      ols.server.path = "/home/funky/.nix-profile/bin/ols";

      "[nix]".editor.tabSize = 2;
      copyrightInserter.holder = "FunkyEgg <funkyeggdev@proton.me>";
      extensions.ignoreRecommendations = true;
      telemetry.telemetryLevel = "off";
      workbench.colorTheme = "Ayu Green Mirage";

      zig = {
        zigPath = "zig";
        formattingProvider = "off";

        zls = {
          enabled = true;
          path = "zls";
        };
      };
    };
  };
}