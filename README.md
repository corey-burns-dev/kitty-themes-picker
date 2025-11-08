# Kitty Theme Picker

A curated collection of Kitty terminal color schemes bundled with a small overlay picker. Quickly preview and switch themes without leaving the keyboard.

## Features

- 150+ ready-to-use Kitty theme `.conf` files.
- Overlay picker script that keeps your workflow focused.
- Simple setup: copy, include, and launch with a key binding.

## Quick Start

1. Clone into your Kitty config directory:

    ```bash
    cd ~/.config/kitty
    git clone https://github.com/<your-repo>/kitty-themes-picker.git
    ```

2. Make the picker script executable:

    ```bash
    chmod +x kitty-theme-picker.sh
    ```

3. Add the following snippet to `kitty.conf` (or a file you include from it):

    ```conf
    include ./kitty-themes-picker/theme.conf
    allow_remote_control yes
    map ctrl+alt+shift+t launch --type=overlay ~/.config/kitty/kitty-themes-picker/kitty-theme-picker.sh
    ```

4. Reload Kitty (`ctrl+shift+f5` by default) or restart the terminal.

Press `ctrl+alt+shift+t` to open the overlay. Use the picker to scroll through themes and hit `enter` to apply.

## Picker Usage

- `↑`/`↓` navigate the theme list.
- `enter` applies the highlighted theme immediately.
- `esc` closes the overlay without changing your theme.

The script writes the selected theme to `theme.conf`, which Kitty reads through the `include` directive above.

## Managing Themes

- All theme files live under `themes/`. Each file name matches the theme label shown in the picker.
- Add new themes by dropping extra `.conf` files into `themes/`. The picker picks them up automatically.
- Remove or rename themes as needed; restart the picker to refresh the list.

## Customizing Key Bindings

Feel free to change the `map` line to any binding that fits your workflow. Refer to the [Kitty key mapping docs](https://sw.kovidgoyal.net/kitty/keyboard-protocol/#defining-your-own-shortcuts) for syntax.

## Contributing

Improvements, bug fixes, and new themes are welcome! Open an issue or submit a pull request with a brief description of the change.

## License

This project is available under the MIT License. See `LICENSE` for details.
