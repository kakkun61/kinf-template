{-# LANGUAGE ScopedTypeVariables #-}

module Main (main) where

import Data (Article)

import           Control.Exception            (Exception (displayException))
import           Control.Monad.IO.Class       (MonadIO (liftIO))
import           Data.Foldable                (for_)
import           Data.Functor.Identity        (Identity (runIdentity))
import           Data.Traversable             (for)
import           Data.Typeable                (Typeable)
import qualified Development.Shake            as Shake
import           Development.Shake.FilePath   ((-<.>), (</>))
import qualified Development.Shake.Forward    as Shake
import           Language.Haskell.Interpreter (OptionVal ((:=)))
import qualified Language.Haskell.Interpreter as Hint
import qualified Lucid
import           Main.Utf8                    (withUtf8)
import           System.IO                    (hPutStrLn, stderr)

main :: IO ()
main =
  withUtf8 $
    Shake.shakeArgsForward
      (Shake.forwardOptions Shake.shakeOptions { Shake.shakeLintInside = ["fsatrace"] })
      action

action :: Shake.Action ()
action = do
  credit
  as <- articles
  index as
  images

index :: [(Article, FilePath)] -> Shake.Action ()
index articles = lucid "index.hs" "index.html" ("index.html", articles)

credit :: Shake.Action ()
credit = lucid "credit.hs" "credit.html" "credit.html"

articles :: Shake.Action [(Article, FilePath)]
articles = do
  sources <- reverse <$> Shake.getDirectoryFiles "content/article" ["*"]
  for sources article

article :: FilePath -> Shake.Action (Article, FilePath)
article path = do
  b <- lucid ("article" </> path) dest dest
  pure (b, dest)
  where
    dest = path' -<.> "html"
    path' = dropOrder path
    dropOrder ('-':r) = r
    dropOrder (_:r)   = dropOrder r
    dropOrder []      = error "dropOrder: does not contain '-'"

lucid :: forall p r. (Show p, Typeable r) => FilePath -> FilePath -> p -> Shake.Action r
lucid source destination param = do
  libs <- Shake.getDirectoryFiles "content/lib" ["*.hs"]
  result <- liftIO $ Hint.runInterpreter $ do
    Hint.set [Hint.languageExtensions := [Hint.DuplicateRecordFields, Hint.OverloadedStrings]]
    Hint.loadModules $ ("content" </> source) : (("content/lib" </>) <$> libs)
    Hint.setTopLevelModules ["Main"]
    Hint.setImports ["Data.Functor.Identity", "Lucid", "Data.Text"]
    Hint.interpret ("render (" ++ show param ++ ")") (Hint.as :: Lucid.Html r)
  case result of
    Left e  -> do
      liftIO $ hPutStrLn stderr $ displayException e
      fail "interpret"
    Right html -> do
      Shake.writeFile' ("out" </> destination) $ show html
      pure $ runIdentity $ Lucid.evalHtmlT html

images :: Shake.Action ()
images = do
  sources <- Shake.getDirectoryFiles "content/image" ["*"]
  for_ sources $ \source -> Shake.copyFileChanged ("content/image" </> source) ("out" </> source)
