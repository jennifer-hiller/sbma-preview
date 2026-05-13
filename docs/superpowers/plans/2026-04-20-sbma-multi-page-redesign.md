# SBMA Multi-Page Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the current single-page SB Music Jekyll site into a donor-led, multi-page cultural institution website with a refined visual system and Give Lively-ready support flows.

**Architecture:** Keep the site on Jekyll and static assets. Split the current monolithic homepage into page-specific Jekyll documents backed by shared layout, navigation, footer, and reusable institutional content sections. Refactor CSS so the visual system supports multiple page templates and ensemble/editorial/support surfaces without one-off styling drift.

**Tech Stack:** Jekyll, HTML, CSS, minimal JavaScript, Cloudflare static deploy from `_site`

---

## File Structure

### Existing files to modify

- Modify: `index.html`
  - Convert from the current single-page homepage into the new donor-led multi-page homepage.
- Modify: `_layouts/default.html`
  - Support a multi-page shell with consistent metadata, header/footer placement, and shared asset loading.
- Modify: `assets/css/main.css`
  - Replace the current single-page styling approach with a reusable multi-page design system.
- Modify: `assets/js/site.js`
  - Keep only lightweight interactions needed across pages, primarily navigation behavior.
- Modify: `README.md`
  - Update documentation to describe the multi-page site and local verification.

### New page files to create

- Create: `about.html`
- Create: `impact.html`
- Create: `ensembles.html`
- Create: `join.html`
- Create: `support.html`
- Create: `donate.html`
- Create: `events.html`
- Create: `updates.html`
- Create: `press.html`
- Create: `shop.html`
- Create: `ensembles/west-coast-wind-symphony.html`
- Create: `ensembles/south-bay-concert-band.html`
- Create: `ensembles/beach-city-swing-band.html`
- Create: `ensembles/segundo-saxes.html`
- Create: `ensembles/el-segundo-brass-ensemble.html`

### Verification and helper files

- Modify or replace: `scripts/check-button-color-overrides.sh`
  - Expand or replace with a broader static verification script for page existence and key content markers if needed.

---

### Task 1: Define the multi-page shell

**Files:**
- Modify: `_layouts/default.html`
- Modify: `assets/js/site.js`
- Test: local browser verification via Jekyll serve

- [ ] **Step 1: Inspect the current default layout and nav script**

Run:
```bash
sed -n '1,220p' _layouts/default.html
sed -n '1,240p' assets/js/site.js
```

Expected: understand which parts can be retained for multi-page navigation and which are homepage-specific.

- [ ] **Step 2: Write the failing structural expectations**

Document the required shell behavior in working notes before editing:
- header appears on every page
- nav links route to real pages instead of homepage anchors
- footer is shared across pages
- persistent `Become a Patron` and `Donate` actions exist

Expected: a clear target for the layout rewrite.

- [ ] **Step 3: Implement the shared multi-page shell**

Update `_layouts/default.html` so it:
- renders a shared header/nav
- renders `{{ content }}`
- renders a shared institutional footer with social links
- preserves CSS/JS asset loading

Update `assets/js/site.js` so the mobile menu still works for page navigation.

- [ ] **Step 4: Run a Jekyll build to verify the shell compiles**

Run:
```bash
bundle exec jekyll build
```

Expected: PASS with `_site` generated successfully.

- [ ] **Step 5: Commit**

```bash
git add _layouts/default.html assets/js/site.js
git commit -m "feat: add shared multi-page site shell"
```

---

### Task 2: Replace the homepage with the donor-led institutional version

**Files:**
- Modify: `index.html`
- Modify: `assets/css/main.css`
- Test: homepage renders with new hierarchy

- [ ] **Step 1: Define the homepage content blocks**

Draft the homepage block order directly from the spec:
- institutional hero
- mission/regional role
- impact
- featured ensembles
- support/patron section with Give Lively-ready area
- events
- updates/press highlights

Expected: no leftover single-page anchor architecture.

- [ ] **Step 2: Write a failing content check for homepage markers**

Run after implementation planning:
```bash
bundle exec jekyll build
rg -n "Sustaining South Bay|Become a Patron|Support the Season|Give Lively" _site/index.html
```

Expected before implementation: one or more required markers missing.

- [ ] **Step 3: Implement the new homepage markup**

Rewrite `index.html` so it becomes the donor-led institutional homepage with:
- no legacy one-page navigation anchors
- strong support CTAs
- refined institutional content hierarchy

