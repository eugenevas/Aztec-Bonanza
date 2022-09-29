
import Foundation
import AVFoundation

class MusicPlayer {

    var musicPlayer: AVAudioPlayer!

    let ud = UserDefaults.standard

    var isSoundOn = true
    var isMusicOn = true

    private let musicKey = "music"
    private let soundKey = "sound"

    static let shared = MusicPlayer()

    //Initializer access level change now
    private init(){
    }

    func playMusic(from path: URL?) {
        if let musicPath = path {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
            } catch {
                print(error.localizedDescription)
            }
            musicPlayer.play()
            musicPlayer.numberOfLoops = -1 //отрицательное число - бесконечность
        }
    }

    func loadGameSettings() {
        isMusicOn = ud.bool(forKey: musicKey)
        isSoundOn = ud.bool(forKey: soundKey)
    }

    func updateSound() {
        ud.set(isSoundOn, forKey: soundKey)
    }

    func updateMusic() {
        ud.set(isMusicOn, forKey: musicKey)
    }
}




