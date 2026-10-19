# Agent notes

The Costura website: a Hugo site whose home page is the landing page and whose `blog`
section holds articles. `just --list` prints the recipes; `just check` is what CI runs.
`CONTRIBUTING.md` holds the layout, the recipe table, the article steps and how the site
is published; `README.md` stays short and points there.

- The landing page is frozen. `layouts/home.html` is a standalone template (no `define`
  blocks, so `baseof.html` does not wrap it) and loads `static/styles.css` directly. The
  build must emit it byte for byte: `just landing` compares `public/index.html` with
  `layouts/home.html`, and `disableHugoGeneratorInject` keeps Hugo from adding a tag.
  Change the landing page only when the request names it.
- Blog pages use `baseof.html` and one bundled stylesheet built in
  `layouts/_partials/head.html` from `static/styles.css`, `assets/css/blog.css` and
  `assets/css/syntax.css`. Style blog pages in `assets/css/blog.css`, scoped under `.page`.
- `--thread` (`#6369e5`) is below 4.5:1 as text on the light background; blog pages use
  `--thread-text` for text in that hue.
- Articles are `content/blog/<slug>.md` from `archetypes/blog.md`; front matter needs
  `title`, `date` and `description`, and `draft: true` keeps one out of the build. The
  URL is `/blog/<file name>/` (`:contentbasename`), not the title.
- `layouts/_markup/` holds the render hooks: headings get an anchor link, tables are
  wrapped in `.table-scroll`, images get `loading="lazy"` plus width and height when they
  are page resources, and code blocks sit in a `translate="no"` wrapper.
- Output formats: pages and the blog section also render as Markdown
  (`layouts/*.markdown.md`), the home renders `/llms.txt` and `/llms-full.txt`
  (`layouts/home.llms*.txt`), and `layouts/rss.xml` is the full-content feed. The landing
  `index.html` is untouched by these.
- `static/.well-known/security.txt` has an `Expires` date that `just security-txt` checks.
- Articles are CC BY 4.0 (`LICENSE-CONTENT.md`); everything else is Apache-2.0.
- Tool versions live in `mise.toml` and `mise.lock`.
