# Jekyll Single-Page Conversion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the current Vite/React homepage with a Jekyll-built single-page site that preserves the current visual output using plain CSS only.

**Architecture:** Rebuild the rendered page as static semantic HTML under Jekyll, using one layout, one page, one CSS file, and only minimal vanilla JavaScript for any essential interaction such as the mobile nav toggle. Remove the Node/Vite toolchain entirely once the Jekyll version is in place and verified.

**Tech Stack:** Jekyll, Liquid layouts, plain CSS, optional vanilla JavaScript, Cloudflare Workers static assets, Bundler

---

## File Structure Map

### Source files to inspect during implementation

- `index.html`
  - Current Vite entry point to replace with Jekyll front matter and static page markup.
- `src/app/App.tsx`
  - Current section order reference.
- `src/app/components/Navigation.tsx`
  - Reference for mobile navigation behavior and nav links.
- `src/app/components/Hero.tsx`
  - Reference for hero structure and CTA hierarchy.
- `src/app/components/About.tsx`
  - Reference for about section content and stat layout.
- `src/app/components/Impact.tsx`
  - Reference for impact section content and card layout.
- `src/app/components/Programs.tsx`
  - Reference for programs section content and cards.
- `src/app/components/WaysToGive.tsx`
  - Reference for donation options section.
- `src/app/components/Events.tsx`
  - Reference for events section.
- `src/app/components/Contact.tsx`
  - Reference for contact section and any form-like markup.
- `src/app/components/Footer.tsx`
  - Reference for footer content.
- `src/styles/index.css`
  - Entry point that imports current styling layers.
- `src/styles/fonts.css`
  - Typography reference.
- `src/styles/theme.css`
  - Color/token reference.
- `default_shadcn_theme.css`
  - Additional token reference if needed.

### Files to create

- `_config.yml`
  - Jekyll site configuration and output exclusions.
- `Gemfile`
  - Minimal Bundler/Jekyll dependency definition.
- `_layouts/default.html`
  - Document shell and asset links.
- `assets/css/main.css`
  - Complete site styling in plain CSS.
- `assets/js/site.js`
  - Optional mobile nav toggle and any strictly necessary lightweight interaction.

### Files to modify

- `index.html`
  - Replace the Vite root/bootstrap with Jekyll front matter and the full static page markup.
- `README.md`
  - Replace Vite-oriented guidance with Jekyll build/deploy instructions.
- `wrangler.jsonc`
  - Confirm it still points to `_site` and remains excluded from generated output.

### Files to delete

- `src/main.tsx`
- `src/app/App.tsx`
- `src/app/components/`
- `src/styles/`
- `index.html` Vite bootstrap content
- `package.json`
- `vite.config.ts`
- `postcss.config.mjs`
- `pnpm-workspace.yaml`
- `default_shadcn_theme.css`
- any other Node-only leftover files discovered during implementation

### Verification artifacts

- `_site/`
  - Generated output from `bundle exec jekyll build`.

## Task 1: Capture the Current Rendered Site Structure

**Files:**
- Inspect: `src/app/App.tsx`
- Inspect: `src/app/components/Navigation.tsx`
- Inspect: `src/app/components/Hero.tsx`
- Inspect: `src/app/components/Impact.tsx`
- Inspect: `src/app/components/About.tsx`
- Inspect: `src/app/components/Programs.tsx`
- Inspect: `src/app/components/WaysToGive.tsx`
- Inspect: `src/app/components/Events.tsx`
- Inspect: `src/app/components/Contact.tsx`
- Inspect: `src/app/components/Footer.tsx`
- Inspect: `src/styles/index.css`
- Inspect: `src/styles/fonts.css`
- Inspect: `src/styles/theme.css`
- Inspect: `default_shadcn_theme.css`

- [ ] **Step 1: Record the section order from the current app shell**

Reference:

