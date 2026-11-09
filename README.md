# Guitar Tuner

Microphone guitar tuner in English and Spanish. Auto mode listens to your guitar and shows the note, frequency, and how many cents you are off; manual mode plays a reference tone for each string. No account or sign-in: audio is analyzed on the device and never recorded, and preferences stay on the device.

Flutter **3.47.2** (see [`.tool-versions`](.tool-versions)). Android/iOS package: `io.github.danny270793.guitartunner`.

## Quick start

```sh
asdf exec flutter pub get
asdf exec flutter run
```

Auto mode needs a real device or an emulator with a microphone; the first run asks for microphone access.

## Documentation

- [Run on an emulator or device](docs/getting-started.md)
- [Sync Xcode and publish to the App Store](docs/app-store.md)
- [Bump app version and Flutter SDK](docs/versioning.md)

## Agents

See [AGENTS.md](AGENTS.md) (Claude: [CLAUDE.md](CLAUDE.md)).

## Deploy

`./scripts/deploy.sh` builds a release APK and publishes it to Firebase App Distribution. Before the first run, copy `scripts/.env.deploy.example` to `scripts/.env.deploy` (gitignored), set `FIREBASE_GROUPS` to the tester group alias, and run `firebase login`. `--bump` raises the build number and `--dry-run` prints the commands without running them.
