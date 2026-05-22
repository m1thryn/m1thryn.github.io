# m1thryn's Blog

[![Deploy to GitHub Pages](https://github.com/m1thryn/m1thryn.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/m1thryn/m1thryn.github.io/actions/workflows/deploy.yml)

A personal blog and projects showcase, live at [m1thryn.github.io](https://m1thryn.github.io).

Built on [Astro Micro](https://astro.build/themes/details/astro-micro/) and [Drew's Dev Blog](https://github.com/drewsilcock/silcock-dev) with customised styling, plugins, and integrations.

## Features

- **Static site generation** via [Astro v6](https://astro.build)
- **Syntax highlighting** with [Expressive Code](https://expressive-code.com) — Catppuccin Latte/Frappé themes, line numbers, collapsible sections
- **Math rendering** via [KaTeX](https://katex.org)
- **Full-text search** powered by [Pagefind](https://pagefind.app)
- **Open Graph images** generated at build time with [astro-og-canvas](https://github.com/delucis/astro-og-canvas)
- **Comments** via [Giscus](https://giscus.app)
- **RSS feed** and **sitemap** included
- **MDX** support for rich content
- [Geist Sans](https://vercel.com/font) and [Geist Mono](https://vercel.com/font) fonts
- Styled with [Tailwind CSS](https://tailwindcss.com)

## Getting Started

### With devcontainer (recommended)

Requires [Docker](https://www.docker.com) and the [devcontainer CLI](https://github.com/devcontainers/cli).

```shell
# Start the devcontainer
./devcontainer.sh start

# Open a shell inside it
./devcontainer.sh shell

# Then run the dev server from inside the container
pnpm dev
```

The `devcontainer.sh` script also supports `stop`, `rebuild`, `destroy`, `exec`, and `status`.

### Locally

Requires [Node.js 22](https://nodejs.org) and [pnpm](https://pnpm.io).

```shell
pnpm install   # install dependencies
pnpm dev       # start dev server at localhost:4321
pnpm build     # build to dist/
pnpm preview   # preview the production build
```

```shell
pnpm run check # TypeScript / Astro type checking
pnpm run lint  # check formatting
pnpm format    # auto-format with Prettier
```

## Project Structure

```
src/
├── components/      # Shared Astro/HTML components
├── content/
│   ├── blog/        # Blog posts (.md / .mdx)
│   └── projects/    # Project entries (.md / .mdx)
├── layouts/         # Page layout templates
├── lib/             # Utility functions
├── pages/           # File-based routes
└── consts.ts        # Site-wide constants (title, author, socials, etc.)
```

## Configuration

Edit `src/consts.ts` to update the site title, author, description, social links, and how many posts/projects appear on the homepage.

Edit `astro.config.mjs` for build-level settings: integrations, Markdown/MDX plugins, and syntax-highlighting themes.

## Writing Content

All content lives in `src/content/` as `.md` or `.mdx` files. The filename becomes the URL slug.

### Blog post

```yaml
---
title: My Post Title       # required
description: A summary     # required
date: 2026-01-15           # required — publication date
updated: 2026-02-01        # optional — shows "last updated" date
draft: true                # optional — excludes from production build
archive: true              # optional — marks post as archived
tags: [security, ctf]      # optional
---
```

### Project entry

Same fields as a blog post, plus:

```yaml
---
title: My Project
description: What it does
date: 2026-01-15
repoURL: https://github.com/m1thryn/my-project    # optional
demoURL: https://my-project.example.com           # optional
packageURL: https://crates.io/crates/my-crate     # optional
tags: [rust, security]
---
```

## Deployment

Pushes to `main` automatically build and deploy to GitHub Pages via the [deploy workflow](.github/workflows/deploy.yml). The site is also deployable manually from the Actions tab.

## License

Blog content is licensed under [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/). The source code is licensed under the [MIT License](LICENSE).
