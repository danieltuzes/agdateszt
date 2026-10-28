module Main where

------------------------------------------------------------------------
-- Agda Példaprogram és Tételbizonyítás (Hello World)
------------------------------------------------------------------------

open import Data.Nat using (ℕ; zero; suc; _+_; _*_)
open import Data.Nat.Properties using (+-comm; +-identityʳ)
open import Data.Bool using (Bool; true; false; not)
open import Data.String using (String)
open import Data.Vec using (Vec; []; _∷_; head)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; sym; trans; cong)

------------------------------------------------------------------------
-- 1. Alapvető definíció (Hello World üzenet)
------------------------------------------------------------------------

hello-message : String
hello-message = "Hello, Agda Világ!"

------------------------------------------------------------------------
-- 2. Saját induktív adattípus és művelet
--
-- Agdában nemcsak használhatjuk a beépített típusokat, hanem az alapoktól
-- magunk is felépíthetjük a Peano-számokat és a hozzájuk tartozó műveleteket.
------------------------------------------------------------------------

data Nat : Set where
  z : Nat        -- 0
  s : Nat → Nat  -- rákövetkező (successor)

-- Saját összeadás rekurzióval a bal oldali argumentumon:
_⊕_ : Nat → Nat → Nat
z     ⊕ n = n
(s m) ⊕ n = s (m ⊕ n)

-- Néhány példa érték:
egy : Nat
egy = s z

kettő : Nat
kettő = s egy

három : Nat
három = egy ⊕ kettő

------------------------------------------------------------------------
-- 3. Tételbizonyítás az induktív típusunkra (Curry–Howard izomorfizmus)
--
-- Agdában a típus az állítás (tétel), a függvény implementációja pedig a bizonyítás!
-- Bizonyítsuk be indukcióval, hogy a 0 jobboldali egységelem: n ⊕ z ≡ n
------------------------------------------------------------------------

⊕-identityʳ : (n : Nat) → n ⊕ z ≡ n
⊕-identityʳ z     = refl
⊕-identityʳ (s n) = cong s (⊕-identityʳ n)

------------------------------------------------------------------------
-- 4. Standard Library tételek és bizonyítások
------------------------------------------------------------------------

-- Bizonyítás: 1 + 1 = 2 (a típusellenőrző definíció szerint normalizálja)
proof-one-plus-one : 1 + 1 ≡ 2
proof-one-plus-one = refl

-- Standard Library tétel hivatkozása: n + 0 = n
proof-n-plus-zero : (n : ℕ) → n + 0 ≡ n
proof-n-plus-zero n = +-identityʳ n

-- Standard Library tétel hivatkozása: az összeadás kommutatív
proof-add-comm : (a b : ℕ) → a + b ≡ b + a
proof-add-comm a b = +-comm a b

------------------------------------------------------------------------
-- 5. Függő típusok (Dependent Types) demonstrációja: Vektorok
--
-- A `Vec A n` egy n hosszúságú lista, ahol a típus része a lista hossza!
------------------------------------------------------------------------

-- Egy 3 elemű természetes számokat tartalmazó vektor:
my-vec : Vec ℕ 3
my-vec = 10 ∷ 20 ∷ 30 ∷ []

-- A `head` függvény típusa: `Vec A (suc n) → A`
-- Ez fordítási időben kizárja az üres lista indexelését (nincs futásidejű hiba!)
first-elem : ℕ
first-elem = head my-vec

-- Bizonyítás: a my-vec első eleme pontosan 10
proof-first-elem-is-10 : first-elem ≡ 10
proof-first-elem-is-10 = refl

