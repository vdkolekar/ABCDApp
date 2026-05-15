# ABCD App: Technical Specification

Privacy-first, offline educational app for children to learn Alphabets and Shapes.

## Technical Stack
- **Framework:** Flutter (Latest Stable)
- **State Management:** Riverpod (Clean Architecture)
- **Local Database:** Hive (NoSQL, local-first storage)
- **Graphics:** `CustomPainter` for tracing and shape rendering
- **Animations:** Lottie for reward systems
- **Audio:** `audioplayers` package

## Architecture & Requirements
- **Clean Architecture:** Organized into `data`, `domain`, and `presentation` layers.
- **Privacy-First:** Strictly NO external APIs, Firebase, or Analytics. All data stays in local Hive Boxes.
- **User System:** Local-only profiles stored in `SettingsBox`.
- **Ads Policy:** 100% Ad-free.
- **Input Handling:** Touch Debouncing for rapid, accidental taps.

## Core Modules
- **Alphabet Module:** A-Z (Upper/Lowercase), Interactive Tracing (`CustomPainter`), Phonics (Audio).
- **Shapes Module:** Identification, Drag-and-drop Matching Game.
- **Reward Logic:** Lottie animations on completion, Star system (0-3) saved to `ProgressBox`.

## Data Model (Hive)
- **LearningProgress:**
    - `id` (String)
    - `category` (String: alphabet/shape)
    - `starsEarned` (int)
    - `isUnlocked` (bool)
    - `lastPracticed` (DateTime)

## UI/UX Style Guide
- **Colors:** High-contrast, primary color palette (Red, Blue, Yellow, Green).
- **Buttons:** Large hit-areas (min 60x60 pixels).
- **Navigation:** Parental Gate (long press or math sum) for settings/reset data.
