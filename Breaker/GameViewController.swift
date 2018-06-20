//
//  GameViewController.swift
//  Breaker
//
//  Created by Larry Petroski on 6/10/18.
//  Copyright © 2018 Larry Petroski. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var scnView: SCNView!
    var game = GameHelper.sharedInstance
    var scnScene: SCNScene!
    var horizontalCameraNode: SCNNode!
    var verticalCameraNode: SCNNode!
    var ballNode: SCNNode!
    var paddleNode: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        setupNodes()
        setupSounds()
    }
    
    func setupScene() {
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
        scnView.scene = scnScene
    }
    
    func setupNodes() {
        horizontalCameraNode = scnScene.rootNode.childNode(withName: "HorizontalCamera", recursively: true)!
        verticalCameraNode = scnScene.rootNode.childNode(withName: "VerticalCamera", recursively: true)!
        scnScene.rootNode.addChildNode(game.hudNode)
        
        ballNode = scnScene.rootNode.childNode(withName: "Ball", recursively: true)!
        paddleNode = scnScene.rootNode.childNode(withName: "Paddle", recursively: true)!
    }
    
    func setupSounds() {
    }
    
    override var shouldAutorotate: Bool { return true }
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientation = UIDevice.current.orientation
        
        switch (deviceOrientation) {
        case .portrait:
            scnView.pointOfView = verticalCameraNode
        default:
            scnView.pointOfView = horizontalCameraNode
        }
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        game.updateHUD()
    }
}
