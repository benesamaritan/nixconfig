{ ... }:
{
    programs.helix.settings.editor = {
        auto-format = true;
        line-number = "relative";
        mouse = true;
        true-color = true;
        color-modes = true;
        cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
        };
        file-picker = {
            hidden = true;
            max-depth = 10;
        };
        soft-wrap = {
            enable = true;
            max-wrap = 20;
        };
        smart-tab.enable = false;
        statusline = {
            left = [
                "mode"
                "spinner"
            ];
            center = [
                "file-name"
            ];
            right = [
                "diagnostics"
                "selections"
                "position"
                "file-type"
            ];
            separator = "│";
            mode = {
                normal = "NOR";
                insert = "INS";
                select = "SEL";
            };
            diagnostics = [
                "warning"
                "error"
            ];
            workspace-diagnostics = [
                "warning"
                "error"
            ];
        };
        whitespace.render = {
            space = "all";
            tab = "all";
            nbsp = "all";
            nnbsp = "none";
            tabpad = "all";
            newline = "none";
        };
        whitespace.characters = {
            space = "_";
            nbsp = "⍽";
            nnbsp = "␣";
            tab = "→";
            tabpad = "·";
        };
        indent-guides = {
            render = true;
            character = "▏";
            skip-levels = 1;
        };
        gutters.layout = [
            "diff"
            "diagnostics"
            "line-numbers"
            "spacer"
        ];
    };
}
