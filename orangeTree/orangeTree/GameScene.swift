import SpriteKit

class GameScene: SKScene {
    
    var orangeTree: SKSpriteNode!
    var orange: Orange?
    
    var touchStart: CGPoint = .zero
    
    // SKShapeNodes are another node type built into SpriteKit.
    // Using an SKShapeNode allows you to add a path that will draw out a shape.
    // On to drawing that launch vector!
    var shapeNode = SKShapeNode()
    
    var boundary = SKNode()
    
    override func didMove(to view: SKView) {
        orangeTree = childNode(withName: "tree") as? SKSpriteNode
        
        // Configure shapeNode (the drawing path)
        shapeNode.lineWidth = 20
        shapeNode.lineCap = .round
        shapeNode.strokeColor = UIColor(white: 1, alpha: 0.3)
        addChild(shapeNode)
        
        // Set the contact delegate (see extension below)
        physicsWorld.contactDelegate = self
        
        // Setup the boundaries (so that oranges don't fly out of the map
        boundary.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: .zero, size: size))
        boundary.position = .zero
        addChild(boundary)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the location of the touch on the screen
        let touch = touches.first!
        let location = touch.location(in: self)
        
        // Check if the touch was on the Orange Tree
        if atPoint(location).name == "tree" {
            // Create the orange and add it to the scene at the touch location
            orange = Orange()
            orange?.physicsBody?.isDynamic = false
            orange?.position = location
            addChild(orange!)
            
            // Store the location of the touch
            touchStart = location
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the location of the touch
        let touch = touches.first!
        let location = touch.location(in: self)
        
        // Update the position of the Orange to the current location
        orange?.position = location
        
        // Draw the firing vector
        let path = UIBezierPath()
        path.move(to: touchStart)
        path.addLine(to: location)
        shapeNode.path = path.cgPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the location of where the touch ended
        let touch = touches.first!
        let location = touch.location(in: self)
        
        // Get the difference between the start and end point as a vector
        // This determines the speed of the orange (configure to your liking
        let dx = (touchStart.x - location.x) * 0.3
        let dy = (touchStart.y - location.y) * 0.3
        let vector = CGVector(dx: dx, dy: dy)
        
        // Set the Orange dynamic again and apply the vector as an impulse
        orange?.physicsBody?.isDynamic = true
        orange?.physicsBody?.applyImpulse(vector)
        
        // Remove the path from shapeNode
        shapeNode.path = nil
    }
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    // Called when the physicsWorld detects two nodes colliding
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        // Check that the bodies collided hard enough
        if contact.collisionImpulse > 15 {
            if nodeA?.name == "skull" {
                removeSkull(node: nodeA!)
            } else if nodeB?.name == "skull" {
                removeSkull(node: nodeB!)
            }
        }
    }
    
    // Function used to remove the Skull node from the scene
    func removeSkull(node: SKNode) {
        node.removeFromParent()
    }
    
}