```tsx
<Navigation />
<main>
  <Hero />
  <Impact />
  <About />
  <Programs />
  <WaysToGive />
  <Events />
  <Contact />
</main>
<Footer />
```

- [ ] **Step 2: Extract the visible content and required behavior from each section**

Capture:

- nav link labels and CTA labels
- hero heading, subheading, CTA copy, and background treatment
- section ids used for anchor navigation
- card counts and copy groupings
- footer content
- whether the mobile nav toggle is the only required client-side behavior

- [ ] **Step 3: Identify which styles must be ported directly into plain CSS**

Track:

- typography scale
- section spacing
- background colors and gradients
- button treatments
- responsive breakpoints
- shadows, borders, and overlay treatments

- [ ] **Step 4: Verify no other runtime interaction is required beyond mobile navigation**

Run:

```bash
rg -n "useState|onClick|onSubmit|useEffect|motion|AnimatePresence" src/app src/app/components
```

Expected:

- navigation menu toggle is required
- no complex state model must survive the conversion

- [ ] **Step 5: Commit the inspection checkpoint**

```bash
git add docs/superpowers/plans/2026-04-20-jekyll-single-page-conversion.md
git commit -m "docs: add Jekyll conversion implementation plan"
```

## Task 2: Build the Minimal Jekyll Scaffold

**Files:**
- Create: `_config.yml`
- Create: `Gemfile`
- Create: `_layouts/default.html`
- Modify: `index.html`
- Modify: `wrangler.jsonc`

- [ ] **Step 1: Write the minimal Jekyll configuration**

Create `_config.yml`:

```yml
title: SB Music
description: Single-page music program site
baseurl: ""
url: ""
markdown: kramdown
permalink: pretty
exclude:
  - wrangler.jsonc
  - node_modules
  - package-lock.json
  - pnpm-lock.yaml
```

- [ ] **Step 2: Write the minimal Gemfile**

Create `Gemfile`:

```ruby
source "https://rubygems.org"

gem "jekyll"
```

- [ ] **Step 3: Create the Jekyll layout shell**

Create `_layouts/default.html`:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{{ page.title | default: site.title }}</title>
    <meta name="description" content="{{ page.description | default: site.description }}" />
    <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}" />
  </head>
  <body>
    {{ content }}
    <script src="{{ '/assets/js/site.js' | relative_url }}"></script>
  </body>
</html>
```

- [ ] **Step 4: Replace the Vite bootstrap in `index.html` with Jekyll front matter**

Start `index.html` with:

```html
---
layout: default
title: SB Music
description: Support music education access for every child
---
```

Expected:

- no `#root`
- no `/src/main.tsx`
- page content becomes real HTML

- [ ] **Step 5: Verify Jekyll recognizes the scaffold before the full page port**

Run:

```bash
bundle exec jekyll build
```

Expected:

- build completes
- `_site/index.html` exists

- [ ] **Step 6: Commit the scaffold**

```bash
git add _config.yml Gemfile _layouts/default.html index.html wrangler.jsonc
git commit -m "feat: scaffold Jekyll single-page site"
```

## Task 3: Port the Homepage Markup and Styling

**Files:**
- Modify: `index.html`
- Create: `assets/css/main.css`
- Create: `assets/js/site.js`
- Inspect: `src/app/components/*.tsx`
- Inspect: `src/styles/*.css`

- [ ] **Step 1: Rewrite the navigation, hero, and section markup into static HTML**

Required section ids:

- `home`
- `impact`
- `about`
- `programs`
- `ways-to-give`
- `events`
- `contact`

Include:

- header/nav
- main with all sections in the current order
- footer

- [ ] **Step 2: Add semantic wrappers and accessible controls**

Use:

- `<header>`, `<nav>`, `<main>`, `<section>`, `<footer>`
- button with `aria-expanded` and `aria-controls` for the mobile menu if menu JS is kept
- real anchor links for in-page navigation

