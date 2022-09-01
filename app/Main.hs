module Main where

import qualified Parser as ToMd
import Text.Megaparsec

main :: IO ()
main = do
  putStrLn "Hello, ToMD!"
  fileContent <- readFile "tests/input3.2md"
  print $ parseMaybe ToMd.parser fileContent
  
