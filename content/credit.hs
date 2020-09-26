{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings     #-}

import           Data
import qualified Layout as L

import Data.Foldable as F
import Lucid

render path =
  L.top (L.ogp ogp) $ L.page title content
  where
    ogp =
      Ogp
        title
        OgpArticle
        (L.siteUrl <> "/favicon.ico")
        (L.siteUrl <> "/" <> path)
        Nothing
        (Just "en_US")
    title = "Open Source Licenses"
    content = do
      h3_ "static-site-generator-template"
      pre_
        "Copyright (c) 2020 Kazuki Okamoto, All rights reserved.\n\
        \\n\
        \Redistribution and use in source and binary forms, with or without\n\
        \modification, are permitted provided that the following conditions\n\
        \are met:\n\
        \\n\
        \1. Redistributions of source code must retain the above copyright\n\
        \   notice, this list of conditions and the following disclaimer.\n\
        \2. Redistributions in binary form must reproduce the above copyright\n\
        \   notice, this list of conditions and the following disclaimer in the\n\
        \   documentation and/or other materials provided with the distribution.\n\
        \3. Neither the name of the copyright holder nor the names of its\n\
        \   contributors may be used to endorse or promote products derived from\n\
        \   this software without specific prior written permission.\n\
        \\n\
        \THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS\n\
        \\"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT\n\
        \LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR\n\
        \A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT\n\
        \HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,\n\
        \SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT\n\
        \LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\n\
        \DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\n\
        \THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n\
        \(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE\n\
        \OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."

main = undefined
