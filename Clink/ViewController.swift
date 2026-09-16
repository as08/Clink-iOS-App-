import AVFoundation
import UIKit

final class ViewController: UIViewController {
    private var audioPlayer: AVAudioPlayer?

    // The Bluetooth keypad sends these pairs:
    // Up = jn, Right = hr, Down = yt, Left = im.
    // Listening only for the first character makes each physical press clink once.
    private let triggerCharacters: Set<Character> = ["j", "h", "y", "i"]

    override var canBecomeFirstResponder: Bool { true }
    override var prefersStatusBarHidden: Bool { true }
    override var prefersHomeIndicatorAutoHidden: Bool { true }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureAudio()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // The display remains powered but appears off on an OLED screen.
        // This prevents Auto-Lock from putting the app into the background.
        UIApplication.shared.isIdleTimerDisabled = true
        becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            let characters = key.charactersIgnoringModifiers.lowercased()

            if characters.contains(where: { triggerCharacters.contains($0) }) {
                playClink()
                return
            }
        }

        super.pressesBegan(presses, with: event)
    }

    private func configureAudio() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)

            guard let soundURL = Bundle.main.url(forResource: "coin", withExtension: "mp3") else {
                assertionFailure("coin.mp3 is missing from the app bundle.")
                return
            }

            let player = try AVAudioPlayer(contentsOf: soundURL)
            player.prepareToPlay()
            audioPlayer = player
        } catch {
            assertionFailure("Unable to prepare the clink sound: \(error)")
        }
    }

    private func playClink() {
        guard let audioPlayer else { return }
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
}