- [ ] **Step 3: Port the current visual language into `assets/css/main.css`**

Implement:

- base reset and typography
- fixed nav styling
- hero image/overlay treatment
- CTA buttons
- section grids/cards
- mobile and desktop breakpoints
- spacing and color system

Do not use:

- Tailwind classes
- Sass
- CSS framework imports

- [ ] **Step 4: Recreate only the minimal required interaction in `assets/js/site.js`**

Use a small script like:

```js
const toggle = document.querySelector("[data-menu-toggle]");
const menu = document.querySelector("[data-mobile-menu]");

if (toggle && menu) {
  toggle.addEventListener("click", () => {
    const open = toggle.getAttribute("aria-expanded") === "true";
    toggle.setAttribute("aria-expanded", String(!open));
    menu.hidden = open;
  });
}
```

- [ ] **Step 5: Build and inspect the static output**

Run:

```bash
bundle exec jekyll build
```

Expected:

- `_site/index.html` contains the full page
- `_site/assets/css/main.css` exists
- `_site/assets/js/site.js` exists if the script is used

- [ ] **Step 6: Manually compare the Jekyll page with the current visual output**

Check:

- section order matches
- nav, hero, cards, and footer visually align
- mobile layout remains usable
- hero and CTA hierarchy still reads correctly

- [ ] **Step 7: Commit the page port**

```bash
git add index.html assets/css/main.css assets/js/site.js
git commit -m "feat: port homepage to static Jekyll markup"
```

## Task 4: Remove the React/Vite Toolchain and Finalize Docs

**Files:**
- Delete: `src/`
- Delete: `package.json`
- Delete: `vite.config.ts`
- Delete: `postcss.config.mjs`
- Delete: `pnpm-workspace.yaml`
- Delete: `default_shadcn_theme.css`
- Modify: `README.md`

- [ ] **Step 1: Remove the obsolete Node/Vite files**

Delete:

```text
src/
package.json
vite.config.ts
postcss.config.mjs
pnpm-workspace.yaml
default_shadcn_theme.css
```

- [ ] **Step 2: Rewrite `README.md` for the Jekyll workflow**

Document:

- local install with Bundler
- local build command
- optional local serve command
- Cloudflare deploy expectations

Example commands:

```bash
bundle install
bundle exec jekyll build
bundle exec jekyll serve
```

- [ ] **Step 3: Run the final local verification suite**

Run:

```bash
bundle exec jekyll build
env npm_config_cache=/tmp/npm-cache npx wrangler deploy --dry-run
```

Expected:

- Jekyll build succeeds
- Wrangler reads `_site` as the asset directory

- [ ] **Step 4: Verify no React/Vite references remain**

Run:

```bash
rg -n "vite|react-dom|createRoot|tailwind|postcss|pnpm-workspace" .
```

Expected:

- no active site code depends on the removed toolchain
- only historical docs or generated output remain if intentionally retained

- [ ] **Step 5: Commit the cleanup and docs**

```bash
git add -A
git commit -m "refactor: replace Vite app with Jekyll site"
```

## Task 5: Final Deployment Verification

**Files:**
- Verify: `_site/`
- Verify: `wrangler.jsonc`
- Verify: `README.md`

- [ ] **Step 1: Confirm generated output excludes repository-only config**

Run:

```bash
test ! -f _site/wrangler.jsonc
```

Expected:

- command exits successfully

- [ ] **Step 2: Confirm deploy config still targets static assets**

Inspect `wrangler.jsonc` for:

```json
{
  "assets": {
    "directory": "_site"
  }
}
```

- [ ] **Step 3: Push the finished conversion branch**

```bash
git push origin <branch-name>
```

- [ ] **Step 4: Record any follow-up items only if visual parity gaps remain**

Allowed follow-ups:

- spacing mismatch
- breakpoint tuning
- image crop tuning

Do not add unrelated enhancements.
