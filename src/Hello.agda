module Hello where

open import Agda.Builtin.IO using (IO)
open import Agda.Builtin.Unit using (⊤)
open import Agda.Builtin.String using (String)

-- Külső JavaScript I/O művelet deklarálása (FFI)
postulate
  putStrLn : String → IO ⊤

{-# COMPILE JS putStrLn = function(s) { return function(cb) { console.log(s); if (typeof cb === "function") cb(); }; } #-}

-- Belépési pont (Main)
main : IO ⊤
main = putStrLn "👋 Helló, Agda Világ! A program sikeresen lefordult és lefutott!"
