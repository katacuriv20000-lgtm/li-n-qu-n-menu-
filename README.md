# LQ Skin Studio — iOS SwiftUI project

Standalone companion/demo app for iPhone. It provides a local skin-catalogue mockup, local kill-notice and UI-sound switches, a demo report-ticket counter, and a local preview reset.

It does **not** modify Arena of Valor / Liên Quân Mobile, unlock server-side skins, change match state, prevent game errors, bypass anti-cheat, or submit/delete player reports. The 20-ticket number is illustrative only.

## Target
- iPhone 8 Plus (A11 / arm64)
- Deployment target: iOS 16.0
- Bundle ID: `vn.nsm.lqskinstudio`

## Build an IPA on macOS
1. Open `LQSkinStudio.xcodeproj` in Xcode 15 or newer.
2. Select the `LQSkinStudio` scheme and an iOS device destination.
3. In Signing & Capabilities, select your Apple Development team and use a unique bundle identifier if needed.
4. Build or Archive, then export the app for installation using a signing method supported by your device.

## TrollStore compatibility
Official TrollStore support does not include iOS 16.7.x (except the distinct 16.7 RC build 20H18). iOS 16.7.16 is listed as unsupported. Having the TrollStore app/icon present does not change the firmware compatibility boundary. Check the exact iOS build in Settings → General → About before relying on TrollStore.

## Included demo features
- No-key local UI
- Illustrative skin preview catalogue
- Local kill-notice and UI-sound toggles
- Demo report-ticket counter (display only)
- Local preview-state reset

## Limitations
This source project is not a prebuilt IPA. A signed IPA must be built with Xcode on macOS. No promise is made that it will be compatible with TrollStore on unsupported firmware.
