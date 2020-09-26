{-# LANGUAGE OverloadedStrings #-}

import           Data
import qualified Layout as L

import Lucid

render path = do
  L.top (L.ogp ogp) $ L.article article (Just content)
  pure article
  where
    ogp =
      Ogp
        title
        OgpArticle
        (L.siteUrl <> "/favicon.ico")
        (L.siteUrl <> "/" <> path)
        (Just description)
        (Just "en_US")
    article =
      Article
        title
        description
    title = "A super duper useful article"
    description = "This is an explanation for awesome ideas."
    content = do
      p_ "Yes, really cool ideas are there."
      p_ $ em_ "WRITE HASKELL!"

main = undefined
