set shell := ["bash", "-euo", "pipefail", "-c"]

_root := justfile_directory()

# List recipes.
default:
    @just --list

# Install the tools pinned in mise.toml.
setup:
    cd "{{_root}}" && mise install

# Serve the site with drafts and live reload on http://localhost:1313.
serve:
    cd "{{_root}}" && hugo server --buildDrafts --buildFuture

# Build the site into public/, as the Pages workflow does.
build:
    cd "{{_root}}" && hugo build --gc --cleanDestinationDir --panicOnWarning --printPathWarnings

# Create a draft article at content/blog/<slug>.md.
new slug:
    cd "{{_root}}" && hugo new content "content/blog/{{slug}}.md"

# Regenerate assets/css/syntax.css for code blocks in light and dark mode.
syntax:
    #!/usr/bin/env bash
    set -euo pipefail
    cd "{{_root}}"
    {
      hugo gen chromastyles --style=github
      echo "@media (prefers-color-scheme: dark) {"
      hugo gen chromastyles --style=github-dark
      echo "}"
    } > assets/css/syntax.css

# Regenerate static/og.png (the link preview image) from assets/og.svg. Needs rsvg-convert.
og:
    cd "{{_root}}" && rsvg-convert -w 1200 -h 630 assets/og.svg -o static/og.png

# Bump the tools in mise.toml and mise.lock to their latest versions.
upgrade:
    cd "{{_root}}" && mise upgrade --bump

# Fail when the built home page differs from layouts/home.html.
landing: build
    cd "{{_root}}" && cmp public/index.html layouts/home.html

# Fail when static/.well-known/security.txt expires within 30 days (RFC 9116).
security-txt:
    #!/usr/bin/env -S python3 -I
    import datetime, pathlib, sys
    text = pathlib.Path("{{_root}}/static/.well-known/security.txt").read_text()
    expires = next(line.split(":", 1)[1].strip() for line in text.splitlines() if line.startswith("Expires:"))
    when = datetime.datetime.fromisoformat(expires.replace("Z", "+00:00"))
    left = when - datetime.datetime.now(datetime.timezone.utc)
    print(f"security.txt expires {expires} ({left.days} days left)")
    sys.exit(1 if left.days < 30 else 0)

# Lint the GitHub Actions workflows.
workflows:
    cd "{{_root}}" && actionlint -shellcheck= -pyflakes=

# Run every check CI runs.
check: landing workflows security-txt
