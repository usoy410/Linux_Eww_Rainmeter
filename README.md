# RainMeter Eww Widgets

`ClockRainmeter` and `CavaVisualizer` widgets.

## Sample

![Sample widget screenshot](./Sample.png)

## Contents

### 1. ClockRainmeter

A minimalist clock widget showing the day, date, and time.

- `clock.yuck`: Widget and window definitions.
- `variables.yuck`: Time/day/date polls.
- `style.scss`: Required CSS styles.

### 2. CavaVisualizer

A simple audio visualizer using `cava`.

- `cava.yuck`: Widget and window definitions.
- `variables.yuck`: Cava listen variable.
- `scripts/cava.sh`: Script that processes `cava` output.
- `style.scss`: Required CSS styles.

## Quick Setup (Recommended)

Run the setup script from this repository root:

```bash
git clone https://github.com/usoy410/Linux_Eww_Rainmeter.git
chmod +x ./scripts/setup.sh ./scripts/run.sh
./scripts/setup.sh
```

What setup does:

1. Installs required dependencies (`eww`, `cava`) using your system package manager (apt/pacman/dnf/zypper).
2. Creates a standalone Eww config at `~/.config/eww-standalone_widgets`.
3. Copies both widget folders there.
4. Generates `eww.yuck` and `eww.scss` that include/import both widgets.

Then start both widgets:

```bash
./scripts/run.sh
```

## Manual Run Commands

If you prefer running manually:

```bash
eww --config ~/.config/eww-standalone_widgets daemon
eww --config ~/.config/eww-standalone_widgets open clock
eww --config ~/.config/eww-standalone_widgets open visualizer_window
```

To stop them:

```bash
eww --config ~/.config/eww-standalone_widgets close clock
eww --config ~/.config/eww-standalone_widgets close visualizer_window
```

## Dependency Note

If automatic dependency installation cannot find `eww` on your distro repositories, install `eww` manually and re-run setup.
