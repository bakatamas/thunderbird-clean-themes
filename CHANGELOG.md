# Changelog

## 1.1.5 (2026-10-28)

- Compose window: restyled to match the main window. Only the toolbar is tinted, with a filled accent Send button and accent icons. The From, To and Subject fields are borderless rows divided by thin lines, addresses are soft pills without the unknown-contact dot, and Cc/Bcc sit at the end of the From row. The formatting bar has accent icons, and the message body is a rounded, framed card with space around it. Attachments are pills, and the contacts sidebar uses the window tint with pill-shaped To/Cc/Bcc buttons. The menu bar stays visible. Thanks to u/oslogrolls for the idea.
- Reminder window: reminders sit on the page colour as rows with a soft hover, the selected one is a pill, and the Snooze and Dismiss buttons are pills.

## 1.1.4 (2026-10-22)

- Conversations stylesheet: the notification bars (blocked remote content, junk, outbox, calendar invitations) get a faint accent tint, rounded corners and pill-shaped buttons instead of the add-on's cyan. The scam and OpenPGP warnings are a soft red tint instead of a solid red bar. The themes themselves are unchanged.

## 1.1.3 (2026-10-22)

- Window buttons on Linux: hovering minimise or maximise filled the button with the text colour and hid the icon on KDE. They now get a light tint instead. Close keeps its own hover colour.
- Dialog windows on macOS: the title bar of dialogs such as folder properties showed the window behind it, and the reminder window was see-through. Their background is now painted.

## 1.1.2 (2026-10-13)

- Tabs: the selected tab carries an empty `selected` attribute, so the tab rules now check that it is present instead of looking for `selected="true"`. The active tab gets the content colour, hovering it no longer tints it, and in the Mono themes only inactive tabs are gray. Thanks to u/KenzieDamage.

## 1.1.1 (2026-10-13)

- All themes and the Conversations stylesheet use the system accent colour instead of Betterbird's blue. Icons and accent-coloured text are lightened in dark mode so a dark accent stays readable. Thanks to u/KenzieDamage.
- The status bar is painted in every theme. In the Auto themes it could show the desktop through it. Thanks to u/KenzieDamage.

## 1.1.0 (2026-10-13)

- New themes: Clean Auto and Clean Mono Auto, which follow the system's light or dark setting.

## 1.0.0 (2026-10-08)

- First release: Clean Light, Clean Dark, Clean Mono Light and Clean Mono Dark, and the Conversations stylesheet.
