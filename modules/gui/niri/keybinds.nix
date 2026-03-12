{ lib, self, ... }:
{
  flake.nixosModules.wm =
    { config, ... }:
    let
      termExec =
        cmd:
        [
          "ghostty"
          "-e"
        ]
        ++ (lib.flatten cmd);
    in
    {
      custom = {
        programs.niri.settings = {
          binds = {
            # Most actions that you can bind here can also be invoked programmatically with
            # `niri msg action do-something`.

            # show hotkey overlay
            # "Mod+Shift+Slash".show-hotkey-overlay = null;

            "Mod+Return".spawn = [ "ghostty" ];
            "Mod+BackSpace" = {
              close-window = null;
              _attrs = {
                repeat = false;
              };
            };
            # Open/close the Overview: a zoomed-out view of workspaces and windows.
            # You can also move the mouse into the top-left hot corner,
            # or do a four-finger swipe up on a touchpad.
            "Mod+O" = {
              toggle-overview = null;
              _attrs = {
                repeat = false;
              };
            };

            "Mod+H".focus-column-or-monitor-left = null;
            "Mod+J".focus-window-or-workspace-down = null;
            "Mod+K".focus-window-or-workspace-up = null;
            "Mod+L".focus-column-or-monitor-right = null;

            "Mod+Shift+H".move-column-left-or-to-monitor-left = null;
            "Mod+Shift+J".move-window-down-or-to-workspace-down = null;
            "Mod+Shift+K".move-window-up-or-to-workspace-up = null;
            "Mod+Shift+L".move-column-right-or-to-monitor-right = null;

            "Mod+Left".focus-monitor-left = null;
            "Mod+Down".focus-monitor-down = null;
            "Mod+Up".focus-monitor-up = null;
            "Mod+Right".focus-monitor-right = null;

            "Mod+Shift+Left".move-column-to-monitor-left = null;
            "Mod+Shift+Down".move-column-to-monitor-down = null;
            "Mod+Shift+Up".move-column-to-monitor-up = null;
            "Mod+Shift+Right".move-column-to-monitor-right = null;

            # toggle between prev and current windows
            "Mod+grave".focus-window-previous = null;

            # Switches focus between the current and the previous workspace.
            "Mod+Tab".focus-workspace-previous = null;

            # The following binds move the focused window in and out of a column.
            # If the window is alone, they will consume it into the nearby column to the side.
            # If the window is already in a column, they will expel it out.
            "Mod+BracketLeft".consume-or-expel-window-left = null;
            "Mod+BracketRight".consume-or-expel-window-right = null;

            "Mod+R".switch-preset-column-width = null;
            "Mod+Shift+R".switch-preset-window-height = null;

            # full maximize
            "Mod+Z".maximize-column = null;
            "Mod+F".fullscreen-window = null;
            # Expand the focused column to space not taken up by other fully visible columns.
            # Makes the column"fill the rest of the space".
            "Mod+Shift+F".expand-column-to-available-width = null;

            "Mod+C".center-column = null;

            # Center all fully visible columns on screen.
            "Mod+Ctrl+C".center-visible-columns = null;

            # Move the focused window between the floating and the tiling layout.
            "Mod+G".toggle-window-floating = null;
            # "Mod+Shift+V".switch-focus-between-floating-and-tiling = null;

            # Toggle tabbed column display mode.
            # Windows in this column will appear as vertical tabs,
            # rather than stacked on top of each other.
            "Mod+T".toggle-column-tabbed-display = null;

            # audio
            "XF86AudioLowerVolume" = {
              spawn = [
                "pamixer"
                "-d"
                "5"
              ];
              _attrs = {
                allow-when-locked = true;
              };
            };
            "XF86AudioRaiseVolume" = {
              spawn = [
                "pamixer"
                "-i"
                "5"
              ];
              _attrs = {
                allow-when-locked = true;
              };
            };
            "XF86AudioMute" = {
              spawn = [
                "pamixer"
                "-t"
              ];
              _attrs = {
                allow-when-locked = true;
              };
            };

            # mouse bindings

            # having Mod + Scroll up / Down is impossible to control with trackball, so require Shift for workspaces
            "Mod+Shift+WheelScrollDown" = {
              focus-workspace-down = null;
              _attrs = {
                cooldown-ms = 150;
              };
            };
            "Mod+Shift+WheelScrollUp" = {
              focus-workspace-up = null;
              _attrs = {
                cooldown-ms = 150;
              };
            };

            "Mod+WheelScrollRight".focus-column-right-or-first = null;
            "Mod+WheelScrollLeft".focus-column-left-or-last = null;
          };
        };
      };
      };
}
