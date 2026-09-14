# AuronNetwork Multi-Game Trainer

Official release downloads for the AuronNetwork Multi-Game Trainer.

- Website: [auronnetwork.net](https://auronnetwork.net/)
- Downloads: [GitHub Releases](https://github.com/AuronNetwork/trainer/releases)

This is a **release-distribution repository**. Trainer source code, private keys,
account data and staging configurations are not published here.

## Repository migration

The previous `Auron-Network/trainer` repository is no longer available.
The original version 3.28 is being restored here as an unchanged historical
download. Its embedded updater still points to the previous repository;
rehosting this file alone does not repair updates in existing installations.

A client built for this new update channel must be downloaded manually once.
After that migration, future signed updates can be discovered through this
repository. Do not treat the archived 3.28 build as an update-channel fix.

## Before running or updating

Use supported local single-player games only. Back up your saves, disable active
boosts, restore owned radius changes and close other trainer instances first.
Read the release notes and the included `README_EN.txt` / `README_DE.txt`.

Microsoft Defender previously detected `Behavior:Win32/DefenseEvasion.A!ml`
during a live test of version 3.23. This detection has not been cleared by
Microsoft or independently confirmed as a false positive. The executable has
no Windows Authenticode signature. The separate RSA-signed update manifest
verifies authenticity and integrity, not antivirus safety.

Do not disable protection or add exclusions to bypass a detection. If the trainer
is blocked, stop and seek review. See [SECURITY_NOTICE.txt](SECURITY_NOTICE.txt).
