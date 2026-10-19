# Contributing

Corrections, articles, accessibility and design fixes are welcome.

Changes to templates, styles and tooling are licensed under the Apache License, Version
2.0 ([LICENSE](LICENSE)). Articles under `content/blog/` are licensed under CC BY 4.0
([LICENSE-CONTENT.md](LICENSE-CONTENT.md)). There is no CLA and no DCO sign-off. Opening a
pull request submits the change under the license that applies to its files. The name and
mark follow [TRADEMARK.md](TRADEMARK.md).

## Setup

Install [mise](https://mise.jdx.dev/getting-started.html), then:

```sh
mise install
just serve
```

`just setup` runs the same `mise install`. Fork the repository, branch from `main`, and keep one change per pull request.

## Layout

```text
.
|-- archetypes/blog.md         front matter for new articles
|-- assets/css/                blog styles and code highlighting, bundled at build time
|-- assets/og.svg              source of static/og.png, the link preview image
|-- content/blog/              articles; _index.md is the blog index text
|-- layouts/
|   |-- home.html              the landing page, standalone
|   |-- home.llms.txt          /llms.txt; home.llmsfull.txt is /llms-full.txt
|   |-- baseof.html            shell for every other page
|   |-- list.html              blog index; list.markdown.md is its Markdown twin
|   |-- single.html            article; single.markdown.md is its Markdown twin
|   |-- rss.xml                full-content feed at /blog/index.xml
|   |-- 404.html
|   |-- robots.txt
|   |-- _markup/               render hooks: heading anchors, scrolling tables, lazy images, code blocks
|   `-- _partials/             head, header, footer of blog pages
|-- static/                    copied as is: styles.css, favicon.svg, og.png, fonts/, CNAME,
|                              .well-known/security.txt
|-- third_party/licenses/      licenses of bundled third-party files
|-- hugo.toml
|-- justfile
`-- mise.toml
```

The landing page is kept exactly as designed: `layouts/home.html` does not use the shared
shell, and `just landing` fails the build if the published `index.html` differs from it by
one byte.

## Recipes

| Recipe | Does |
| --- | --- |
| `just serve` | Local server with drafts and live reload |
| `just new <slug>` | New draft article |
| `just build` | Production build into `public/` |
| `just landing` | Build, then compare the landing page with `layouts/home.html` |
| `just syntax` | Regenerate `assets/css/syntax.css` |
| `just og` | Regenerate `static/og.png` from `assets/og.svg` (needs `rsvg-convert`) |
| `just upgrade` | Bump Hugo, just and actionlint in `mise.toml` and `mise.lock` |
| `just security-txt` | Fail when `static/.well-known/security.txt` expires within 30 days |
| `just check` | Everything CI runs: `landing`, `workflows` and `security-txt` |

## Issues

Check the page on the published site and in a private window before opening a bug, and
say which browser and color scheme showed it. Questions go to
[Discussions](https://github.com/CosturaAI/website/discussions); the "Ask a question" link
on the new-issue page takes you there. Articles start with the "Article proposal" form.

## Articles

Open an "Article proposal" issue first, so the topic and outline are agreed before the
writing. Then:

1. `just new <slug>` creates `content/blog/<slug>.md` as a draft. The slug is lowercase
   words joined by hyphens. The file name is the URL, `/blog/<slug>/`, so renaming the
   file after publication breaks links; the title can change freely.
2. Fill in `title`, `description` (one sentence, under 160 characters) and `authors`.
   `image` names a 1200 x 630 image in the article's page bundle for link previews, with
   `image_alt` describing it; left empty, the site-wide `og.png` is used.
3. Write in English, in Markdown. Use `##` and `###` for sections; the title is the only
   `h1`. Fence code with its language (```` ```sh ````) so it is highlighted.
4. Link each number and claim to its source: provider documentation, a pricing page, or
   the Costura code at a commit. Aim for 10 to 15 words per sentence on average, 1 to 3
   sentences per paragraph, `##` sections a reader can scan as a checklist, and no
   exclamation marks. Headings get an anchor link at build time, so keep them unique.
5. Put images next to the article as a page bundle: move `content/blog/<slug>.md` to
   `content/blog/<slug>/index.md` and place the image files in that directory. The URL
   stays `/blog/<slug>/`. Reference images by file name (`![What it shows](chart.png)`);
   the build adds their dimensions and lazy loading. Give each image `alt` text that
   says what it shows.
6. Set `draft: false` in the pull request that publishes it.

## Design changes

The landing page (`layouts/home.html` and `static/styles.css`) is frozen; `just landing`
fails when its output changes. A change to it starts with an issue. Blog styles live in
`assets/css/blog.css`. Check a visual change in light and dark mode and at 320 px wide.
Text colors keep a contrast of at least 4.5:1 against their background (WCAG 2.2 AA).
Any animation or transition added to `blog.css` goes inside
`@media (prefers-reduced-motion: no-preference)`.

## Checks

```sh
just check
```

`just check` builds the site with warnings as errors, compares the landing page with its
template, lints the workflows with actionlint, and fails when
`static/.well-known/security.txt` expires within 30 days. CI runs the same recipe and
uploads `public/` as an artifact so reviewers can download the built site.

## Publishing

`.github/workflows/pages.yml` builds the site with `just landing` and deploys `public/` to
GitHub Pages on every push to `main`, or on demand from the Actions tab. The Pages source is
GitHub Actions, and the custom domain `costura.ai` comes from `static/CNAME`.
`.github/workflows/ci.yml` runs `just check` on every pull request. Both workflows need the
full git history (`fetch-depth: 0`) because `enableGitInfo` takes each article's `lastmod`
from its last commit.

Dependabot updates the pinned actions. Hugo, just and actionlint are pinned in `mise.toml`
and `mise.lock`; `just upgrade` bumps them, and the pull request that carries the bump runs
`just check` against the new versions.

Every page is also published as Markdown next to its HTML (`/blog/<slug>/index.md`,
`/blog/index.md`), announced in the HTML head with `rel="alternate" type="text/markdown"`.
`/llms.txt` lists the articles and `/llms-full.txt` carries their full text, both linked
from every page with `rel="llms-txt"`. The feed at `/blog/index.xml` carries full article
HTML.

## Pull requests

Use a Conventional Commit title. Squash merge turns that title into the commit on `main`.
Examples: `docs(blog): add usage report article`, `fix(blog): wrap long table cells`.
Actions in workflows are pinned to a commit SHA with the version in a comment. Workflows that run on pull requests read no repository secret; if one is ever
needed, gate it so fork pull requests see an empty value:

```yaml
TOKEN: ${{ (github.event_name != 'pull_request' || github.event.pull_request.head.repo.full_name == github.repository) && secrets.TOKEN || '' }}
```

Add the `agent-assisted` label to a pull request or issue produced with a coding agent. Hugo, just and actionlint are pinned in `mise.toml` and `mise.lock`;
`just upgrade` bumps them in a pull request of their own.
