# Drop Calculator — Multi-Caliber

A dependency-free, installable rifle ballistics drop calculator that works **fully offline**.
Single-page web app, dark/amber tactical theme, mobile-first. Pick a cartridge and factory load,
set your zero and sight height, and get bullet drop, elevation correction (MOA + MIL with turret-click
counts), retained velocity, energy, time of flight, a full dope card, and a trajectory chart.

> ⚠️ **Estimation tool — always confirm your dope with live fire before relying on it.** See the
> in-app disclaimer. Solutions are theoretical and use manufacturer-published specs; your rifle and
> conditions will differ.

## Features

- **Embedded RK4 point-mass solver** (0.0008 s step) with the exact standard **G1 and G7** drag tables.
- **19 cartridges**, grouped (Rimfire · Varmint · AR Platform · Precision · Big Game · Magnum · Straight-Wall),
  each with 2–3 real factory loads (manufacturer-published muzzle velocity, BC, drag model).
- **Dope card** — full range table (drop / MOA / MIL / velocity / energy), nearest row tracks your target,
  transonic ranges flagged.
- **My Rifles** — save/name/switch rifle profiles (cartridge, load, zero, sight height, turret clicks,
  custom chrono loads) in the browser; remembers your last setup.
- **Simple ⇄ Expert mode:**
  - *Simple* — the quick scope adjustment.
  - *Expert* — adds **atmosphere** (temperature, pressure, altitude, humidity → air density + density
    altitude), **wind drift** (speed + clock direction), and **configurable turret clicks**.
- **PWA** — installable to your home screen, full offline use, dark/amber app icon.

## Accuracy / validation

The solver is validated against [py-ballisticcalc](https://github.com/o-murphy/py-ballisticcalc):

- Core trajectory: within **~0.2 in / 0.01 MOA** to 1000 yd.
- Expert atmosphere (density/drag, thin & humid air): within **~0.24 in** to 1000 yd.
- Expert wind drift (10 mph full-value crosswind): within **~0.06 in** to 1000 yd.
- Air-density formula (temp/pressure/altitude/humidity): within **~0.04%** of reference.

Simple mode is bit-identical to the originally validated 2-D solver (Expert is an additive path).
**If you change any ballistics math, re-validate against a reference and document the comparison.**

## Run locally

The service worker (offline/install) only activates over **https or localhost** — not `file://`.

```bash
cd drop-calculator
python3 -m http.server 8000
# open http://localhost:8000/
```

Opening `index.html` directly still works as a calculator; it just won't install/cache offline.

## Publish

The app uses **relative paths**, so it works at a site root or a sub-path.

**Netlify (drag & drop):** go to https://app.netlify.com/drop and drop the `drop-calculator` folder.
You get an HTTPS URL immediately; then "Add to Home Screen" on your phone for offline use.

**GitHub Pages:**

```bash
git remote add origin https://github.com/<you>/drop-calculator.git
git push -u origin main
```

Then repo **Settings → Pages → Build and deployment → Deploy from a branch → `main` / `/ (root)`**.
Served at `https://<you>.github.io/drop-calculator/`.

After publishing changes, the service worker serves the latest page when online (network-first);
bump `CACHE` in `sw.js` if you change the cached static assets (icons/manifest).

## Files

```
index.html          the whole app (HTML + CSS + JS inline)
manifest.json       PWA manifest
sw.js               service worker (offline app shell)
icon.svg            app icon source
icon-192/512.png    PWA icons   ·   apple-touch-icon.png (iOS)   ·   favicon-32.png
```

## License

MIT — see [LICENSE](LICENSE). Provided "as is", with no warranty; see the in-app safety disclaimer.
Cartridge/ammunition names and specifications are property of their respective manufacturers and are
used for identification only.
