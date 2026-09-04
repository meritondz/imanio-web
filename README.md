# imanio-web

The IMANIO website — a single static page, deployed by GitHub Pages from
`main`. No build step, no dependencies: `index.html` plus `assets/`.

## Editing

Open `index.html`. Pushing to `main` deploys.

## Before this is really finished

Two things were deliberately **left blank rather than invented**, because
getting them wrong is worse than leaving them:

1. **The Impressum is incomplete.** It carries the company name and the support
   address; the postal address, the represented person, the registering court
   and the HRB number are missing. A German commercial site needs all of them
   under § 5 DDG — an incomplete one is a real Abmahnung risk. The gap is
   marked with a comment in `index.html`.
2. **The social channels do not exist yet.** Instagram, TikTok and YouTube are
   rendered as disabled "bald" chips, not as links. Pointing them at guessed
   handles would send visitors to accounts belonging to someone else. When the
   accounts exist, replace each `<span>` in the "Folge IMANIO" section with an
   `<a href="…">` — and update `AppConstants.socialLinks` in the app
   (`repos/imanio/lib/core/constants/app_constants.dart`), which is the single
   place the app reads them from.

The store buttons are disabled for the same reason: the app is in closed
testing and has no public App Store or Play listing yet.

## Screenshot

`assets/screen-home.png` is taken from a running simulator build. Retake it
when the UI changes — a marketing site showing a layout that no longer ships is
worse than one showing none. It was regenerated for IM_013, which changed the
tiles.
