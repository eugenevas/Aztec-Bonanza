import SpriteKit

enum Music {
    static let backgroundMusic: URL? = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3")
    static let gameOver = SKAction.playSoundFileNamed("gameover", waitForCompletion: true)
    static let youWin = SKAction.playSoundFileNamed("You Win", waitForCompletion: true)
    static let rightAction = SKAction.playSoundFileNamed("Right", waitForCompletion: true)
}
