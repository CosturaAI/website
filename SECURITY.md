# Security

This repository is the static site at https://costura.ai: HTML, CSS, fonts and articles,
built with Hugo and published to GitHub Pages. It has no server code, no forms and no
executable JavaScript (the only `<script>` is JSON-LD data), and it stores no data.

## Reporting a vulnerability

Report privately through GitHub private vulnerability reporting (`Security` ->
`Report a vulnerability`) with the affected URL or file, the steps to reproduce, and the
impact you observed. Do not open a public issue.

In scope: the site's content and templates, the build, and the GitHub Actions workflows in
`.github/workflows/`.

Expect an acknowledgement within 2 working days.

`https://costura.ai/.well-known/security.txt` (RFC 9116) carries the same contact and
policy links. `just check` fails when its `Expires` date is within 30 days; renew it in
`static/.well-known/security.txt` once a year.
