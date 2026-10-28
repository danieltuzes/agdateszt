{-# OPTIONS --cubical-compatible #-}
module UnbiasedVariance where

open import Relation.Binary.PropositionalEquality
open ≡-Reasoning

postulate
  ℝ : Set
  _+_   : ℝ → ℝ → ℝ
  _-_   : ℝ → ℝ → ℝ
  _*_   : ℝ → ℝ → ℝ
  _/_   : ℝ → ℝ → ℝ

infixl 6 _+_ _-_
infixl 7 _*_ _/_

postulate
  RV : Set
  𝔼  : RV → ℝ

postulate
  N   : ℝ
  σ²  : ℝ
  N-1 : ℝ

postulate
  SS_dev : RV

postulate
  SS-expectation : 𝔼 SS_dev ≡ (N * σ²) - (N * (σ² / N))
  N-cancel       : N * (σ² / N) ≡ σ²
  factor-out     : (N * σ²) - σ² ≡ N-1 * σ²

lemma-sample-variance-expectation : 𝔼 SS_dev ≡ N-1 * σ²
lemma-sample-variance-expectation =
  begin
    𝔼 SS_dev
  ≡⟨ SS-expectation ⟩
    (N * σ²) - (N * (σ² / N))
  ≡⟨ cong (λ x → (N * σ²) - x) N-cancel ⟩
    (N * σ²) - σ²
  ≡⟨ factor-out ⟩
    N-1 * σ²
  ∎

postulate
  S²         : RV
  𝔼-div      : 𝔼 S² ≡ (𝔼 SS_dev) / N-1
  div-cancel : ∀ (a b : ℝ) → ((a * b) / a) ≡ b

unbiased-sample-variance : 𝔼 S² ≡ σ²
unbiased-sample-variance =
  begin
    𝔼 S²
  ≡⟨ 𝔼-div ⟩
    (𝔼 SS_dev) / N-1
  ≡⟨ cong (λ x → x / N-1) lemma-sample-variance-expectation ⟩
    (N-1 * σ²) / N-1
  ≡⟨ div-cancel N-1 σ² ⟩
    σ²
  ∎
