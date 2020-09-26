# static-site-generator-template

A static site generator template powered by [Shake](https://shakebuild.com), [Lucid](https://hackage.haskell.org/package/lucid) and [Hint](https://hackage.haskell.org/package/hint).

## Dependencies

- [Filesystem Access Tracer](https://github.com/jacereda/fsatrace) (fsatrace)
- [PowerShell Core](https://github.com/PowerShell/PowerShell) (pwsh)
  - able to be replaced
- [wai-static-app](https://hackage.haskell.org/package/wai-app-static) (warp)
  - able to be replaced

## Build

```
> make
> make serve
```

And access <http://localhost:3000>.

## Directory structure

- app
  - gen.hs — generator itself
- content
  - article — add articles here
    - 1-article.hs
  - image
  - lib
    - Layout.hs — layouts wrapping contents
  - content.cabal — not necessary, only for an IDE
  - credit.hs
  - index.hs — list of articles
- lib
  - Data.hs — depended by gen.hs, and read by gen
- site.cabal
