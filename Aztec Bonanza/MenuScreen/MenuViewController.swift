import UIKit

class MenuViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds
    
    var soundButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sound"), for: .normal)
        return button
    }()
    
    var musicButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "music"), for: .normal)
        return button
    }()
    
//    override func loadView() {
//        view = MenuView()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background1")!)
        //        self.view.frame.size = self.size
        MusicPlayer.shared.loadGameSettings()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    private func menuView() -> MenuView {
//       return self.view as! MenuView
//    }

    
    
    @IBAction func playButton(_ sender: UIButton) {
    }

    
    
    @IBAction func musicButton(_ sender: UIButton) {
        changeMusicState()
    }


    @IBAction func soundButton(_ sender: UIButton) {
        changeSoundState()
    }

    
    private func playMusic() {
        if MusicPlayer.shared.isMusicOn {
            MusicPlayer.shared.playMusic(from: Music.backgroundMusic)
        }
    }
    
    private func changeSoundState() {
        if MusicPlayer.shared.isSoundOn {
            MusicPlayer.shared.isSoundOn = false
            soundButton.setImage(UIImage(named: "soundOff"), for: .normal)
        } else {
            MusicPlayer.shared.isSoundOn = true
            soundButton.setImage(UIImage(named: "sound"), for: .normal)
        }
        MusicPlayer.shared.updateSound()
    }
    
    private func changeMusicState() {
        if MusicPlayer.shared.musicPlayer == nil {
            MusicPlayer.shared.playMusic(from: Music.backgroundMusic)
            MusicPlayer.shared.musicPlayer.stop()
        }
        if MusicPlayer.shared.musicPlayer.isPlaying {
            MusicPlayer.shared.isMusicOn = false
            musicButton.setImage(UIImage(named: "musicOff"), for: .normal)
            MusicPlayer.shared.musicPlayer.stop()
        } else {
            MusicPlayer.shared.isMusicOn = true
            musicButton.setImage(UIImage(named: "music"), for: .normal)
            MusicPlayer.shared.musicPlayer.play()
        }
        MusicPlayer.shared.updateMusic()
    }
    
    
}
