import SpriteKit
import GameplayKit

protocol IGameSceneDelegate {
    func backButtonTapped()
}

// MARK: -Size of blocks
let BlockSize: CGFloat = 22.0   //23.0
let TickLengthLevelOne = TimeInterval(600)


// MARK: -Class
class GameScene: SKScene {
    
    //Properties
    var gameSceneDelegate: IGameSceneDelegate? = nil
    
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    let LayerPosition = CGPoint(x: UIScreen.main.bounds.width * 0.05,
                                y: -UIScreen.main.bounds.height * 0.13) //20, -70
    
    var tick:(() -> ())?
    var tickLengthMillis = TickLengthLevelOne
    var lastTick:NSDate?
    
    var textureCache = Dictionary<String, SKTexture>()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.0, y: 1.0)
        
        // MARK: -Next shape
        let nextShape = SKSpriteNode(imageNamed: "shape")
        nextShape.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        nextShape.position = CGPoint(x: 600, y: 1120)
        nextShape.zPosition = 0
        //        nextShape.position = CGPoint(x: UIScreen.main.bounds.width * 0.67, y: -UIScreen.main.bounds.height * 0.09)   //50, -300
        //        nextShape.xScale = 0.6
        //        nextShape.yScale = 0.9
        //        nextShape.size = self.size
        //        nextShape.setScale(1.6)
        nextShape.xScale = 1.6
        nextShape.yScale = 1.9
        
        
        // MARK: -Background
        let background = SKSpriteNode(imageNamed: "background")
        let screenPoint = CGPoint(x: 0, y: 0)
        background.position = screenPoint
        background.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        //        background.setScale(0.5)
        background.zPosition = 0
        background.size = self.size
        addChild(background)
        
        addChild(gameLayer)
        
        
        // MARK: -Игровое поле
        let gameBoardTexture = SKTexture(imageNamed: "gameboard")
        let gameBoard = SKSpriteNode(texture: gameBoardTexture,
                                     size: CGSize(width: BlockSize * CGFloat(NumColumns),
                                                  height: BlockSize * CGFloat(NumRows)))
        
        gameBoard.anchorPoint = CGPoint(x: 0, y: 1.0)
        gameBoard.position = LayerPosition
        //        gameBoard.position = CGPoint (x: -UIScreen.main.bounds.width * 0.05,
        //                                      y: -UIScreen.main.bounds.height * 0.1)
        
        
        let gameBoardFrame = SKSpriteNode(imageNamed: "gameboard1")
        gameBoardFrame.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        gameBoardFrame.position = CGPoint(x: -35.0, y: -500.0)
        //        gameBoardFrame.position = CGPoint(x: -UIScreen.main.bounds.width * 0.04,
        //                                          y: -UIScreen.main.bounds.height * 0.7)      //-15, -600
        gameBoardFrame.xScale = 0.46                                                  //0.48
        gameBoardFrame.yScale = 0.48                                                  //0.5
        //        gameBoardBg.size = self.size
        //gameBoardBg.zPosition = -1
        
        //        shapeLayer.addChild(gameBoardFrame)
        gameBoard.addChild(gameBoardFrame)
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        //        shapeLayer.addChild(nextShape)
        gameBoardFrame.addChild(nextShape)
        gameLayer.addChild(shapeLayer)
        
        
        // MARK: -Music
        //run(SKAction.repeatForever(SKAction.playSoundFileNamed("backgroundMusic.mp3", waitForCompletion: true)))
    }
    
    
    // MARK: -Play music
    func playSound(sound: String) {
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
    }
    
    // MARK: -Update
    override func update(_ currentTime: TimeInterval) {
        guard let lastTick = lastTick else { return }
        let timePassed = lastTick.timeIntervalSinceNow * -1000.0
        if timePassed > tickLengthMillis {
            self.lastTick = NSDate()
            tick?()
        }
    }
    
    
    func startTicking() {
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
        //             return CGPointMake(x, y)
        return CGPoint(x: x, y: y)
    }
    
    // MARK: -addPreviewShapeToScene
    func addPreviewShapeToScene(shape:Shape, completion:@escaping () -> ()) {
        for block in shape.blocks {
            // #10
            var texture = textureCache[block.spriteName]
            if texture == nil {
                texture = SKTexture(imageNamed: block.spriteName)
                textureCache[block.spriteName] = texture
            }
            let sprite = SKSpriteNode(texture: texture)
            // #11
            sprite.position = pointForColumn(column: block.column, row:block.row - 2)
            shapeLayer.addChild(sprite)
            block.sprite = sprite
            
            // Animation
            sprite.alpha = 0.5 //0
            // #12
            let moveAction = SKAction.move(to: pointForColumn(column: block.column, row: block.row), duration: TimeInterval(0.2))
            moveAction.timingMode = .easeOut
            let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 0.4)
            fadeInAction.timingMode = .easeOut
            sprite.run(SKAction.group([moveAction, fadeInAction]))
        }
        run(SKAction.wait(forDuration: 0.4), completion: completion)
    }
    
    // MARK: -movePreviewShape
    func movePreviewShape(shape:Shape, completion:@escaping () -> ()) {
        for block in shape.blocks {
            let sprite = block.sprite!
            let moveTo = pointForColumn(column: block.column, row:block.row)
            let moveToAction:SKAction = SKAction.move(to: moveTo, duration: 0.2)
            moveToAction.timingMode = .easeOut
            sprite.run(
                SKAction.group([moveToAction, SKAction.fadeAlpha(to: 1.0, duration: 0.2)]), completion: {})
        }
        run(SKAction.wait(forDuration: 0.2), completion: completion)
    }
    
    // MARK: -redrawShape
    func redrawShape(shape:Shape, completion:@escaping () -> ()) {
        for block in shape.blocks {
            let sprite = block.sprite!
            let moveTo = pointForColumn(column: block.column, row:block.row)
            let moveToAction:SKAction = SKAction.move(to: moveTo, duration: 0.05)
            moveToAction.timingMode = .easeOut
            if block == shape.blocks.last {
                sprite.run(moveToAction, completion: completion)
            } else {
                sprite.run(moveToAction)
            }
        }
    }
    
    
    // MARK: -Исчезновение блоков
    // #1
    func animateCollapsingLines(linesToRemove: Array<Array<Block>>, fallenBlocks: Array<Array<Block>>, completion:@escaping () -> ()) {
        var longestDuration: TimeInterval = 0
        // #2
        for (columnIdx, column) in fallenBlocks.enumerated() {
            for (blockIdx, block) in column.enumerated() {
                let newPosition = pointForColumn(column: block.column, row: block.row)
                let sprite = block.sprite!
                // #3
                let delay = (TimeInterval(columnIdx) * 0.05) + (TimeInterval(blockIdx) * 0.05)
                let duration = TimeInterval(((sprite.position.y - newPosition.y) / BlockSize) * 0.1)
                let moveAction = SKAction.move(to: newPosition, duration: duration)
                moveAction.timingMode = .easeOut
                sprite.run(
                    SKAction.sequence([
                        SKAction.wait(forDuration: delay),
                        moveAction]))
                longestDuration = max(longestDuration, duration + delay)
            }
        }
        
        for rowToRemove in linesToRemove {
            for block in rowToRemove {
                // #4
                let randomRadius = CGFloat(UInt(arc4random_uniform(400) + 100))
                let goLeft = arc4random_uniform(100) % 2 == 0
                
                var point = pointForColumn(column: block.column, row: block.row)
                point = CGPoint(x: point.x + (goLeft ? -randomRadius : randomRadius), y: point.y)
                
                let randomDuration = TimeInterval(arc4random_uniform(2)) + 0.5
                // #5
                var startAngle = CGFloat(Double.pi)
                var endAngle = startAngle * 2
                if goLeft {
                    endAngle = startAngle
                    startAngle = 0
                }
                let archPath = UIBezierPath(arcCenter: point, radius: randomRadius, startAngle: startAngle, endAngle: endAngle, clockwise: goLeft)
                let archAction = SKAction.follow(archPath.cgPath, asOffset: false, orientToPath: true, duration: randomDuration)
                archAction.timingMode = .easeIn
                let sprite = block.sprite!
                // #6
                sprite.zPosition = 100
                sprite.run(
                    SKAction.sequence(
                        [SKAction.group([archAction, SKAction.fadeOut(withDuration: TimeInterval(randomDuration))]),
                         SKAction.removeFromParent()]))
            }
        }
        // #7
        run(SKAction.wait(forDuration: longestDuration), completion:completion)
    }
}
