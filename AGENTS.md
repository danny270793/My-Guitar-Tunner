# Agent instructions for MyPills

These rules apply to any AI agent (or human) making changes in this repo.

## Workflow conventions

- Commit related changes file by file rather than one large commit, unless told otherwise.
- Do not commit, create branches, or open PRs/MRs until the user explicitly asks for it.

## Commits: Conventional Commits (required)

Every commit message **must** follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Format

```
<type>[optional scope]: <short description>

[optional body]

[optional footer(s)]
```

- **Description:** imperative mood, lowercase start (no trailing period required but stay consistent).
- **Header max length:** keep the first line ≤ **72** characters when practical.
- Use the body for the "why" when it's not obvious.

### Allowed types (common)

Use one of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.

- **`feat`:** new behavior or capability for users.
- **`fix`:** a bug fix.
- **`docs`:** documentation only.
- **`chore`:** maintenance that is not a user-facing feature or fix (deps, config, tooling).
- **`ci`:** CI/CD pipeline or automation only.

### Scope (optional)

A noun in parentheses after the type, e.g. `fix(sync): handle null connection string`.

### Breaking changes

Either:

- append **`!`** after the type/scope: `feat(api)!: remove legacy endpoint`, or
- add a footer: `BREAKING CHANGE: <what changed and what to do>`.

### Examples (valid)

- `feat(pills): add reminder snooze option`
- `fix(sync): handle nil auth token on refresh`
- `docs: clarify localization workflow in readme`
- `chore: bump swift toolchain version`

### Examples (invalid — do not use)

- `Update view` (missing type)
- `Fixed bug` (not conventional)
- `WIP` / `misc changes`

When proposing or creating commits, **always** use this format. If multiple unrelated changes exist, **split into multiple commits** rather than one vague message.

## Internationalization

- Never hardcode user-facing text as a plain `String`. Use `Text`/`Label`/`LocalizedStringKey` string literals (or a value explicitly typed `LocalizedStringKey`) so Xcode's String Catalog can extract it — see `NoteDisplayName.swift` and `LegalDocumentView.text` for the pattern when the value is computed from a closed set of options.
- `Text(someString)` where `someString` is a `String` variable is **verbatim** and skips localization entirely — only literal strings, or values explicitly typed `LocalizedStringKey`, get picked up.
- All user-facing text must live in the String Catalog at `MyGuitarTunner/Localizable.xcstrings`, following standard iOS String Catalog conventions (the literal English text is the key; see Apple's String Catalog documentation). Don't hand-roll `.strings`/`.stringsdict` files.
- The app must support **English** (source language) and **Spanish**. Every string added to the catalog needs both an `en` and an `es` entry in `"translated"` state before merging — don't leave new strings in `"new"`/`"needs_review"` state or missing the `es` localization.
- After adding or changing literal strings in code, resync the catalog (e.g. `xcodebuild -exportLocalizations`) rather than hand-editing keys, to make sure the key text matches exactly what Xcode extracts (this matters especially for interpolated strings with a `specifier:`, where the specifier itself becomes part of the key).

## UI: Liquid Glass design language

- All UI must follow Apple's Liquid Glass design guidelines (introduced with iOS 26 / macOS Tahoe) — this is the required look and feel across the app, not an optional style.
- Prefer native SwiftUI materials and system components (e.g. `.glassEffect`, `.background(.thinMaterial)`/`.regularMaterial`/`.ultraThinMaterial`, standard `Button`, `TabView`, `NavigationStack`, toolbars, sheets) over custom-drawn chrome, so surfaces automatically pick up the translucent, refractive glass treatment, dynamic tinting, and light/dark adaptation.
- Avoid flat, opaque custom backgrounds for chrome-like elements (toolbars, tab bars, floating controls, sheets, sidebars) — these should read as glass: translucent, layered over content, reacting to scrolling/content behind them.
- Respect system concentricity and corner radii (`.containerShape`, `ContainerRelativeShape`, continuous corner radii) instead of hardcoded corner values, so custom components nest correctly inside glass containers.
- Check new/changed screens in both light and dark mode, and under Reduce Transparency / Increase Contrast accessibility settings, since glass materials must stay legible under those.
- When in doubt, match the stock look of the equivalent system control (tab bar, nav bar, sheet, alert) rather than inventing a custom visual treatment.

## Loading state for `.task`

- Every `.task { await store.loadXXX() }` used to load data when a view first appears must show a loading indicator (`ProgressView`) while the load is in flight — don't let the view flash empty/stale content.
- Follow the existing pattern: an `AppStore.hasLoaded...` flag (`hasLoadedFolders`, `hasLoadedPills(for:)`, `hasLoadedShares(for:)`) gates the view's body, as seen in `ContentView`, `PillsListView`, and `FolderShareView`.

## Simulated network delay in dev

- All remote (Supabase) requests must go through `DevNetworkDelay.simulate()` in debug builds, which adds a random 3–5 second delay. This makes loading states visible and testable during development, and is a no-op in release builds.
- New network call sites should call `await DevNetworkDelay.simulate()` right before the `URLSession` call, matching `SupabaseClient.send` and `AuthService.send`/`signOut`/`updatePassword`.