- [ ] **Step 4: Implement homepage-specific visual styling**

Add or refactor CSS in `assets/css/main.css` for:
- institutional hero
- asymmetric editorial sections
- refined CTA treatments
- support embed module
- homepage highlight modules

- [ ] **Step 5: Re-run the homepage content check**

Run:
```bash
bundle exec jekyll build
rg -n "Sustaining South Bay|Become a Patron|Support the Season|Give Lively" _site/index.html
```

Expected: all required markers present.

- [ ] **Step 6: Commit**

```bash
git add index.html assets/css/main.css
git commit -m "feat: redesign homepage for donor-led institution flow"
```

---

### Task 3: Build the core institutional pages

**Files:**
- Create: `about.html`
- Create: `impact.html`
- Create: `support.html`
- Create: `donate.html`
- Modify: `assets/css/main.css`
- Test: generated pages exist in `_site`

- [ ] **Step 1: Create the `About` page**

Include:
- mission statement
- institutional history
- unnamed leadership/governance section

- [ ] **Step 2: Create the `Impact` page**

Include:
- community impact
- education/community participation
- donor-facing proof framing

- [ ] **Step 3: Create the `Support` page**

Include:
- patronage framing
- case for support
- Give Lively-ready embed container

- [ ] **Step 4: Create the `Donate` page**

Include:
- direct conversion-oriented intro
- Give Lively-ready embed container
- short trust copy

- [ ] **Step 5: Add shared page-template styling**

Refactor CSS so these pages use consistent:
- page hero pattern
- section spacing
- editorial content blocks
- embed region styling

- [ ] **Step 6: Verify generated pages**

Run:
```bash
bundle exec jekyll build
test -f _site/about/index.html
test -f _site/impact/index.html
test -f _site/support/index.html
test -f _site/donate/index.html
```

Expected: all files exist.

- [ ] **Step 7: Commit**

```bash
git add about.html impact.html support.html donate.html assets/css/main.css
git commit -m "feat: add core institutional and support pages"
```

---

### Task 4: Build ensembles and recruitment pages

**Files:**
- Create: `ensembles.html`
- Create: `join.html`
- Create: `ensembles/west-coast-wind-symphony.html`
- Create: `ensembles/south-bay-concert-band.html`
- Create: `ensembles/beach-city-swing-band.html`
- Create: `ensembles/segundo-saxes.html`
- Create: `ensembles/el-segundo-brass-ensemble.html`
- Modify: `assets/css/main.css`
- Test: page generation and link structure

- [ ] **Step 1: Create the ensembles landing page**

Include:
- intro framing ensembles as the living body of the institution
- linked entries for each ensemble
- support CTA

- [ ] **Step 2: Create the `Join the Band` page**

Include:
- recruitment framing
- participation expectations
- inquiry CTA

- [ ] **Step 3: Create the five ensemble detail pages**

Each page should include:
- overview copy
- rehearsal/performance profile
- community role
- support CTA
- join CTA when relevant

- [ ] **Step 4: Add ensemble page styling**

Implement reusable CSS for:
- ensemble index listings
- ensemble page hero
- info blocks
- CTA rows

- [ ] **Step 5: Verify generated ensemble pages**

Run:
```bash
bundle exec jekyll build
test -f _site/ensembles/index.html
test -f _site/join/index.html
test -f _site/ensembles/west-coast-wind-symphony/index.html
test -f _site/ensembles/south-bay-concert-band/index.html
test -f _site/ensembles/beach-city-swing-band/index.html
test -f _site/ensembles/segundo-saxes/index.html
test -f _site/ensembles/el-segundo-brass-ensemble/index.html
```

Expected: all files exist.

- [ ] **Step 6: Commit**

```bash
git add ensembles.html join.html ensembles assets/css/main.css
git commit -m "feat: add ensembles and recruitment pages"
```

---

### Task 5: Build events, updates, press, and shop

**Files:**
- Create: `events.html`
- Create: `updates.html`
- Create: `press.html`
- Create: `shop.html`
- Modify: `assets/css/main.css`
- Test: content markers and page generation

- [ ] **Step 1: Create the `Events` page**

Include:
- featured performance block
- event list structure
- support CTA

- [ ] **Step 2: Create the `Updates` page with starter content**

Add several article-style starter entries with:
- title
- short excerpt
- date/category treatment

- [ ] **Step 3: Create the `Press` page with starter content**

