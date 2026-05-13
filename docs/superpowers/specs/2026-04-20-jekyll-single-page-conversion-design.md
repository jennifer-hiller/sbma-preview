# Jekyll Single-Page Conversion Design

Date: 2026-04-20
Repo: `sbma-preview`
Status: Approved for spec drafting

## Goal

Replace the current Vite/React single-page site with a Jekyll single-page site
that preserves the current visual output as closely as practical while removing
the React, Vite, Tailwind, and workspace tooling entirely.

The final site should be:

- static
- single-page
- plain CSS only
- deployable as a Jekyll build to Cloudflare Workers static assets

## Current State

The repository currently contains a Vite application:

- `index.html` bootstraps `/src/main.tsx`
- `src/app/App.tsx` composes the homepage from section components
- `src/app/components/*.tsx` contains the page sections
- `src/styles/*.css` contains the current style pipeline
- `package.json`, `vite.config.ts`, `postcss.config.mjs`, and
  `pnpm-workspace.yaml` support the frontend toolchain

This implementation is not Jekyll-native and carries a large dependency surface
that is unnecessary for the final static site.

## Chosen Approach

Use a minimal Jekyll site structure:

- `index.html` for the single page content
- `_layouts/default.html` for the document shell
- `assets/css/main.css` for all styles
- `assets/js/site.js` only if needed for small visual interactions
- `_config.yml`, `Gemfile`, and `README.md` for Jekyll and deployment

This keeps the site simple while still using a normal Jekyll layout pattern.

## Explicit Non-Goals

- Preserve React components or application architecture
- Preserve Vite, pnpm, Tailwind, PostCSS, or any Node-based build flow
- Introduce Sass, Liquid-driven content data models, or multi-page navigation
- Recreate non-essential stateful behavior that existed only because of React

## Visual Preservation Strategy

The current site is treated as a visual reference, not an implementation base.

Conversion rules:

- Rewrite each rendered section into semantic static HTML
- Preserve the visible hierarchy, spacing, typography, colors, and responsive
  layout as closely as practical
- Keep presentation-only motion only when it can be implemented cleanly in CSS
- Remove React-only behavior unless it is necessary to preserve visible output
- Prefer simple static markup over abstractions

## Target File Layout

Expected repository shape after conversion:

- `_config.yml`
- `Gemfile`
- `index.html`
- `_layouts/default.html`
- `assets/css/main.css`
- `assets/js/site.js` if needed
- `README.md`
- `wrangler.jsonc`

Generated output:

- `_site/`

Files and directories to remove if they are no longer needed:

- `src/`
- `package.json`
- `vite.config.ts`
- `postcss.config.mjs`
- `pnpm-workspace.yaml`
- any leftover Node-specific config or generated app scaffolding

## Architecture

### Page shell

`_layouts/default.html` owns:

- document structure
- metadata and viewport
- stylesheet and optional script tags
- the wrapper around `{{ content }}`

### Page content

`index.html` contains the full single-page markup in section order.

The markup should stay straightforward and readable rather than attempting to
model the previous component tree.

### Styling

`assets/css/main.css` contains all production styles.

Constraints:

- plain CSS only
- no Sass
- no utility framework dependency
- mobile and desktop layouts handled directly in CSS

### Client-side behavior

`assets/js/site.js` is optional. It may be used only for lightweight behavior
that materially affects the visible experience, such as a mobile navigation
toggle. No framework runtime should remain.

## Data Flow

There is no dynamic application data flow in the final design.

The page is rendered statically by Jekyll into `_site`. Any content that is
currently hard-coded in React components will become hard-coded HTML in the
single page unless a small amount of Liquid is required for layout plumbing.

## Error Handling

Primary risks and responses:

- Visual drift during conversion
  - Compare the rendered Jekyll page against the current React site section by
    section and adjust HTML/CSS until layout and styling align.
- Hidden dependency on React-only interaction
  - Rebuild only the minimal interaction in plain JavaScript if it is required
    for visible behavior.
- Public build leaking repository-only files
  - Ensure `_config.yml` excludes repo-only files such as `wrangler.jsonc`.

## Verification

Required checks:

- `bundle exec jekyll build` succeeds
- `_site` contains the converted single page and required assets
- `npx wrangler deploy --dry-run` recognizes `_site` as the static asset source

Manual validation:

- compare the Jekyll output against the current rendered page
- verify responsive behavior at common desktop and mobile widths
- verify any retained interaction works without React

## Implementation Outline

1. Inspect the current React page sections and styles to capture the rendered
   structure that must be preserved.
2. Create the minimal Jekyll scaffold.
3. Rewrite the page into static semantic HTML under `index.html`.
4. Port styling into `assets/css/main.css` using plain CSS only.
5. Add minimal JavaScript only if required for visible behavior.
6. Remove the Vite/React toolchain and leftover Node configuration.
7. Build and verify the Jekyll site locally.
8. Confirm Cloudflare deploy configuration still targets `_site`.

## Recommendation

Proceed with a direct replacement rather than a phased coexistence. The current
repo is a single-purpose landing page, so keeping both stacks would add cleanup
cost without providing meaningful value.
