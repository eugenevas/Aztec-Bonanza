//
//  MenuScene.swift
//  Fruitris
//
//  Created by Евгений Васильев on 02.07.2020.
//  Copyright © 2020 Eugene Vasilyev. All rights reserved.
//


import SpriteKit

class MenuScene: SKScene {
    
//    override func didMove(to view: SKView) {
//        
//        let background = SKSpriteNode(imageNamed: "background1")
//        background.anchorPoint = .zero
//        background.size = view.frame.size
//        background.zPosition = 0
//        self.addChild(background)
//        
//        
//        let logo = SKSpriteNode(imageNamed: "logo")
//        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 110)
//        //logo.setScale(0.7)
//        logo.zPosition = 1
//        self.addChild(logo)
//        
//        let texture = SKTexture(imageNamed: "btn_play")
//        let play = SKSpriteNode(texture: texture)
//        play.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
//        play.name = "play"
//        play.setScale(0.8)
//        play.zPosition = 1
//        self.addChild(play)
//        
//        let texture1 = SKTexture(imageNamed: "btn_options")
//        let options = SKSpriteNode(texture: texture1)
//        options.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 130)
//        options.name = "options"
//        options.setScale(0.8)
//        options.zPosition = 1
//        self.addChild(options)
//        
//        
//        let texture2 = SKTexture(imageNamed: "btn_best")
//        let best = SKSpriteNode(texture: texture2)
//        best.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 210)
//        best.name = "best"
//        best.setScale(0.8)
//        best.zPosition = 1
//        self.addChild(best)
//        
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first!.location(in: self)
//        let node = self.atPoint(location)
//        
//        if node.name == "play" {
//            let transition = SKTransition.crossFade(withDuration: 1.0)
//            let gameScene = GameScene(size: self.size)
//            gameScene.scaleMode = .aspectFill
//            self.scene?.view?.presentScene(gameScene, transition: transition)
//            
//        } else if node.name == "options" {
//            
//            let transition = SKTransition.crossFade(withDuration: 1.0)
//            let optionsScene = OptionsScene(size: self.size)
//            //optionsScene.backScene = self
//            optionsScene.scaleMode = .aspectFill
//            self.scene?.view?.presentScene(optionsScene, transition: transition)
//            
//        } else if node.name == "best" {
//            
//            let transition = SKTransition.crossFade(withDuration: 1.0)
//            let betsScene = BestScene(size: self.size)
//            //betsScene.backScene = self
//            betsScene.scaleMode = .aspectFill
//            self.scene?.view?.presentScene(betsScene, transition: transition)
//            
//        }
//    }
}

