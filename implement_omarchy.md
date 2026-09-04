# Implementation Guide: Missing Features & Omarchy Architecture

This document catalogs the features, systems, and agentic workflows present in [omarchy](file:///home/juderozario/omarchy) that are absent in [~/dotfiles](file:///home/juderozario/dotfiles), and details how each was designed and implemented in Omarchy so they can be adapted.

---

## 1. Architectural Philosophy: Monolithic Dotfiles vs. Layered Distribution Runtime

### The Difference
* **[~/dotfiles](file:///home/juderozario/dotfiles):** Operates on a monolithic symlink model via [arch_install.sh](file:///home/juderozario/dotfiles/arch_install.sh). The setup deletes existing configuration (`rm -rf`) and symlinks files directly from the repository to `~/.config/` and `$HOME`. There is no separation between default distribution configs and user tweaks, no state tracking, and no rollback mechanism.
* **[omarchy](file:///home/juderozario/omarchy):** Operates as a layered distribution runtime on top of Arch Linux. Immutable system defaults live in [default/](file:///home/juderozario/omarchy/default/) and initial user templates live in [config/](file:///home/juderozario/omarchy/config/). The environment variable `$OMARCHY_PATH` is passed at session startup via [default/uwsm/env.d/10-omarchy](file:///home/juderozario/omarchy/default/uwsm/env.d/10-omarchy) so all shell scripts, QML components, and hooks can locate core assets reliably.

### Implementation Pattern in Omarchy
* **Safe Configuration Refresh:** Instead of symlinks that get clobbered, Omarchy uses [`omarchy-refresh-config`](file:///home/juderozario/omarchy/bin/omarchy-refresh-config). When copying default configuration files to `~/.config/`, it automatically creates timestamped backups (e.g., `filename.bak`) if the destination file has local modifications.
* **Separation of Upstream & User Space:** User custom files live in `~/.config/omarchy/` (such as `~/.config/omarchy/hooks/`, `~/.config/omarchy/themes/`, and `~/.config/omarchy/extensions/`), which override or augment default system assets without causing git merge conflicts.

---

## 2. Desktop Shell: Native Quickshell Environment vs. Hybrid X11/Wayland Tools

### The Difference
* **[~/dotfiles](file:///home/juderozario/dotfiles):** Fragmented between legacy X11 tools ([i3](file:///home/juderozario/dotfiles/config/i3), [polybar](file:///home/juderozario/dotfiles/config/polybar), [picom](file:///home/juderozario/dotfiles/config/picom), [dunst](file:///home/juderozario/dotfiles/config/dunst), [rofi](file:///home/juderozario/dotfiles/config/rofi), [feh](file:///home/juderozario/dotfiles/.fehbg)) and isolated Wayland tools ([swaync](file:///home/juderozario/dotfiles/config/swaync), [waybar](file:///home/juderozario/dotfiles/config/waybar)).
* **[omarchy](file:///home/juderozario/omarchy):** A unified desktop shell written in QML using Quickshell ([shell/](file:///home/juderozario/omarchy/shell/)), run via `uwsm` and systemd.

### Implementation in Omarchy
* **Main Shell:** [shell/shell.qml](file:///home/juderozario/omarchy/shell/shell.qml) defines a singular desktop environment providing:
  * Top bar layout with configurable widget placements.
  * Native notification daemon and actionable notification center.
  * System tray protocol host.
  * Unified clipboard manager with search and history previews.
  * Audio input/output sink switcher and per-application volume sliders.
  * Brightness control with DDC/CI external monitor support.
  * Power menu, session logout, and lock screen trigger.
  * Interactive on-screen display (OSD) popups for volume, brightness, and caps lock changes.
* **Component Library in [shell/Ui/](file:///home/juderozario/omarchy/shell/Ui/):**
  * [`SpeedTestOverlay.qml`](file:///home/juderozario/omarchy/shell/Ui/SpeedTestOverlay.qml): On-screen real-time network speed testing.
  * [`KeyboardPanel.qml`](file:///home/juderozario/omarchy/shell/Ui/KeyboardPanel.qml): Graphical layout inspector for multi-language input.
  * [`SearchableDropdown.qml`](file:///home/juderozario/omarchy/shell/Ui/SearchableDropdown.qml), [`MultiSelect.qml`](file:///home/juderozario/omarchy/shell/Ui/MultiSelect.qml), and [`PanelSlider.qml`](file:///home/juderozario/omarchy/shell/Ui/PanelSlider.qml).
* **Application & Command Menu:** [default/omarchy/omarchy-menu.jsonc](file:///home/juderozario/omarchy/default/omarchy/omarchy-menu.jsonc) provides a schema-driven, JSON-configured application menu with custom provider integrations (files, emojis, clipboard history, timezone lookups).

---

## 3. Dynamic Templated Theming Engine

### The Difference
* **[~/dotfiles](file:///home/juderozario/dotfiles):** Themes are static files located in application directories (e.g. Alacritty TOML configs in [config/alacritty/themes/](file:///home/juderozario/dotfiles/config/alacritty/themes/), Vesktop CSS in [vesktopThemes/](file:///home/juderozario/dotfiles/vesktopThemes/), and Rofi themes in [rofiFonts/](file:///home/juderozario/dotfiles/rofiFonts/)). Switching themes requires manual intervention for each application.
* **[omarchy](file:///home/juderozario/omarchy):** A centralized, cross-application theming pipeline with live template rendering and IPC reloads.

### Implementation in Omarchy
* **Palette Definitions:** Themes under [themes/](file:///home/juderozario/omarchy/themes/) (`catppuccin`, `tokyo-night`, `gruvbox`, `nord`, `rose-pine`, `kanagawa`, `everforest`, etc.) define semantic color tokens (`accent`, `bg`, `fg`, `red`, `green`, `blue`, etc.) inside a standardized `colors.toml` file alongside matching wallpaper assets.
* **Dynamic Templates in [default/themed/](file:///home/juderozario/omarchy/default/themed/):**
  * `alacritty.toml.tpl`, `kitty.conf.tpl`, `foot.ini.tpl`, `ghostty.conf.tpl` (Terminal emulators).
  * `hyprland.lua.tpl` (Compositor window borders and accent colors).
  * `shell.toml.tpl` (Quickshell color scheme).
  * `btop.theme.tpl` (System monitor palette).
  * `neovim.lua.tpl`, `vscode-theme.json.tpl`, `helix.toml.tpl` (Code editors).
  * `obsidian.css.tpl` (Notes styling).
  * `keyboard.rgb.tpl` (Hardware keyboard backlight lighting).
* **CLI Engine:** [`omarchy-theme-set <name>`](file:///home/juderozario/omarchy/bin/omarchy-theme-set) parses the color tokens, renders all template files across the system, swaps desktop wallpaper across active monitors, updates GTK/Qt configs, and signals running processes without restarting the graphical session.

---

## 4. Modular Hyprland Lua Configuration

### The Difference
* **[~/dotfiles](file:///home/juderozario/dotfiles):** Uses a monolithic `hyprland.conf` with hardcoded window rules and bindings.
* **[omarchy](file:///home/juderozario/omarchy):** Structured Lua ecosystem under [default/hypr/](file:///home/juderozario/omarchy/default/hypr/) that separates concerns into isolated modules.

### Implementation in Omarchy
* **Initialization:** [default/hypr/bootstrap.lua](file:///home/juderozario/omarchy/default/hypr/bootstrap.lua) bootstraps the compositor and environment.
* **Per-Application Rule Modules in [default/hypr/apps/](file:///home/juderozario/omarchy/default/hypr/apps/):**
  * Dedicated rule scripts for applications: `steam.lua`, `battlenet.lua`, `1password.lua`, `bitwarden.lua`, `browser.lua`, `davinci-resolve.lua`, `jetbrains.lua`, `pip.lua`, `terminals.lua`.
* **Binding Categories in [default/hypr/bindings/](file:///home/juderozario/omarchy/default/hypr/bindings/):**
  * Modular keybindings split across `applications.lua`, `clipboard.lua`, `media.lua`, `tiling.lua`, `utilities.lua`, and `voxtype.lua`.
* **Dynamic Window Toggles in [default/hypr/toggles/](file:///home/juderozario/omarchy/default/hypr/toggles/):**
  * `single-window-aspect-ratio.lua`: Forces 16:9 or square ratios for ultrawide displays.
  * `window-no-gaps.lua`: Dynamically removes outer/inner gaps when only one window is present.

---

## 5. AI & Agentic Workflows, Telemetry & Skills

### What Is Missing in Dotfiles
`~/dotfiles` has no AI agent integrations, diagnostic tooling, or model telemetry.

### Implementation in Omarchy
* **Agent CLI Suite:**
  * [`omarchy-agent`](file:///home/juderozario/omarchy/bin/omarchy-agent): Primary entry point for invoking and configuring coding agents.
  * [`omarchy-agent-crash`](file:///home/juderozario/omarchy/bin/omarchy-agent-crash): Gathers core dumps, systemd journal logs, and recent stack traces to produce automated crash diagnosis reports.
  * [`omarchy-agent-prompt`](file:///home/juderozario/omarchy/bin/omarchy-agent-prompt): Manages and injects system instructions and project context for AI agents.
* **Usage & Token Analytics:**
  * [`omarchy-agent-usage-claude`](file:///home/juderozario/omarchy/bin/omarchy-agent-usage-claude), [`omarchy-agent-usage-codex`](file:///home/juderozario/omarchy/bin/omarchy-agent-usage-codex), [`omarchy-agent-usage-fireworks`](file:///home/juderozario/omarchy/bin/omarchy-agent-usage-fireworks), and [`omarchy-agent-usage-update`](file:///home/juderozario/omarchy/bin/omarchy-agent-usage-update): Real-time token usage, API rate limits, and cost accounting.
* **Embedded AI Agent Skills:**
  * [default/agents/skills/diagnose-crash/SKILL.md](file:///home/juderozario/omarchy/default/agents/skills/diagnose-crash/SKILL.md): Standardized procedure for an AI assistant to inspect logs, find root causes, and advise fixes.
  * [default/agents/skills/omarchy/SKILL.md](file:///home/juderozario/omarchy/default/agents/skills/omarchy/SKILL.md): Rules for AI agents regarding privilege escalation, script execution, package management, and testing.
* **AI Application Life Cycle:**
  * Quick installers/removers: [`omarchy-install-ai-chatgpt`](file:///home/juderozario/omarchy/bin/omarchy-install-ai-chatgpt), [`omarchy-remove-ai-ollama`](file:///home/juderozario/omarchy/bin/omarchy-remove-ai-ollama), [`omarchy-remove-ai-lm-studio`](file:///home/juderozario/omarchy/bin/omarchy-remove-ai-lm-studio).

---

## 6. Voxtype: Local Speech-to-Text Dictation Engine

### What Is Missing in Dotfiles
No voice dictation or local speech-to-text pipeline.

### Implementation in Omarchy
* **Whisper Integration:**
  * [`omarchy-voxtype-install`](file:///home/juderozario/omarchy/bin/omarchy-voxtype-install): Compiles and sets up the local Whisper engine.
  * [`omarchy-voxtype-model`](file:///home/juderozario/omarchy/bin/omarchy-voxtype-model): Downloads, switches, and configures quantized Whisper model files (base, small, medium, large).
  * [`omarchy-voxtype-config`](file:///home/juderozario/omarchy/bin/omarchy-voxtype-config) and [`omarchy-voxtype-status`](file:///home/juderozario/omarchy/bin/omarchy-voxtype-status): Configures language, input device, and prompt guidance.
* **Global Push-to-Talk:**
  * Wired into Hyprland via [default/hypr/bindings/voxtype.lua](file:///home/juderozario/omarchy/default/hypr/bindings/voxtype.lua). Holding down the hotkey records microphone input; releasing it runs inference through local Whisper and types the resulting text into the focused window using `ydotool` or `wtype`.

---

## 7. Event-Driven Hook System

### What Is Missing in Dotfiles
No event hook architecture. Scripts run only when manually triggered or in fixed autostart lists.

### Implementation in Omarchy
* **Hook Directories in [config/omarchy/hooks/](file:///home/juderozario/omarchy/config/omarchy/hooks/):**
  * `battery-low.d/`: Executed when battery drops below critical threshold (triggers warning sounds, switches power profiles).
  * `theme-set.d/`: Executed immediately after theme switching to update third-party apps or notify scripts.
  * `font-set.d/`: Executed after changing system typography.
  * `post-boot.d/`: Runs post-boot tasks such as weather retrieval and daemon verification.
  * `post-update.d/`: Dispatches update summary notifications and change logs to the user.
  * `pre-refresh-pacman.d/`: Injects custom mirrors or temporary repositories prior to package upgrades.
* **Execution:** Handled centrally by [`omarchy-hook-run`](file:///home/juderozario/omarchy/bin/omarchy-hook-run).

---

## 8. Screen Capture, OCR, QR & Media Pipelines

### What Is Missing in Dotfiles
`~/dotfiles` has basic `maim` and `xclip` commands for screenshots, with no OCR, QR decoding, or video recording pipelines.

### Implementation in Omarchy
* **Capture Utilities:**
  * [`omarchy-capture-ocr`](file:///home/juderozario/omarchy/bin/omarchy-capture-ocr): Interactive screen selector that passes cropped image data into Tesseract OCR and puts the extracted text into the clipboard buffer.
  * [`omarchy-capture-qr`](file:///home/juderozario/omarchy/bin/omarchy-capture-qr): Crops a QR code from the display, decodes it with `zbarimg`, and copies the link or opens it in a browser.
  * [`omarchy-capture-record`](file:///home/juderozario/omarchy/bin/omarchy-capture-record): Wayland screen and microphone audio recorder using hardware encoding.
  * [`omarchy-capture-area`](file:///home/juderozario/omarchy/bin/omarchy-capture-area) & [`omarchy-capture-window`](file:///home/juderozario/omarchy/bin/omarchy-capture-window): Advanced still capture with clipboard history insertion.
* **File Manager Media Extensions:**
  * [default/nautilus-python/extensions/transcode.py](file:///home/juderozario/omarchy/default/nautilus-python/extensions/transcode.py): Nautilus right-click context menu extension to convert, compress, and transcode media via [`omarchy-transcode`](file:///home/juderozario/omarchy/bin/omarchy-transcode).

---

## 9. Web Application (PWA) Engine & Native Chromium Extensions

### What Is Missing in Dotfiles
No web application creation or native messaging host integration.

### Implementation in Omarchy
* **Desktop PWA Generator:**
  * [`omarchy-webapp-install`](file:///home/juderozario/omarchy/bin/omarchy-webapp-install): Converts any website URL into an isolated desktop app with its own `.desktop` launcher, icon, window rules, and isolated Chromium user profile.
  * Specific handlers: [`omarchy-webapp-handler-hey`](file:///home/juderozario/omarchy/bin/omarchy-webapp-handler-hey), [`omarchy-webapp-handler-zoom`](file:///home/juderozario/omarchy/bin/omarchy-webapp-handler-zoom).
* **Native Messaging & Injected Extensions in [default/chromium/extensions/](file:///home/juderozario/omarchy/default/chromium/extensions/):**
  * `copy-url`: Interacts with a native messaging host ([default/chromium/native-messaging-hosts/com.omarchy.copy_url.json](file:///home/juderozario/omarchy/default/chromium/native-messaging-hosts/com.omarchy.copy_url.json)) so a system hotkey can extract the current URL from the browser without focusing it.
  * `yt-dlp`: Extension + native host ([default/chromium/native-messaging-hosts/com.omarchy.ytdlp.json](file:///home/juderozario/omarchy/default/chromium/native-messaging-hosts/com.omarchy.ytdlp.json)) for background video downloads.
  * `whatsapp-slim`: Injected dark mode CSS and simplified view.

---

## 10. Audio DSP Tuning & Acoustic Equalization

### What Is Missing in Dotfiles
No PipeWire filter chain architecture or acoustic corrections.

### Implementation in Omarchy
* **Acoustic Profiling:**
  * [`omarchy-audio-tuning`](file:///home/juderozario/omarchy/bin/omarchy-audio-tuning): Loads DSP filter chains into PipeWire.
  * Dell XPS acoustic calibration in [default/audio/tunings/dell-xps-2026/filter-chain.conf](file:///home/juderozario/omarchy/default/audio/tunings/dell-xps-2026/filter-chain.conf) providing parametric EQ, bass enhancement, and speaker protection.
* **Bluetooth Audio Optimization:**
  * [config/wireplumber/wireplumber.conf.d/bluetooth-a2dp-autoconnect.conf](file:///home/juderozario/omarchy/config/wireplumber/wireplumber.conf.d/bluetooth-a2dp-autoconnect.conf) automatically enforces high-fidelity A2DP codecs (LDAC, aptX HD) upon connection.

---

## 11. Hardware Detection & Peripheral RGB Integration

### What Is Missing in Dotfiles
No hardware detection or hardware-specific setup.

### Implementation in Omarchy
* **Hardware Probing Helpers:**
  * [`omarchy-hw-nvidia`](file:///home/juderozario/omarchy/bin/omarchy-hw-nvidia), [`omarchy-hw-asus-rog`](file:///home/juderozario/omarchy/bin/omarchy-hw-asus-rog), [`omarchy-hw-apple-silicon`](file:///home/juderozario/omarchy/bin/omarchy-hw-apple-silicon), [`omarchy-hw-framework16`](file:///home/juderozario/omarchy/bin/omarchy-hw-framework16), [`omarchy-hw-battery`](file:///home/juderozario/omarchy/bin/omarchy-hw-battery).
* **Hardware-Specific Provisioning in [install/hardware/](file:///home/juderozario/omarchy/install/hardware/):**
  * Nvidia environment and kernel driver settings ([default/hypr/nvidia.lua](file:///home/juderozario/omarchy/default/hypr/nvidia.lua)).
  * ASUS ROG G-Helper and `supergfxd` service delay unit.
  * Framework 16 QMK HID keyboard access rules ([default/udev/framework16-qmk-hid.rules](file:///home/juderozario/omarchy/default/udev/framework16-qmk-hid.rules)).
* **Keyboard RGB Lighting Sync:**
  * [`omarchy-theme-set-keyboard`](file:///home/juderozario/omarchy/bin/omarchy-theme-set-keyboard): Synchronizes keyboard backlights to current theme accent colors.
  * Vendor scripts: [`omarchy-theme-set-keyboard-asus-rog`](file:///home/juderozario/omarchy/bin/omarchy-theme-set-keyboard-asus-rog) and [`omarchy-theme-set-keyboard-f16`](file:///home/juderozario/omarchy/bin/omarchy-theme-set-keyboard-f16).

---

## 12. Security, Authentication & Hardware Tokens

### What Is Missing in Dotfiles
No security key, fingerprint, or authentication hardening scripts.

### Implementation in Omarchy
* **FIDO2 & Hardware Tokens:**
  * [`omarchy-setup-security-fido2`](file:///home/juderozario/omarchy/bin/omarchy-setup-security-fido2) and [`omarchy-remove-security-fido2`](file:///home/juderozario/omarchy/bin/omarchy-remove-security-fido2): Automates PAM configuration for YubiKey and FIDO2 keys for sudo and login.
* **Biometric Authentication:**
  * [`omarchy-setup-security-fingerprint`](file:///home/juderozario/omarchy/bin/omarchy-setup-security-fingerprint): Configures `fprintd` for fingerprint reader enrollment.
* **Privilege & Docker Security:**
  * [`omarchy-setup-security-sudoless-docker`](file:///home/juderozario/omarchy/bin/omarchy-setup-security-sudoless-docker), [`omarchy-setup-security-sshd`](file:///home/juderozario/omarchy/bin/omarchy-setup-security-sshd), [`omarchy-sudo-keepalive`](file:///home/juderozario/omarchy/bin/omarchy-sudo-keepalive).

---

## 13. Networking, Tailscale & Local Sharing

### What Is Missing in Dotfiles
No automated file sharing or network sharing tools.

### Implementation in Omarchy
* **Tailscale File Drop:**
  * [`omarchy-tailscale-send`](file:///home/juderozario/omarchy/bin/omarchy-tailscale-send) and [`omarchy-tailscale-receive`](file:///home/juderozario/omarchy/bin/omarchy-tailscale-receive).
  * [default/systemd/user/omarchy-tailscale-receive.service](file:///home/juderozario/omarchy/default/systemd/user/omarchy-tailscale-receive.service) continuously listens for incoming files and triggers desktop notifications.
* **Wi-Fi QR Sharing:**
  * [`omarchy-network-qr`](file:///home/juderozario/omarchy/bin/omarchy-network-qr): Generates terminal ASCII QR codes for instant mobile device connections.
* **LocalSend File Sharing:**
  * [default/nautilus-python/extensions/localsend.py](file:///home/juderozario/omarchy/default/nautilus-python/extensions/localsend.py): Direct right-click send via LocalSend.

---

## 14. Windows Virtualization (Winboat & QEMU)

### What Is Missing in Dotfiles
No VM automation.

### Implementation in Omarchy
* **Provisioning Automation:**
  * [`omarchy-windows-vm`](file:///home/juderozario/omarchy/bin/omarchy-windows-vm): Downloads official Windows ISOs, provisions QEMU/KVM virtual machines with VirtIO storage and network drivers, enables 3D GPU acceleration, and forwards individual Windows applications directly onto the Linux desktop via Winboat.
  * [`omarchy-windows-key`](file:///home/juderozario/omarchy/bin/omarchy-windows-key): Injects activation keys into the virtual machine.

---

## 15. Gaming Stack Provisioning

### What Is Missing in Dotfiles
`~/dotfiles` lists gaming packages in a flat list with other tools in `arch_install.sh`.

### Implementation in Omarchy
* **Modular Gaming Installers:**
  * Automated setup and cleanup scripts: [`omarchy-install-gaming-steam`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-steam), [`omarchy-install-gaming-battlenet`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-battlenet), [`omarchy-install-gaming-geforce-now`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-geforce-now), [`omarchy-install-gaming-heroic`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-heroic), [`omarchy-install-gaming-lutris`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-lutris), [`omarchy-install-gaming-retroarch`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-retroarch), [`omarchy-install-gaming-xbox-cloud`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-xbox-cloud), [`omarchy-install-gaming-xbox-controllers`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-xbox-controllers), [`omarchy-install-gaming-gpu-lib32`](file:///home/juderozario/omarchy/bin/omarchy-install-gaming-gpu-lib32).
  * Accompanied by removal scripts (`omarchy-remove-gaming-*`).

---

## 16. System Snapshots, Recovery & Maintenance

### What Is Missing in Dotfiles
No snapshot management, automated backups, or recovery workflows.

### Implementation in Omarchy
* **Snapper / Btrfs Snapshots:**
  * Integrated with pacman hooks ([default/snapper/root](file:///home/juderozario/omarchy/default/snapper/root)) to take automatic pre/post transaction snapshots during system upgrades.
  * CLI interface: [`omarchy-snapshot`](file:///home/juderozario/omarchy/bin/omarchy-snapshot).
* **Factory Reset & Recovery:**
  * [`omarchy-system-factory-reset`](file:///home/juderozario/omarchy/bin/omarchy-system-factory-reset) and [`omarchy-system-factory-reset-finish`](file:///home/juderozario/omarchy/bin/omarchy-system-factory-reset-finish): Re-initializes system configuration while preserving user data.
  * [`omarchy-reinstall-configs`](file:///home/juderozario/omarchy/bin/omarchy-reinstall-configs) and [`omarchy-reinstall-pkgs`](file:///home/juderozario/omarchy/bin/omarchy-reinstall-pkgs).

---

## 17. System Toggles & Hardware Controls

### What Is Missing in Dotfiles
No unified toggle commands for hardware and desktop states.

### Implementation in Omarchy
* **Toggle Suite:**
  * [`omarchy-toggle-bar`](file:///home/juderozario/omarchy/bin/omarchy-toggle-bar): Shows/hides top bar.
  * [`omarchy-toggle-idle`](file:///home/juderozario/omarchy/bin/omarchy-toggle-idle): Caffeine mode (inhibits sleep and screen turn-off).
  * [`omarchy-toggle-nightlight`](file:///home/juderozario/omarchy/bin/omarchy-toggle-nightlight): Toggles blue-light filter via `hyprsunset`.
  * [`omarchy-toggle-screensaver`](file:///home/juderozario/omarchy/bin/omarchy-toggle-screensaver): Starts terminal/QML screensavers.
  * [`omarchy-toggle-touchpad`](file:///home/juderozario/omarchy/bin/omarchy-toggle-touchpad) & [`omarchy-toggle-touchscreen`](file:///home/juderozario/omarchy/bin/omarchy-toggle-touchscreen).
  * [`omarchy-toggle-hybrid-gpu`](file:///home/juderozario/omarchy/bin/omarchy-toggle-hybrid-gpu): Toggles discrete vs. integrated graphics on hybrid laptops.
  * [`omarchy-toggle-notification-silencing`](file:///home/juderozario/omarchy/bin/omarchy-toggle-notification-silencing): Do-not-disturb toggle.

---

## 18. Modular Bash Productivity Functions

### What Is Missing in Dotfiles
`~/dotfiles` has a single `.zshrc` with personal aliases, lacking reusable CLI productivity functions.

### Implementation in Omarchy
Modular bash functions under [default/bash/fns/](file:///home/juderozario/omarchy/default/bash/fns/):
* [`compression`](file:///home/juderozario/omarchy/default/bash/fns/compression): `compress` and `extract` commands handling all archive formats (`tar`, `gz`, `zst`, `7z`, `zip`, `bz2`).
* [`worktrees`](file:///home/juderozario/omarchy/default/bash/fns/worktrees): Git worktree management shortcuts.
* [`herdr`](file:///home/juderozario/omarchy/default/bash/fns/herdr): Multi-repository git workspace manager integration.
* [`drives`](file:///home/juderozario/omarchy/default/bash/fns/drives): Safe USB drive mounting and disk utilities.
* [`tmux`](file:///home/juderozario/omarchy/default/bash/fns/tmux): Smart session attachment and layout restoration.
* [`ssh-port-forwarding`](file:///home/juderozario/omarchy/default/bash/fns/ssh-port-forwarding) & [`ssh-reconnect`](file:///home/juderozario/omarchy/default/bash/fns/ssh-reconnect).
* [`rsyncing`](file:///home/juderozario/omarchy/default/bash/fns/rsyncing): Resumable high-speed directory sync with progress indicators.

---

## 19. Incremental Implementation Roadmap for ~/dotfiles

To incorporate these capabilities into your dotfiles without breaking your current workflow, adopt them in this order:

1. **Adopt the Layered Path Pattern:**
   * Introduce a core path variable (e.g. `$DOTFILES_PATH`) in your shell profile.
   * Separate immutable defaults from user overrides.
   * Replace destructive `rm -rf` commands in `arch_install.sh` with safe backup-refresh logic.
2. **Implement Dynamic Theming:**
   * Create a `themes/` directory with a `colors.toml` per palette.
   * Template your terminal configurations (Alacritty, Kitty) using template files.
   * Add a `theme-set` bash script to render templates and reload configurations dynamically.
3. **Add the Capture & OCR Suite:**
   * Add `capture-ocr` (using `grim`, `slurp`, and `tesseract`) and `capture-qr` (using `zbar`).
   * Bind them to compositor shortcuts.
4. **Deploy Voxtype Local Speech-to-Text:**
   * Compile `whisper.cpp` or install `faster-whisper`.
   * Configure a push-to-talk keybind in Hyprland that dumps transcribed speech to the active window.
5. **Modularize Hyprland Configs:**
   * Break down monolithic Hyprland configs into modular files (`apps.conf`, `bindings.conf`, `monitors.conf`).
6. **Integrate User Hooks:**
   * Add a `hooks/` directory (`theme-set.d/`, `battery-low.d/`, `post-update.d/`) to let scripts respond to system lifecycle events.
