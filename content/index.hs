{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE OverloadedStrings     #-}

import           Data
import qualified Layout as L

import Data.Foldable as F
import Lucid

render (path, articles) =
  L.top
    (L.ogp ogp)
    $ div_ $ do
        dl_ $ do
          F.for_ articles $ \(Article { title, description }, path) -> do
            dt_ $ a_ [href_ path] $ toHtml title
            dd_ $ toHtml description
  where
    ogp =
      Ogp
        L.siteName
        OgpWebsite
        (L.siteUrl <> "/favicon.ico")
        (L.siteUrl <> "/" <> path)
        Nothing
        (Just "en_US")

main = undefined
