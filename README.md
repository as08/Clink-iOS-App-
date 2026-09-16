# Clink

Clink is a tiny iOS utility for use with a Bluetooth keypad. The app displays a completely black screen and plays a short coin-clink sound when one of four configured keypad directions is pressed.

It was built as a simple magic-performance utility: on an OLED iPhone, the all-black interface makes the display appear to be off while the app remains active and listening for keypad input.

## Features

- Completely black app screen
- Black launch screen
- Status bar hidden
- Home indicator automatically fades
- Prevents Auto-Lock while Clink is open
- Plays a bundled `coin.mp3` sound
- Uses the normal iPhone audio output
- Audio works when the iPhone is in Silent mode
- No network access
- No tracking or analytics
- No microphone or camera access
- No external packages or dependencies

## Bluetooth keypad mapping

Keypad used: 

https://www.amazon.co.uk/dp/B0C7BC5QM4

https://www.amazon.com/dp/B091V12J6Z

Brand: VBESTLIFE

Model name: VBESTLIFEf7ikx1s5p9

The keypad used with the original project sends two characters for each direction:

| Direction | Characters sent | Character Clink reacts to |
| --- | --- | --- |
| Up | `jn` | `j` |
| Right | `hr` | `h` |
| Down | `yt` | `y` |
| Left | `im` | `i` |

Clink intentionally listens only for `j`, `h`, `y`, and `i`. The second character in each pair is ignored so one physical button press produces one clink.

The relevant code is in [`Clink/ViewController.swift`](Clink/ViewController.swift).

## Requirements

- iPhone running iOS 16 or later
- Xcode capable of building for your installed iOS version
- Apple Account for code signing
- Developer Mode enabled on the iPhone
- Bluetooth keypad that presents itself as a hardware keyboard

## Building and installing

1. Clone or download this repository.
2. Open `Clink.xcodeproj` in Xcode.
3. Select the **Clink** target.
4. Open **Signing & Capabilities**.
5. Enable **Automatically manage signing**.
6. Select your Apple Development Team / Personal Team.
7. If Xcode reports that the bundle identifier is unavailable, change it to a unique identifier of your own.
8. Connect and unlock your iPhone.
9. Select the iPhone as the run destination.
10. Press **Run** (`⌘R`).

If you are using a free Personal Team, the development provisioning profile expires after 7 days. Reconnect the iPhone and run the project from Xcode again to refresh it.

## Using Clink

1. Pair the keypad under **Settings → Bluetooth** on the iPhone.
2. Set the media volume to the desired level.
3. Open Clink.
4. Press any configured direction on the keypad.

The app must remain in the foreground to receive hardware-keyboard events.

## Customising the sound

Replace:

```text
Clink/coin.mp3
```

with another MP3 using the same filename, or change the resource name in `ViewController.swift`.

If you publish a modified repository, make sure you have permission to redistribute any audio file you include.

## How it works

Clink subclasses `UIViewController` and handles physical keyboard input through UIKit's `pressesBegan(_:with:)` responder method. When a configured character is detected, an `AVAudioPlayer` is reset to the beginning of the bundled sound and played immediately.

The audio session uses the `.playback` category with `.mixWithOthers`, allowing the sound to play independently of the iPhone's Silent switch while avoiding background-audio functionality.

## Privacy

Clink contains no networking, analytics, advertising, tracking, account system or data collection. Everything happens locally on the device.

## License

MIT License: Free to use, modify, and distribute for both commercial and non-commercial purposes. 