Add:
- media/coverage cards
- press framing copy
- contact/media block

- [ ] **Step 4: Create the `Shop` page**

Add:
- support-through-purchase framing
- starter merchandise/support modules

- [ ] **Step 5: Add editorial/listing styling**

Implement reusable CSS for:
- updates list cards
- press/media blocks
- event rows
- shop modules

- [ ] **Step 6: Verify generated pages and starter content**

Run:
```bash
bundle exec jekyll build
test -f _site/events/index.html
test -f _site/updates/index.html
test -f _site/press/index.html
test -f _site/shop/index.html
rg -n "Updates|Press|Season|Support the Season" _site/updates/index.html _site/press/index.html
```

Expected: files exist and starter content markers are present.

- [ ] **Step 7: Commit**

```bash
git add events.html updates.html press.html shop.html assets/css/main.css
git commit -m "feat: add editorial, events, and shop pages"
```

---

### Task 6: Unify styling and remove obsolete single-page assumptions

**Files:**
- Modify: `assets/css/main.css`
- Modify: `assets/js/site.js`
- Modify: any page files still carrying anchor-era assumptions
- Test: static search and browser verification

- [ ] **Step 1: Search for obsolete single-page anchor assumptions**

Run:
```bash
rg -n 'href="#|id=" index.html about.html impact.html support.html donate.html events.html updates.html press.html shop.html ensembles.html join.html ensembles'
```

Expected before cleanup: find legacy anchor-style navigation or section coupling that no longer belongs.

- [ ] **Step 2: Remove obsolete one-page assumptions**

Replace old homepage anchor navigation with page navigation where needed and remove orphaned single-page-specific IDs/classes that no longer serve routing or styling.

- [ ] **Step 3: Normalize global visual consistency**

Ensure CSS covers:
- consistent header/footer behavior
- consistent button/CTA language styles
- page-to-page spacing rhythm
- no white-on-white regressions or section-specific override leaks

- [ ] **Step 4: Run static searches and build**

Run:
```bash
bundle exec jekyll build
rg -n 'href="#' _site
```

Expected: no stray page-level anchor routing used for primary navigation.

- [ ] **Step 5: Commit**

```bash
git add assets/css/main.css assets/js/site.js index.html about.html impact.html support.html donate.html events.html updates.html press.html shop.html ensembles.html join.html ensembles
git commit -m "refactor: remove legacy single-page assumptions"
```

---

### Task 7: Update verification scripts and documentation

**Files:**
- Modify: `scripts/check-button-color-overrides.sh`
- Modify: `README.md`
- Test: script output and build output

- [ ] **Step 1: Replace or expand the current verification script**

Update the script so it checks for redesign-critical conditions such as:
- required generated pages exist
- no forbidden donor/leadership names are hardcoded
- support pages contain a Give Lively-ready region marker

- [ ] **Step 2: Update the README**

Document:
- multi-page structure
- local build/serve flow
- expected verification commands

- [ ] **Step 3: Run the verification script and build**

Run:
```bash
sh scripts/check-button-color-overrides.sh
bundle exec jekyll build
```

Expected: both commands pass.

- [ ] **Step 4: Commit**

```bash
git add scripts/check-button-color-overrides.sh README.md
git commit -m "docs: update verification and site documentation"
```

---

### Task 8: Final verification

**Files:**
- Verify: `_site/`
- Verify: all site source files touched above

- [ ] **Step 1: Run final build**

Run:
```bash
bundle exec jekyll build
```

Expected: PASS.

- [ ] **Step 2: Serve locally and verify manually**

Run:
```bash
bundle exec jekyll serve --host 127.0.0.1 --port 4010
```

Check:
- homepage hierarchy and donor framing
- page navigation
- support and donate embed regions
- updates and press starter content
- ensemble page routing
- footer/social presence

- [ ] **Step 3: Run final static checks**

Run:
```bash
sh scripts/check-button-color-overrides.sh
rg -n "Give Lively|Become a Patron|Donate" _site
```

Expected: verification passes and support markers are present across the right pages.

- [ ] **Step 4: Final commit**

```bash
git add _layouts/default.html assets/css/main.css assets/js/site.js index.html about.html impact.html ensembles.html join.html support.html donate.html events.html updates.html press.html shop.html ensembles README.md scripts/check-button-color-overrides.sh
git commit -m "feat: launch multi-page donor-led cultural institution site"
```
