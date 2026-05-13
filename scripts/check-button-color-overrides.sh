#!/bin/sh

set -eu

site_dir="_site"

required_pages="
_site/index.html
_site/about/index.html
_site/impact/index.html
_site/ensembles/index.html
_site/support/index.html
_site/donate/index.html
_site/events/index.html
_site/updates/index.html
_site/press/index.html
_site/shop/index.html
_site/ensembles/west-coast-wind-symphony/index.html
_site/ensembles/south-bay-concert-band/index.html
_site/ensembles/beach-city-swing-band/index.html
_site/ensembles/segundo-saxes/index.html
_site/ensembles/el-segundo-brass-ensemble/index.html
"

for page in $required_pages; do
  if [ ! -f "$page" ]; then
    echo "Missing generated page: $page"
    exit 1
  fi
done

if ! rg -q "Give Lively" "$site_dir/index.html" "$site_dir/support/index.html" "$site_dir/donate/index.html"; then
  echo "Expected Give Lively markers were not found in homepage/support/donate output"
  exit 1
fi

if find "$site_dir" -name '*.html' -print0 | xargs -0 rg -q 'href="#'; then
  echo "Found legacy hash navigation in generated site output"
  exit 1
fi

if find "$site_dir" -name '*.html' -print0 | xargs -0 rg -qi 'john doe|jane doe'; then
  echo "Found placeholder leadership or donor naming in generated site output"
  exit 1
fi

echo "Generated site checks passed"
