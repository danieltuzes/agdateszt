# Agda Példapéldány (agdateszt)

Ez a projekt egy bemutató **Agda** projekt, amely szemlélteti az Agda nyelv alapvető képességeit:
1. **Függő típusok (Dependent Types)** és típusbiztonság
2. **Curry–Howard izomorfizmus:** Típusok mint tételek, programok mint bizonyítások
3. **Induktív típusok és struktúrált indukciós bizonyítások** (`refl`, `cong`)
4. **Futatható "Hello World" program:** JavaScript kódgenerálás és futtatás Node.js alatt

---

## 💻 Rendszer és Telepítés

A projekt futtatása előtt ellenőriztük a rendelkezésre álló lemezterületet:
- **Szabad lemezterület:** ~126 GB (elegendő)
- **Telepített Agda verzió:** `Agda 2.8.0` (optimalizált natív bináris)
- **Standard Könyvtár:** `agda-stdlib 2.3`
- **Telepítési hely:**
  - Bináris indító: `~/.local/bin/agda` (elérhető a felhasználó `$PATH`-jában)
  - Agda adatkönyvtár és runtime: `~/.local/lib/agda/data`
  - Agda standard library: `~/.local/lib/agda/agda-stdlib`
  - Agda konfiguráció: `~/.config/agda/libraries` és `~/.config/agda/defaults`

---

## 📁 A Projekt Felépítése

```text
agdateszt/
├── agdateszt.agda-lib    # Az Agda projekt definíciója és könyvtárfüggőségei
├── src/
│   ├── Main.agda         # Típusok, Peano-számok, tételek, vektorok és bizonyítások
│   └── Hello.agda        # Futtatható I/O Hello World (JavaScript FFI-vel)
├── check.sh              # Típusellenőrzést és tételbizonyítást futtató szkript
├── run.sh                # Lefordítja JS-re és futtatja a Hello World programot
├── .gitignore            # Generált fájlok kizárása (_build/, dist/, *.agdai)
└── README.md             # Dokumentáció
```

---

## 🚀 Futtatás és Típusellenőrzés

### 1. Típus- és Tételellenőrzés (`src/Main.agda`)

Az Agda elsősorban egy interaktív tételbizonyító és funkcionális nyelv. A kód helyességét (és a bizonyítások érvényességét) a típusellenőrző garantálja:

```bash
./check.sh
# vagy közvetlenül:
agda src/Main.agda
```

Ha a parancs hiba nélkül lefut, az Agda igazolta, hogy az összes tétel és típusdefiníció matematikailag helyes.

### 2. Futtatható "Hello World" (`src/Hello.agda`)

A program lefordítható JavaScriptre és azonnal futtatható Node.js segítségével:

```bash
./run.sh
```

Kimenet:
```text
==> Agda kód fordítása JavaScriptre (src/Hello.agda)...
==> Program futtatása Node.js környezetben...
👋 Helló, Agda Világ! A program sikeresen lefordult és lefutott!
```

---

## 🔍 Kiemelt Kódpéldák (`src/Main.agda`)

### Saját Peano természetes számok és összeadás:
```agda
data Nat : Set where
  z : Nat        -- 0
  s : Nat → Nat  -- rákövetkező (successor)

_⊕_ : Nat → Nat → Nat
z     ⊕ n = n
(s m) ⊕ n = s (m ⊕ n)
```

### Bizonyítás indukcióval (0 a jobboldali egységelem):
```agda
⊕-identityʳ : (n : Nat) → n ⊕ z ≡ n
⊕-identityʳ z     = refl
⊕-identityʳ (s n) = cong s (⊕-identityʳ n)
```

### Függő típusú Vektorok (hossz a típusban):
```agda
-- Egy garantáltan 3 hosszúságú vektor:
my-vec : Vec ℕ 3
my-vec = 10 ∷ 20 ∷ 30 ∷ []

-- A `head` típushelyesen csak nem üres vektoron hívható meg:
first-elem : ℕ
first-elem = head my-vec
```

---

## 📦 Git Verziókezelés

A projekt a GitHubon elérhető nyilvános repositoryként:
- **Repository:** [https://github.com/danieltuzes/agdateszt](https://github.com/danieltuzes/agdateszt)


