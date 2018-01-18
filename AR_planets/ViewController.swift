//
//  ViewController.swift
//  AR_planets
//
//  Created by Mac User on 7/12/17.
//  Copyright © 2017 Mac User. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration=ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
    self.sceneView.debugOptions=[ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun=planet(geometry:SCNSphere(radius:0.35), diffuse: #imageLiteral(resourceName: "Sun_diffuse"), specular: nil, emission:nil, normal: nil, position: SCNVector3(0,0,-1))
        
        let earthParent=SCNNode()
        let venusParent=SCNNode()
        let moonParent=SCNNode()
        
        earthParent.position=SCNVector3(0,0,-1)
        venusParent.position=SCNVector3(0,0,-1)
        moonParent.position=SCNVector3(1.2,0,0)
        
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        //Geo creation
       
        
        let earth=planet(geometry:SCNSphere(radius:0.2), diffuse: #imageLiteral(resourceName: "Earth_day"), specular: #imageLiteral(resourceName: "Earth_specular"), emission: #imageLiteral(resourceName: "Earth_emission"), normal: #imageLiteral(resourceName: "Earth_normal"), position: SCNVector3(1.2,0,0))
        
        let venus=planet(geometry:SCNSphere(radius:0.1), diffuse: #imageLiteral(resourceName: "Venus_diffuse"), specular: nil, emission: #imageLiteral(resourceName: "Venus_emission"), normal: nil, position: SCNVector3(0.7,0,0))
        
         let moon=planet(geometry:SCNSphere(radius:0.05),diffuse: #imageLiteral(resourceName: "Moon_diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))

       
        let sunAction=rotation(time: 8)
        let earthParentRotation=rotation(time: 14)
        let venusParentRotation=rotation(time:10)
        let earthRotation=rotation(time: 8)
        let moonRotation=rotation(time: 1)
        let venusRotation=rotation(time: 8)
        
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
        
        sun.runAction(sunAction)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        venusParent.addChildNode(venus)
        earth.addChildNode(moon)
        moonParent.addChildNode(moon)
    }
    
    func planet(geometry:SCNGeometry,diffuse:UIImage,specular:UIImage?,emission:UIImage?,normal:UIImage?,position:SCNVector3)->SCNNode{
        let planet=SCNNode(geometry:geometry)
        planet.geometry?.firstMaterial?.diffuse.contents=diffuse
        planet.geometry?.firstMaterial?.specular.contents=specular
        planet.geometry?.firstMaterial?.emission.contents=emission
        planet.geometry?.firstMaterial?.normal.contents=normal
        planet.position=position
        return planet
    }
    
    func rotation(time:TimeInterval)->SCNAction{
        let rotation=SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation=SCNAction.repeatForever(rotation)
        return foreverRotation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}


