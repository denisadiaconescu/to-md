module Parser where

import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import Debug.Trace
import qualified Text.Megaparsec.Char.Lexer as L

newtype ToMd = ToMd
  { inputFile :: String
  }
  deriving Show

type Parser = Parsec Void String

parser :: Parser ToMd
parser = do
  ignoreComments
  string "from ["
  file <- many (noneOf [']'])
  char ']'
  ignoreComments
  string "make md"
  ignoreComments
  pure $ ToMd {inputFile = file}


ignoreComments :: Parser ()
ignoreComments = L.space 
    space1
    (L.skipLineComment "#")
    empty

