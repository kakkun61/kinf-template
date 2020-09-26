{-# LANGUAGE DuplicateRecordFields #-}

module Data
  ( Article (..)
  , Ogp (..)
  , OgpType (..)
  ) where

import Data.Text (Text)

data Article =
  Article
    { title       :: Text
    , description :: Text
    }
  deriving Show

-- https://ogp.me/
data Ogp =
  Ogp
    { title :: Text
    , typ :: OgpType
    , image :: Text
    , url :: Text
    , description :: Maybe Text
    , locale :: Maybe Text
    }
  deriving Show

data OgpType
  = OgpWebsite
  | OgpArticle

instance Show OgpType where
  show OgpWebsite = "website"
  show OgpArticle = "article"
