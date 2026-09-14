# AuronNetwork Multi-Game Trainer

Official release downloads for the AuronNetwork Multi-Game Trainer.

- Website: [auronnetwork.net](https://auronnetwork.net/)
- Current download: [Trainer 3.28.2](https://github.com/AuronNetwork/trainer/releases/tag/v3.28.2)
- Original archive: [Trainer 3.28](https://github.com/AuronNetwork/trainer/releases/tag/v3.28)

This is a **release-distribution repository**. Trainer source code, private keys,
account data and staging configurations are not published here.

## Repository migration

The previous `Auron-Network/trainer` repository is no longer available.
The original version 3.28 has been restored here as an unchanged historical
download. Its embedded updater still points to the previous repository;
rehosting this file alone does not repair updates in existing installations.

Download **3.28.2 manually once** to migrate to the new update channel.
After that, future signed updates can be discovered through Settings in the
trainer. Download and installation still require confirmation. No GitHub account
is needed. Do not treat the archived 3.28 build as an update-channel fix.

3.28.2 is based on the original public 3.28 and only changes the version, update
repository and matching Settings labels. Games and cheats are unchanged.
No account, licensing or staging integration is included.

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
