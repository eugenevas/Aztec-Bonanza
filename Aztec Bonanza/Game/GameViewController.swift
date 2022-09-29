import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    
    var scene: GameScene!
    var swiftris: Swiftris!
    var panPointReference:CGPoint?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    
//    override func loadView() {
//        view = SKView(frame: UIScreen.main.bounds)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: self.view.bounds.size)  //skView.bounds.size
        
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene.scaleMode = .aspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        
        // Present the scene.
        skView.presentScene(scene)
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func goToMenu(_ sender: UIButton) {
        print(navigationController?.viewControllers)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: -!!!!!
    // MARK: -didTick
    func didTick() {
        swiftris.letShapeFall()
        
        //        swiftris.fallingShape?.lowerShapeByOneRow()
        //        scene.redrawShape(shape: swiftris.fallingShape!, completion: {})
    }
    
    // #14
    //    scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
    //    self.swiftris.nextShape?.moveTo(column: StartingColumn, row: StartingRow)
    //    self.scene.movePreviewShape(shape: self.swiftris.nextShape!) {
    //    let nextShapes = self.swiftris.newShape()
    //    self.scene.startTicking()
    //    self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape!) {}
    //        }
    //    }
    
    // MARK: -didTap
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    
    
    // MARK: -didPan
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translation(in: self.view)
        if let originalPoint = panPointReference {
            // #3
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                // #4
                if sender.velocity(in: self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .began {
            panPointReference = currentPoint
        }
    }
    
    // MARK: -didSwipe
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        swiftris.dropShape()
        self.view.isUserInteractionEnabled = true
        print("Swiped down")
    }
    
    
    private func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    
    // MARK: -nextShape
    func nextShape() {
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!) {}
        self.scene.movePreviewShape(shape: fallingShape) {
            // #16
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    // MARK: -gameDidBegin
    func gameDidBegin(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    
    // MARK: -gameDidEnd
    func gameDidEnd(swiftris: Swiftris) {
        
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        
        print("game over")
        
        scene.playSound(sound: "gameover.mp3")
//        if MusicPlayer.shared.isSoundOn {
//            self.run(Music.gameOver)
//        }
        
        scene.animateCollapsingLines(linesToRemove: swiftris.removeAllBlocks(), fallenBlocks: swiftris.removeAllBlocks()) {
            swiftris.beginGame()
//            self.scene.playSound(sound: "gameover.mp3")
        }
        
        
        
    }
    
    // MARK: -На уровень выше
    //Каждый раз когда повышается уровень, фигуры начинают двигаться быстрее
    func gameDidLevelUp(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        } else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 50
        }
        
        
        scene.playSound(sound: "levelup.mp3")
    }
    
    // MARK: -!!!!!
    // MARK: -Фигура упала
    func gameShapeDidDrop(swiftris: Swiftris) {
        scene.stopTicking()
        scene.redrawShape(shape: swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
        
        scene.playSound(sound: "drop.mp3")
    }
    
    // MARK: -Фигура приземлилась
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        //        nextShape()
        self.view.isUserInteractionEnabled = false
        let removedLines = swiftris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(swiftris.score)"
            scene.animateCollapsingLines(linesToRemove: removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                // #11
                self.gameShapeDidLand(swiftris: swiftris)
            }
            scene.playSound(sound: "bomb.mp3")
        } else {
            nextShape()
        }
        
    }
    
    // MARK: -Фигура перемещается
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(shape: swiftris.fallingShape!) {}
    }
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        if let view = self.view as! SKView? {
    //            // Load the SKScene from 'GameScene.sks'
    //            if let scene = SKScene(fileNamed: "GameScene") {
    //                // Set the scale mode to scale to fit the window
    //                scene.scaleMode = .aspectFill
    //
    //                // Present the scene
    //                view.presentScene(scene)
    //            }
    //
    //            view.ignoresSiblingOrder = true
    //
    //            view.showsFPS = true
    //            view.showsNodeCount = true
    //        }
    //    }
    //
    //    override var shouldAutorotate: Bool {
    //        return true
    //    }
    //
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        if UIDevice.current.userInterfaceIdiom == .phone {
    //            return .allButUpsideDown
    //        } else {
    //            return .all
    //        }
    //    }
    //
    
}






