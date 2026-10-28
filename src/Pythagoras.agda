{-# OPTIONS --cubical-compatible #-}
module Pythagoras where

open import Relation.Binary.PropositionalEquality
open ≡-Reasoning

postulate
  ℝ : Set
  _+_   : ℝ → ℝ → ℝ
  zeroR : ℝ

infixl 6 _+_

postulate
  Vector : Set
  _+ᵥ_   : Vector → Vector → Vector
  ⟨_,_⟩  : Vector → Vector → ℝ

infixl 6 _+ᵥ_

-- A norma négyzete a belső szorzat önmagával
‖_‖² : Vector → ℝ
‖ v ‖² = ⟨ v , v ⟩

postulate
  ⟨-bilinear-l⟩ : ∀ u v w → ⟨ u +ᵥ v , w ⟩ ≡ ⟨ u , w ⟩ + ⟨ v , w ⟩
  ⟨-bilinear-r⟩ : ∀ u v w → ⟨ u , v +ᵥ w ⟩ ≡ ⟨ u , v ⟩ + ⟨ u , w ⟩
  ⟨-sym⟩        : ∀ u v   → ⟨ u , v ⟩ ≡ ⟨ v , u ⟩
  +-assoc       : ∀ a b c → (a + b) + c ≡ a + (b + c)
  +-zero-r      : ∀ a     → a + zeroR ≡ a
  +-zero-l      : ∀ a     → zeroR + a ≡ a

-- Két vektor merőleges (ortogonális), ha belső szorzatuk 0
_⟂_ : Vector → Vector → Set
u ⟂ v = ⟨ u , v ⟩ ≡ zeroR

-- Pitagorasz-tétel tetszőleges belső szorzatos térben:
-- Ha u ⟂ v, akkor ‖ u +ᵥ v ‖² ≡ ‖ u ‖² + ‖ v ‖²
pythagoras : ∀ (u v : Vector) → u ⟂ v → ‖ u +ᵥ v ‖² ≡ ‖ u ‖² + ‖ v ‖²
pythagoras u v u⟂v =
  begin
    ‖ u +ᵥ v ‖²
  ≡⟨ refl ⟩
    ⟨ u +ᵥ v , u +ᵥ v ⟩
  ≡⟨ ⟨-bilinear-l⟩ u v (u +ᵥ v) ⟩
    ⟨ u , u +ᵥ v ⟩ + ⟨ v , u +ᵥ v ⟩
  ≡⟨ cong₂ _+_ (⟨-bilinear-r⟩ u u v) (⟨-bilinear-r⟩ v u v) ⟩
    (⟨ u , u ⟩ + ⟨ u , v ⟩) + (⟨ v , u ⟩ + ⟨ v , v ⟩)
  ≡⟨ cong (λ x → (⟨ u , u ⟩ + x) + (⟨ v , u ⟩ + ⟨ v , v ⟩)) u⟂v ⟩
    (⟨ u , u ⟩ + zeroR) + (⟨ v , u ⟩ + ⟨ v , v ⟩)
  ≡⟨ cong (λ y → y + (⟨ v , u ⟩ + ⟨ v , v ⟩)) (+-zero-r ⟨ u , u ⟩) ⟩
    ⟨ u , u ⟩ + (⟨ v , u ⟩ + ⟨ v , v ⟩)
  ≡⟨ cong (λ z → ⟨ u , u ⟩ + (z + ⟨ v , v ⟩)) (trans (⟨-sym⟩ v u) u⟂v) ⟩
    ⟨ u , u ⟩ + (zeroR + ⟨ v , v ⟩)
  ≡⟨ cong (λ w → ⟨ u , u ⟩ + w) (+-zero-l ⟨ v , v ⟩) ⟩
    ⟨ u , u ⟩ + ⟨ v , v ⟩
  ≡⟨ refl ⟩
    ‖ u ‖² + ‖ v ‖²
  ∎
