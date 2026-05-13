#!/bin/sh

set -eu

site_dir="_site"

if [ ! -d "_events" ]; then
  echo "Missing _events collection directory"
  exit 1
fi

if ! rg -q "events:" "_config.yml"; then
  echo "Missing events collection in _config.yml"
  exit 1
fi

if ! rg -q "name: 'events'" "admin/config.yml"; then
  echo "Missing events collection in Decap CMS config"
  exit 1
fi

if ! rg -q "folder: '_events/'" "admin/config.yml"; then
  echo "Decap CMS events collection should write to _events/"
  exit 1
fi

if ! rg -q "name: 'pieces'" "admin/config.yml"; then
  echo "Missing optional pieces list in Decap CMS events collection"
  exit 1
fi

if ! rg -q "name: 'composer'" "admin/config.yml"; then
  echo "Missing composer field for event pieces in Decap CMS config"
  exit 1
fi

if ! rg -q "site.events" "_includes/events-feed.html"; then
  echo "Events feed should render from the Jekyll events collection"
  exit 1
fi

if ! rg -q "event.pieces" "_includes/events-feed.html"; then
  echo "Events feed should render optional event piece metadata"
  exit 1
fi

if ! rg -q "\.event-program" "assets/css/main.css"; then
  echo "Missing event program styling"
  exit 1
fi

if [ ! -f "$site_dir/events/index.html" ]; then
  echo "Missing generated events page"
  exit 1
fi

if ! rg -q "America at 250" "$site_dir/events/index.html"; then
  echo "Expected generated events page to include collection-backed concert content"
  exit 1
fi

if ! rg -q "John Williams" "$site_dir/events/index.html"; then
  echo "Expected generated events page to include optional composer metadata"
  exit 1
fi

if ! rg -q "America at 250" "$site_dir/ensembles/west-coast-wind-symphony/index.html"; then
  echo "Expected ensemble page to include collection-backed concert content"
  exit 1
fi

echo "CMS event checks passed"
