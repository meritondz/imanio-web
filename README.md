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

3. **The store badges link nowhere.** Same reason: the app is in closed testing
   and has no public App Store or Play listing. See "Turning the store links
   on" below — it is one line each.

## Turning the store links on

At the bottom of `index.html`:

```js
const STORE_URLS = { ios: '', android: '' };
```

An empty string makes that badge show a short "bald" note and go nowhere. Put a
real URL in and the badge becomes an ordinary link that opens in a new tab.
Nothing else changes.

**Do both halves at once.** When you set the URL, also swap the badge artwork
for Apple's official "Download on the App Store" or Google's "Get it on Google
Play" badge. Those badges are licensed for linking to a live product page —
which is precisely what an empty string here says we do not have. Using them
before the listing exists would be both off-guideline and untrue, which is why
the current badges are drawn in the site's own style instead.

## Screenshots

`assets/screens/` holds four captures from a running simulator build —
`01-home` in the hero, and `02-player`, `03-quran`, `04-serie` in the "Ein Blick
in die App" section. They are downscaled to 720px wide; the sources live in the
workspace under `appstore-screenshots/` at 1284x2778 and are regenerable.

Retake them when the UI changes — a marketing site showing a layout that no
longer ships is worse than one showing none. The set was regenerated for
IM_013 (tile layout) and extended from one to four in IM_016.
