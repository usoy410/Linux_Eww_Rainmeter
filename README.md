# RainMeter Eww Widgets

Eww widget collection.

## Sample

![Sample widget screenshot](./Sample.png)

## Contents

- `ClockRainmeter`: A minimalist clock widget showing the day, date, and time.
- `CavaVisualizer`: A simple audio visualizer using `cava`.
- `ToolMenu`: Quick access widget for system tools like battery and Wi-Fi controls.
- `QuoteWidget`: Displays rotating inspirational quotes.
- `Calendar`: Compact calendar view widget.
- `TimeClock`: Alternate clock-style widget.

## Special Font Used for ClockRainmeter

`Anurati` download it from https://font.download/font/anurati
unzip it and move the Anurati-Regular.otf to ~/.local/share/fonts.
if it doesn't exist create it.

```bash
mkdir -p ~/.local/share/fonts
```

## Manual Usage

Clone this repository and copy the widget folder(s) you want into your Eww config.
Then include the needed `.yuck` and `style.scss` files in your root Eww files.

Example commands for Clock + Cava:

```bash
eww --config ~/.config/eww daemon
eww --config ~/.config/eww open clock
eww --config ~/.config/eww open visualizer_window
```

To stop them:

```bash
eww --config ~/.config/eww close clock
eww --config ~/.config/eww close visualizer_window
```

## Autostart on Login (Optional)

If you want widgets to start automatically, add your own Eww launch commands to your WM/DE startup config.

### 1. Hyprland

Add this line to `~/.config/hypr/hyprland.conf`:

```ini
exec-once = /bin/sh -c 'eww --config ~/.config/eww daemon; eww --config ~/.config/eww open clock; eww --config ~/.config/eww open visualizer_window'
```

### 2. Niri

Add this in `~/.config/niri/config.kdl`:

```kdl
spawn-at-startup "/bin/sh" "-c" "eww --config ~/.config/eww daemon; eww --config ~/.config/eww open clock; eww --config ~/.config/eww open visualizer_window"
```

### 3. Other Desktop/WMs

Add equivalent Eww daemon/open commands to your startup mechanism.

## Dependency Note

Install dependencies manually based on the widget you use. For example, `CavaVisualizer` needs `cava`.

## References

- Eww official docs: https://elkowar.github.io/eww/
- Eww GitHub repository: https://github.com/elkowar/eww
