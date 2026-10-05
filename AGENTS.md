# Agent instructions

Instructions for AI and human collaborators using tools such as **Cursor** and **Claude** in this repository.

## Git commits and branches: explicit user approval is required

**Never commit changes to git unless the user explicitly asks you to.** Make all code changes, then wait for the user to request a commit before running any `git commit` command. Proposing a commit message is fine; running the commit is not.

**Never create a git branch unless the user explicitly asks you to.** Do not run `git branch` or `git checkout -b` (or equivalent) on your own, even to prepare for a commit or Merge Request.

## Pull Requests: use the project template

When creating a GitHub Pull Request, always fill in the description using [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md). GitHub loads that file automatically. Replace each `<!-- … -->` comment with concrete content based on the actual changes. Do not leave placeholder comments in the final description.

## Commits: Conventional Commits (required)

Every commit message **must** follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Format

```
<type>[optional scope]: <short description>

[optional body]

[optional footer(s)]
```

- **Description:** imperative mood, lowercase start (a trailing period is not required, but stay consistent).
- **Maximum header length:** keep the first line at ≤ **72** characters when possible.

### Allowed types (common)

Use one of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.

- **`feat`:** new user-facing behavior or capability.
- **`fix`:** a bug fix.
- **`docs`:** documentation only.
- **`chore`:** maintenance that is not a user-facing feature or fix (dependencies, configuration, tooling).
- **`ci`:** CI/CD pipeline or automation only.

### Scope (optional)

A noun in parentheses after the type, e.g. `fix(postgres): handle null connection string`.

### Breaking changes

Either of:

- add **`!`** after the type/scope: `feat(api)!: remove legacy endpoint`, or
- add a footer: `BREAKING CHANGE: <what changed and what to do>`.

### Examples (valid)

- `feat(examples): add from-code compose sample`
- `fix(ci): use non-tls dind for self-hosted runners`
- `docs: clarify WAL-G vs backup-push in readme`
- `chore: bump gitlab-ci docker image tags`

### Examples (invalid — do not use)

- `Update dockerfile` (missing type)
- `Fixed bug` (not conventional)
- `WIP` / `misc changes`

When proposing or creating commits, **always** use this format. If there are multiple unrelated changes, **split them into several commits** instead of one vague message.

## Architecture

The app follows the same layout as the reference Wallet app:

- `lib/main.dart` — bootstraps dependency injection, persisted preferences, and the biometric lock gate (no accounts: when biometric unlock is enabled the app locks on cold start and on resume).
- `lib/router.dart` — `go_router` configuration; starts on the mode picker (`/`), with auto (`/auto`) and manual (`/manual`) tuners, no auth redirects.
- `lib/core/` — cross-cutting code: `di/injection.dart` (`get_it` registrations), `locale/`, `theme/`, and `security/` `ChangeNotifier` controllers, `logger/`.
- `lib/features/<feature>/` — `data/{datasources,repositories}`, `domain/{entities,repositories,usecases}`, `presentation/{bloc,cubit,pages}`. State management uses `flutter_bloc` (Cubit/Bloc); features: `tuner` (pitch detection by autocorrelation on `record` PCM frames, reference tones generated as WAV and played with `audioplayers`). Preferences are local (`SharedPreferences`); the app has no backend, accounts or sign-in, and audio is never stored.
- `lib/pages/` — top-level screens (home, auto tuner, manual tuner, settings, legal info).
- `lib/widgets/` — reusable widgets (bottom sheets, string selector, cents meter, tuner card, developer info).
- `lib/l10n/` — ARB files plus the generated `app_localizations*.dart` (`flutter gen-l10n`, see `l10n.yaml`).
