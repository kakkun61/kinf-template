{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE OverloadedStrings     #-}

module Layout where

import Data

import qualified Data.Foldable as F
import           Data.String   (IsString (fromString))
import           Data.Text     (Text)
import           Lucid
import qualified Lucid.Base    as Lucid

siteName :: IsString s => s
siteName = "Makes you happy"

siteUrl :: Text
siteUrl = "https://happy.example.com"

top :: Html () -> Html () -> Html ()
top head content = do
  doctype_
  html_ [lang_ "en"] $ do
    head_ $ do
      meta_ [charset_ "utf-8"]
      meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1"]
      head
    body_ $ do
      header_ $ do
        h1_ siteName

      main_ content

      footer_ $ do
        "Powered by "
        a_ [href_ "https://shakebuild.com"] "Shake"
        ", "
        a_ [href_ "https://hackage.haskell.org/package/lucid"] "Lucid"
        " and "
        a_ [href_ "https://hackage.haskell.org/package/hint"] "Hint"
        " | "
        a_ [href_ "/credit.html"] "OSS"

article :: Article -> Maybe (Html ()) -> Html ()
article Article { title, description } content = do
  article_ $ do
    h2_ $ toHtml title
    p_ $ toHtml description
    whenJust content id

page :: Text -> Html () -> Html ()
page title content = do
  article_ $ do
    div_ $ do
      h2_ $ toHtml title
      div_ content

ogp :: Ogp -> Html ()
ogp Ogp { title, typ, image, url, description, locale } = do
  meta_ [property_ "og:title", content_ title]
  meta_ [property_ "og:type", content_ $ fromString $ show typ]
  meta_ [property_ "og:image", content_ image]
  meta_ [property_ "og:rul", content_ url]
  whenJust description $ \description -> meta_ [property_ "og:description", content_ description]
  whenJust locale $ \locale -> meta_ [property_ "og:locale", content_ locale]

whenJust :: Applicative m => Maybe a -> (a -> m ()) -> m ()
whenJust Nothing _  = pure ()
whenJust (Just a) f = f a

property_ :: Text -> Attribute
property_ = Lucid.makeAttribute "property"
