# Orange Tree Game

Orange Tree (Angry Birds clone) Steps (condensed steps to creating it):

![preview](https://user-images.githubusercontent.com/20372706/148615978-68cf58da-1875-41f4-adae-c722bfddf0ac.gif)

**1 Setup**

- Download assets
- Create “New Game”
- Copy assets into project

**2 Configure Scene**

- Remove Actions.sks folder
- Change device orientation to landscape right/left only 
- Update GameScene.sksby deleting label and changing width=1334, height=750, anchors=0
- Drag Background.png to scene (z_position= –2, name=background)
- Do the same for the floor Ground.png  (name= ground)
- For the ground, configure its physics definition (Body Type = bounding rectangle, uncheck “Affected by Gravity”)
- Add your OrangeTree.png on top of background (Z position= –1, name=Tree)

**3 Flying Fruit**

On GameViewController.swift  if let scene = SKScene(fileNamed: "GameScene") { and change it to if let scene = GameScene(fileNamed: "GameScene") {
Create new Orange.swift file (attached here)

All credits due to the tutorial link below. I made it using this tutorial.
https://makeschool.org/mediabook/oa/tutorials/learn-to-clone-angry-birds-with-spritekit-and-swift-4/
