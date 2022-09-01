module Parser (ToMd (..), parser) where

import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L

newtype ToMd = ToMd
  { inputFile :: String
  }
  deriving (Show)

type Parser = Parsec Void String

parser :: Parser ToMd
parser = do
  ignoreComments
  keyword "from"
  file <- around '[' ']'
  keyword "make md"
  pure $ ToMd {inputFile = file}

-------------------------------------------------------------------------------
-- Helpers

ignoreComments :: Parser ()
ignoreComments =
  L.space
    space1
    (L.skipLineComment "#")
    empty

keyword :: String -> Parser ()
keyword key = do
  L.symbol ignoreComments key
  pure ()

around :: Char -> Char -> Parser String
around start end = between (keyword [start]) (keyword [end]) (many $ noneOf [end])
