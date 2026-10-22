# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Six Thunderbird/Betterbird (153+) themes ("Clean" and "Clean Mono", each in Light, Dark and Auto) plus an optional profile stylesheet for the Thunderbird Conversations add-on. Everything is plain CSS and WebExtension theme manifests. There are no tests, no linter and no package manager.

## Build

```sh
./build.sh
```

Writes the six `.xpi` files, `conversations-clean.css`, its README and an all-in-one `clean-themes-<version>.zip` into `dist/`, which is gitignored and wiped on every run. Needs `sh`, `sed` and `zip`. To try a change, install the built `.xpi` in Thunderbird via Add-ons and Themes → gear → Install Add-on From File.

## How the pieces fit together

- **One shared stylesheet.** `src/theme.css` goes into every theme. The build substitutes `@NAME@` and `@VERSION@` in its header from each manifest. For any theme whose directory name contains `mono`, `src/mono.css` is appended to it. Mono differs only by overriding tokens (for example `--cl-chrome: var(--cl-content)`) and a few rules, so keep shared behaviour in `theme.css`.
- **Light/dark come from one file.** Every colour in the stylesheets is a `light-dark()` pair. Each theme's `manifest.json` chooses the variant through `theme.properties.color_scheme` / `content_color_scheme` (`light`, `dark` or `system` for Auto). Fixed themes also set `theme.colors` (frame, toolbar, fields), and those values must match the `--cl-*` palette in `theme.css`. The Auto manifests have no `colors`.
- **Tokens first.** Section 1 of `theme.css` defines the `--cl-*` palette (content, chrome, hairline, text, accent) and maps Thunderbird's own variables (`--layout-background-*`, `--lwt-*`, `--selected-item-*` and so on) onto it. The later numbered sections (frame/tabs, spaces bar, status bar, folder pane, list header, compose, message list) style specific UI. Prefer changing a token over adding a rule.
- **Conventions in the CSS:** all rules sit inside `@media not (prefers-contrast)` so high-contrast mode is left alone. `!important` is used throughout because the application's sheets load after the theme's. The accent is the system `AccentColor`, and `--cl-accent-ink` lightens it in dark mode for icons and text.
- **Conversations stylesheet** (`conversations/conversations-clean.css`) is separate. It is not part of any theme, users copy it into their profile as `userContent.css`/`userChrome.css`, and its rules are scoped with `@-moz-document url-prefix("chrome://conversations/")`. It repeats the theme palette by hand, so colour changes in `theme.css` need to be mirrored there. Its selectors target Conversations 4.3.14 class names.
- The themes restyle internal Thunderbird UI (IDs and attributes such as `#messengerBody` and the tab `selected` attribute). These can change between releases, and the target environment is Betterbird 153 on Linux.

## Releasing a new version

1. Bump `"version"` in **all six** `themes/*/manifest.json`. `build.sh` aborts if any manifest differs from `clean-light`.
2. Update the version line at the top of `conversations/conversations-clean.css` and in `conversations/README.md`.
3. Add an entry to `CHANGELOG.md` (format: `## x.y.z (YYYY-MM-DD)` followed by bullets, with credits where due).
4. Run `./build.sh`.

Make stylesheet changes in `src/` and `conversations/`, never in `dist/`. Licence is MPL 2.0, and each CSS file keeps its MPL header.
