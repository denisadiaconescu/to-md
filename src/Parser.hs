module Parser where

import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import Debug.Trace

newtype ToMd = ToMd
  { inputFile :: String
  }
  deriving Show

type Parser = Parsec Void String

parser :: Parser ToMd
parser = do
  traceM "start"
  ignoreComments
  string "from ["
  file <- many (noneOf [']'])
  char ']'
  many space
  --ignoreComments
  string "make md"
  many space
  --ignoreComments
  pure $ ToMd {inputFile = file}

ignoreComments :: Parser ()
ignoreComments = do
  traceM "before many spaces"
  many space
  traceM "after many spaces"
  commentLine
  many space
  traceM "after a comment line"
  pure ()

commentLine :: Parser ()
commentLine = do
  char '#'
  many (noneOf ['\n', '\r'])
  pure ()
  --ignoreComments
