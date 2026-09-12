# imanio-web

The IMANIO website — a single static page, deployed by GitHub Pages from
`main`. No build step, no dependencies: `index.html` plus `assets/`.

Since the 2026-09-12 rebuild it is a **coming-soon page**: the product is not in either store
yet, so the page's one job is to collect beta testers. Everything else on it —
the screenshot rows, the content cards — exists to make that sign-up worth
filling in.

## Editing

Open `index.html`. Pushing to `main` deploys.

## The beta sign-up form — READ THIS BEFORE LAUNCH

The form in the `#beta` section is the point of the page. GitHub Pages serves
static files and cannot send mail, so the submission goes to **Web3Forms**,
which forwards it as an e-mail to `info@imanio-app.de`.

**It is not live until the access key is filled in.** At the bottom of
`index.html`:

```js
const WEB3FORMS_KEY = '';
```

Get a key at <https://web3forms.com>: enter `info@imanio-app.de`, and the key
arrives in that inbox within a minute. Paste it between the quotes — that is
the whole setup, there is no account and no dashboard to maintain. The key is
designed to be public: it identifies the destination inbox, which is fixed at
Web3Forms' end and cannot be pointed elsewhere by anyone reading the page
source.

**While the key is empty the form still works, but worse.** It falls back to
opening the visitor's mail client with the whole message pre-filled, addressed
to `info@imanio-app.de`. Nobody hits a dead end — but every visitor without a
configured mail client (most people on a work laptop, many on desktop
browsers) silently drops out, and you never learn they tried. Treat the empty
key as a launch blocker, not as a working state.

Spam is handled by a honeypot field (`botcheck`), hidden off-screen rather
than with `display:none`, which some bots skip.

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
`01-home` in the hero, and `02-player`, `03-quran`, `04-explore` in the three
alternating rows. They are downscaled to 720px wide and stored as **WebP**: the
same pictures as PNG came to 4.8 MB, which is most of a landing page's budget
spent before a word is read. The PNG sources live in the workspace under
`appstore-screenshots/2026-09-12/` and are regenerable. They are kept apart
from the files in `appstore-screenshots/` itself: those are the App Store
upload set at 1284x2778, a different size, and overwriting them would break
that upload.

```bash
sips --resampleWidth 720 shot.png --out tmp.png && cwebp -q 82 tmp.png -o shot.webp
```

Retake them when the UI changes — a marketing site showing a layout that no
longer ships is worse than one showing none. The set was regenerated for
IM_013 (tile layout), extended from one to four in IM_016, and retaken on
2026-09-12.

**How to retake them**, from the workspace root:

```bash
cd repos/imanio && ./scripts/screenshot.sh /home ../../appstore-screenshots/01-home.png
```

`screenshot.sh` temporarily rewrites the router's `initialLocation`, so no
tapping is needed. **The simulator must already hold a session** — the router
sends every unauthenticated request to `/welcome`, and you get four identical
pictures of the login screen without noticing. Tap "Als Gast fortfahren" once
in the simulator first; the session persists between runs.
