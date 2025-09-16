{settings, ...}:
''
#!/bin/bash
set -e
pushd ${settings.flakeabsolutedir}
alejandra .
sudo rebuildsraw
gen=$(nixos-rebuild list-generations | grep current)
git add .
git commit -m "$gen"

popd
''
