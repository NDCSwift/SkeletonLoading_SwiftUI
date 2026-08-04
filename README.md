# 💀 Skeleton Loading in SwiftUI

Animated skeleton placeholders with a shimmer sweep, built on SwiftUI's native `redacted(reason:)` — no third-party dependencies.

---

## 🤔 What this is

A small SwiftUI sample app that shows how to build a production-quality skeleton loading state for a list screen. It wraps `redacted(reason: .placeholder)` and a custom `Shimmer` `ViewModifier` behind a single `.skeleton(isLoading:)` call, so any view can adopt the effect in one line.

The demo renders a team roster that starts in a loading state, holds the skeleton for a minimum duration to avoid a jarring flash, then cross-fades into the real data. It also handles the details most implementations miss — Reduce Motion, VoiceOver announcements, and disabled hit testing while placeholders are on screen.

## ✅ Why you'd use it

- **One-line API** — `.skeleton(isLoading: true)` is the entire surface area. The redaction, shimmer overlay, and touch blocking are handled inside the modifier, so adding it to a new screen costs a single line.
- **No layout shift** — the loading and loaded branches call the same `roster(_:)` builder with placeholder data, so the skeleton matches the real layout exactly and nothing jumps when the fetch completes.
- **Accessible by default** — the shimmer is skipped when Reduce Motion is on, placeholder rows collapse into a single "Loading team" VoiceOver element, and the section header stays `unredacted()` so it's always readable.

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/u2n62-Hwvlo)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding).

---

## 🚀 Getting Started

### 1. Clone

```bash
git clone https://github.com/NDCSwift/SkeletonLoading_SwiftUI.git
cd SkeletonLoading_SwiftUI
```

### 2. Open

```bash
open SkeletonLoading.xcodeproj
```

### 3. Set your team

Select the **SkeletonLoading** target → **Signing & Capabilities** → choose your Apple Developer team. The Simulator runs without a paid account; a physical device needs signing.

### 4. Change the bundle ID

Under the same tab, set **Bundle Identifier** to something unique, e.g. `com.yourname.SkeletonLoading`. Then build and run with `⌘R`.

## 🛠️ Notes

- **`View+Skeletion.swift`** — the public `.skeleton(isLoading:)` modifier. Applies `redacted(reason: .placeholder)`, blocks hit testing, and layers on the shimmer.
- **`Shimmer.swift`** — the animated highlight sweep. A `LinearGradient` masked to the content shape, animated via a `phase` offset. Tune the gradient width (`0.55`) for a tighter or broader beam, and the duration (`1.1`) for sweep speed.
- **`ContentView.swift`** — the demo screen. Replace the simulated `Task.sleep(for: .milliseconds(3000))` in `load()` with your real fetch. The `minimumSkeleton` floor (400 ms) keeps fast responses from flashing the skeleton for a few frames.
- **Placeholder realism matters** — `redacted` sizes placeholders from the actual content's bounding box, so `Member.placeholders` uses realistic-length strings to keep the skeleton proportioned like the real rows.
- **`ContinuousClock`** is used to measure elapsed time because it keeps advancing while the device is asleep, unlike `SuspendingClock`.

## 📦 Requirements

- Xcode 26 or later
- iOS 26.5+ deployment target (the core technique works on iOS 16+ — lower the target if you need broader support)
- Swift 5 language mode
- No external packages

---

📺 [Watch the guide on YouTube](https://youtu.be/u2n62-Hwvlo)
