# conversations-clean.css

Version 1.1.7. Part of the Clean theme collection by Tamás Baka. Licensed under the Mozilla Public License 2.0.

An optional companion to the Clean themes (**Clean Light**, **Clean Dark**, their single-surface variants **Clean Mono Light** and **Clean Mono Dark**, and **Clean Auto** and **Clean Mono Auto**, which follow the system light or dark setting). It restyles the reader of the [Thunderbird Conversations](https://addons.thunderbird.net/thunderbird/addon/gmail-conversation-view/) add-on so it matches the themes.

A theme cannot style the Conversations reader, because the add-on draws it in its own page. This stylesheet is loaded from your profile instead.

You only need it if you use Thunderbird Conversations. Without that add-on it does nothing.

## What it changes

- Removes the line and shadow under the subject row
- Removes the outline around each message
- Makes the subject larger
- Fades the header icons until you hover over them
- Sets the header to the same height as the folder pane and message list headers
- Uses the same background colour as the themes, in light and dark
- Turns the quick reply box into a plain text label with no box, fill or line around it
- Hides the reply, reply-all, reply-to-list and forward arrows under each message (all four are still in the message's own menu, and replying is also available from the reply fields)
- Shows the notification bars (blocked remote content, junk, outbox, calendar invitations) with a faint accent tint and rounded corners, and the scam and OpenPGP warnings as a soft red tint instead of a solid red bar
- Shows the "Forward this conversation" and "Print this conversation" links as small gray text
- In the expanded quick reply form: rounded fields with a soft outline and no fill, a filled send button and a quiet discard button

The font of the reply text box is left as the add-on sets it.

## Tested with

- Betterbird 153.4.0esr (Flatpak, Linux)
- Thunderbird Conversations, class names as of version 4.3.14 (notification bars checked against 4.3.16)

The stylesheet itself is the same on every system. The Windows and macOS steps below are written from Thunderbird's standard behaviour and have not been run on those systems, so treat them as untested. The same goes for plain Thunderbird on Linux.

## Install

The four steps are the same everywhere. Only the menus and folder locations differ, so each step lists them per system.

### 1. Turn on profile stylesheets

1. Open the settings:
   - **Windows and Linux:** menu (☰) > **Settings**
   - **macOS:** **Thunderbird** (or **Betterbird**) in the menu bar > **Settings**
2. On the **General** page, scroll to the bottom and click **Config Editor**.
3. Search for `toolkit.legacyUserProfileCustomizations.stylesheets`.
4. Set it to `true` (double-click the row, or use the toggle button on the right).

### 2. Open your profile folder

Open **Help > Troubleshooting Information**. If you see no menu bar on Windows or Linux, press **Alt**, or use menu (☰) > **Help**.

In the table, find the profile row and click its button:

| System | Row | Button |
|---|---|---|
| Windows | Profile Folder | Open Folder |
| macOS | Profile Folder | Show in Finder |
| Linux | Profile Directory | Open Directory |

This is the reliable way to find it, because it always shows the profile you are using right now.

If the button does nothing, the usual locations are:

| System | Usual location |
|---|---|
| Windows | `%APPDATA%\Thunderbird\Profiles\` |
| macOS | `~/Library/Thunderbird/Profiles/` |
| Linux | `~/.thunderbird/` |
| Linux, Snap | `~/snap/thunderbird/common/.thunderbird/` |
| Linux, Flatpak (Thunderbird) | `~/.var/app/org.mozilla.Thunderbird/.thunderbird/` |
| Linux, Flatpak (Betterbird) | `~/.var/app/eu.betterbird.Betterbird/.thunderbird/` |

Inside is a folder with a random-looking name, such as `ab12cd34.default-release`. That folder is the profile; it is the one that contains `prefs.js`. If there are several, use the path shown in Troubleshooting Information to tell which is yours.

Tips for getting there:

- **Windows:** press **Win + R**, paste `%APPDATA%\Thunderbird\Profiles` and press Enter.
- **macOS:** the Library folder is hidden. In Finder choose **Go > Go to Folder…**, paste `~/Library/Thunderbird/Profiles` and press Return.
- **Linux:** folders starting with a dot are hidden. Press **Ctrl + H** in the file manager to show them. In Flatpak builds the Open Directory button often does nothing; use the location from the table.

Betterbird normally keeps its profiles in the same place as Thunderbird, but go by the path Troubleshooting Information shows.

### 3. Copy the stylesheet

1. Inside the profile folder, create a folder named `chrome` (lower case) if there is none.
2. Copy `conversations-clean.css` into it **twice**, with these exact names:
   - `userContent.css`
   - `userChrome.css`

The names are case-sensitive on Linux, so keep the capital C in both.

If you already have a `userContent.css` or `userChrome.css`, do not replace it. Open it in a text editor and paste the contents of `conversations-clean.css` at the end.

Both copies are used because it has not been established which of the two the application applies to the add-on's page. The rules only match Conversations pages, so the extra copy is harmless.

**Windows: check the real file name.** File Explorer hides file extensions by default, so a file can end up as `userContent.css.css` or `userContent.css.txt` and silently do nothing. Turn on **View > Show > File name extensions** and make sure the names end in `.css` once.

If you prefer a terminal, these do the same thing. Run them in the folder where you downloaded `conversations-clean.css`, and put your own profile path in the first line. None of them overwrites an existing file.

Windows (PowerShell):

```powershell
$profile_dir = "$env:APPDATA\Thunderbird\Profiles\ab12cd34.default-release"
New-Item -ItemType Directory -Force "$profile_dir\chrome" | Out-Null
foreach ($name in "userContent.css", "userChrome.css") {
  if (-not (Test-Path "$profile_dir\chrome\$name")) { Copy-Item conversations-clean.css "$profile_dir\chrome\$name" }
}
```

macOS (Terminal):

```bash
PROFILE="$HOME/Library/Thunderbird/Profiles/ab12cd34.default-release"
mkdir -p "$PROFILE/chrome"
cp -n conversations-clean.css "$PROFILE/chrome/userContent.css"
cp -n conversations-clean.css "$PROFILE/chrome/userChrome.css"
```

Linux:

```bash
PROFILE="$HOME/.thunderbird/ab12cd34.default-release"
mkdir -p "$PROFILE/chrome"
cp -n conversations-clean.css "$PROFILE/chrome/userContent.css"
cp -n conversations-clean.css "$PROFILE/chrome/userChrome.css"
```

### 4. Restart

Quit the application completely and start it again. Profile stylesheets are only read at startup.

- **Windows and Linux:** closing the last window is enough, unless you use an add-on that keeps it running in the tray.
- **macOS:** closing the window does not quit. Use **Thunderbird > Quit** or press **Cmd + Q**.

## Update

Copy the new `conversations-clean.css` over both files in the `chrome` folder and restart.

If your browser saved the new download as `conversations-clean(1).css`, make sure you copy that file and not the older one.

## Remove

Delete `userContent.css` and `userChrome.css` from the `chrome` folder, or remove the `conversations-clean` section from them if they contain other rules. Then restart.

## Troubleshooting

**Nothing changed.** Check that the setting from step 1 is `true`, that both files are in the `chrome` folder of the profile you are actually using, that their names are exactly `userContent.css` and `userChrome.css` (on Windows, with no hidden second extension), and that you fully quit and restarted.

**Only some of it changed.** You probably have an older copy of the stylesheet. Copy the latest one again and restart.

**It stopped working after an add-on update.** The stylesheet targets the add-on's internal class names. If a Conversations update renames them, the affected rules silently stop applying. Nothing breaks, but the reader goes back to its default look until the stylesheet is updated.

**Clicking a message shows a soft glow around it.** That is the add-on's keyboard focus indicator. The stylesheet leaves it in place on purpose.
