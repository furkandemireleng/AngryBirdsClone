//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by MacxbookPro on 1.02.2020.
//  Copyright © 2020 MacxbookPro. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var gameStarted = false
    
    //var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var originalPosition: CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {
        //enumunzun tipi ui32 bunun sebebi carpisma esnasinda bize bildirim gonderecek olan sistemin sinifi bu o yuzden oyle yaptik.
        //burada olan1-2-4-8 ise surdan geliyor ikisinin toplami 3.'yu vermeyecek yani 1 ve 2 o yuzden 3 yapmadik cunku toplamlari 3 gibi gibi
        case Bird = 1
        case Box = 2
                
    }
    
    override func didMove(to view: SKView) {
        /*
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: -self.frame.width / 4, y: -self.frame.height / 4)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
         */
        // physics body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)//bir cerceve olusturuyor yani kus duser ama ekranda kalir yani kaybolmaz
        self.scene?.scaleMode = .aspectFit //goruntuleri ekrana sigdirir
        self.physicsWorld.contactDelegate = self//
        //bird
        
        bird = childNode(withName: "bird") as! SKSpriteNode //kusu olusturduk
        
        let birdTexture = SKTexture(imageNamed: "bird") //gorselde ki kusu aldik - bu islemi asagida yaptik sebebi de kusun gercek
        
        //kusun fiziksel ozellikleri
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)//boyut istiyor burada ne demek boyut fiziksel vucut olarak kusu dusun mesela dikdortgen olsa rectangle kullanirdik bizim kus yuvarlak zaten
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.20//kilo
        originalPosition = bird.position //kusun baslangic pozisyonunu al
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        
        
       //boxes
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().height / 5)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)//diktorgene benzedikleri icin regrenle
        box1.physicsBody?.isDynamic=true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true //saga sola donebilir mi
        box1.physicsBody?.mass = 0.4//mass
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue//kus kutya carptiginda haberdar olmak icin bunu yaptik
     
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic=true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true //saga sola donebilir mi
        box2.physicsBody?.mass = 0.4//mass
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue//kus kutya carptiginda haberdar olmak icin bunu yaptik
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic=true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true //saga sola donebilir mi
        box3.physicsBody?.mass = 0.4//mass
        
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue//kus kutya carptiginda haberdar olmak icin bunu yaptik
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic=true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true //saga sola donebilir mi
        box4.physicsBody?.mass = 0.4//mass
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue//kus kutya carptiginda haberdar olmak icin bunu yaptik
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic=true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true //saga sola donebilir mi
        box5.physicsBody?.mass = 0.4//mass
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue//kus kutya carptiginda haberdar olmak icin bunu yaptik
         
        //Label
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4) // x 0 yani ortada durur
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //carpisma olduktan sonra buradayiz
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //dokundugunda gerceklesen olaylar
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         //dokunma basladi
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))//bir etki olusturur
        bird.physicsBody?.affectedByGravity = true
        */
        if gameStarted == false {
            if let touch = touches.first {
                //touches'i fonksyiondan aldik burada diyoruz ki eger touches'i alabilirsek
                let touchLocation = touch.location(in: self)//dokunulan noktayi aldik
                let touchNodes =  nodes(at: touchLocation)//hangi node ? dokunulan node
                
                
                if touchNodes.isEmpty == false {//bos degilse yani dokunulan bir node var ise
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            //neden boyle bi sey yaptik neden skspritenode olarak cast etmeye calisiyoruz
                            //cunku bizim bu dokundugumuz sey kus ile ayni mi onu kontrol edicez
                            if sprite == bird {
                                //kusta spirte'ta bir SKSpriteNode
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         //tutup cekti
        if gameStarted == false {
            if let touch = touches.first {
                //touches'i fonksyiondan aldik burada diyoruz ki eger touches'i alabilirsek
                let touchLocation = touch.location(in: self)//dokunulan noktayi aldik
                let touchNodes =  nodes(at: touchLocation)//hangi node ? dokunulan node
                
                
                if touchNodes.isEmpty == false {//bos degilse yani dokunulan bir node var ise
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            //neden boyle bi sey yaptik neden skspritenode olarak cast etmeye calisiyoruz
                            //cunku bizim bu dokundugumuz sey kus ile ayni mi onu kontrol edicez
                            if sprite == bird {
                                //kusta spirte'ta bir SKSpriteNode
                                bird.position = touchLocation
                                
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                //touches'i fonksyiondan aldik burada diyoruz ki eger touches'i alabilirsek
                let touchLocation = touch.location(in: self)//dokunulan noktayi aldik
                let touchNodes =  nodes(at: touchLocation)//hangi node ? dokunulan node
                
                
                if touchNodes.isEmpty == false {//bos degilse yani dokunulan bir node var ise
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            //neden boyle bi sey yaptik neden skspritenode olarak cast etmeye calisiyoruz
                            //cunku bizim bu dokundugumuz sey kus ile ayni mi onu kontrol edicez
                            if sprite == bird {
                                //kusta spirte'ta bir SKSpriteNode
                                
                                //firlatma burada basliyor
                                //- verdik cunku -yonde gitmesini istiyoruz
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)//kusa impulse'i ekledik
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                            }
                        }
                        
                    }
                }
            }
        }

       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //biz buraya bir sey yazarsak devamli kontrol edilecek yani kusun durup durmadigini buradan anlicaz
        
        if let birdPysicsBody = bird.physicsBody{
            
            if birdPysicsBody.velocity.dx <= 0.1 && birdPysicsBody.velocity.dy <= 0.1 && birdPysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                //velocity hiz demek
                //angular velocity acisal hiz demek
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.zPosition = 1
                bird.position = originalPosition!
                gameStarted = false
            }
        }
        
    }
}

