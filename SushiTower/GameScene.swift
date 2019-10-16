//
//  GameScene.swift
//  SushiTower
//
//  Created by Parrot on 2019-02-14.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let cat = SKSpriteNode(imageNamed: "character1")
    let sushiBase = SKSpriteNode(imageNamed:"roll")
    let background = SKSpriteNode(imageNamed: "background")
    
    // making a tower
    var sushiTower:[SKSpriteNode] = []
    func spawnSushi()
    {
        // 1. Make a sushi
        let sushi = SKSpriteNode(imageNamed: "roll")
        
        // 2. Position sushi 10px above the previous one
        if(self.sushiTower.count == 0)
        {
            sushi.position.x = self.size.width*0.5
            sushi.position.y = self.sushiBase.position.y + 80
        }
        
        else {
            let previousSushi = sushiTower.last
            sushi.position.x = self.size.width*0.5
            sushi.position.y = self.sushiBase.position.y + 80
            }
        
        // 3. Add sushi to array
        addChild(sushi)
        
        // 4. Add sushi to screen
        self.sushiTower.append(sushi)
    }
    
    override func didMove(to view: SKView) {
        
        // add background
//        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        // add cat
        cat.position = CGPoint(x:self.size.width*0.25, y:100)
        addChild(cat)
        
        // add base sushi pieces
        sushiBase.position = CGPoint(x:self.size.width*0.5, y: 100)
        addChild(sushiBase)
        
        //build the tower
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        self.spawnSushi()
        
        self.buildTower()
    }
    
    
    // function of build Tower
    func buildTower()
    {
        for _ in 0...5
        {
            self.spawnSushi()
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // This is the shortcut way of saying:
        //      let mousePosition = touches.first?.location
        //      if (mousePosition == nil) { return }
        guard let mousePosition = touches.first?.location(in: self) else {
            return
        }
        
        print(mousePosition)
        
        //detect where person clicked on screen
        let middleofScreen = self.size.width / 2
        if(mousePosition.x < middleofScreen)
        {
            print("Tap Left")
            // person clicked left so cat moves left
            cat.position = CGPoint(x:self.size.width*0.25, y:100)
            
            // change the cat direction
            let facingRight = SKAction.scale(to: 1, duration: 0)
            self.cat.run(facingRight)
        }
        
        else {
            print("Tap Right")
            // person clicked right so cat moves right
            cat.position = CGPoint(x:self.size.width*0.85, y:100)
            
            // change the cat direction
            let facingLeft = SKAction.scale(to: -1, duration: 0)
            self.cat.run(facingLeft)
        }
        
        // show animation of cat punching tower
        let image1 = SKTexture(imageNamed: "character1")
        let image2 = SKTexture(imageNamed: "character2")
        let image3 = SKTexture(imageNamed: "character3")
        
        // array for punching texture
        let punchTexture = [image1,image2,image3,image1]
        
        let punchAnimation = SKAction.animate(with: punchTexture, timePerFrame: 0.1)
        
        self.cat.run(punchAnimation)
    }
    
}
