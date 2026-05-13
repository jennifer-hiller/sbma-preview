# South Bay Music Jekyll Site

This repository builds a multi-page South Bay Music website as a static Jekyll
site for Cloudflare Pages/Workers deployment.

## Local setup

This repo expects the Ruby toolchain used to create the lockfile. On this
machine that means the `rbenv` Ruby/Bundler shims rather than the system Ruby.

Recommended check:

```bash
/Users/jennhi/.rbenv/shims/ruby -v
/Users/jennhi/.rbenv/shims/bundle -v
```

## Local build

Generate the static site into `_site`:

```bash
/Users/jennhi/.rbenv/shims/bundle exec jekyll build
```

## Local serve

Run the local preview server:

```bash
/Users/jennhi/.rbenv/shims/bundle exec jekyll serve --host 127.0.0.1 --port 4010
```

## Verification

Run the static verification script after a build:

```bash
sh scripts/check-button-color-overrides.sh
```

The script verifies:

- required generated pages exist
- Give Lively placeholder regions are present
- legacy hash navigation is gone
- placeholder donor/leadership naming is absent

## Cloudflare deploy expectations

Cloudflare should deploy the generated Jekyll output from `_site`.

- Local dry-run verification:

```bash
env npm_config_cache=/tmp/npm-cache npx wrangler deploy --dry-run
```

- Expected behavior:
  Wrangler reads the built `_site` directory as the asset output.
  Run the Jekyll build before deploys so `_site` is current.
