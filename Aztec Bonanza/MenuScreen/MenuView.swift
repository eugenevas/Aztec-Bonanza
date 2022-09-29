//
//import UIKit
//
//class MenuView: UIView {
//
//    var scoresLabel = UILabel()
//
//
//    var playButton: UIButton = {
//        let button = UIButton()
//        button.setBackgroundImage(UIImage(named: "btn_play"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
////        button.setTitle("Play", for: .normal)
////        button.backgroundColor = .purple
//
//        return button
//    }()
//    
//    var soundButton: UIButton = {
//        let button = UIButton()
//        button.setBackgroundImage(UIImage(named: "sound"), for: .normal)
//        button.imageView?.contentMode = .right
////        button.setTitle("Sound", for: .normal)
////        button.backgroundColor = .purple
//
//        return button
//    }()
//
//    var musicButton: UIButton = {
//        let button = UIButton()
//        button.setBackgroundImage(UIImage(named: "music"), for: .normal)
//        button.imageView?.contentMode = .left
////        button.setTitle("Music", for: .normal)
////        button.backgroundColor = .purple
//
//        return button
//    }()
//
//
//
//    init() {
//        super.init(frame: UIScreen.main.bounds)
//        //backgroundColor = .white
//        addElementsOnView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func backgroundImage() {
//
//    }
//
//
//    private func addElementsOnView() {
//        let stackView = stack(scoresLabel,
//                              playButton,
//                              soundButton,
//                              musicButton,
//                              spacing: 10,
//                              axis: .vertical,
//                              distribution: .fillEqually)
//
//        addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
//
//        ])
//    }
//
//}
//
