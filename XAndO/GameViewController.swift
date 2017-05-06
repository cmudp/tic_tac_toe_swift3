//
//  ViewController.swift
//  XAndO
//
//  Created by Student Doi on 22/04/2017.
//  Copyright © 2017 Student Doi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    //MARK: - Properties/Constants
    
    // Dimensiuni relative la ecran
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0    
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initialize()
        self.changeBackgroundColor()
        self.createScoreView()
        self.createGameView()
    }
    
    func initialize() {
        self.screenWidth = self.view.frame.size.width
        self.screenHeight = self.view.frame.size.height
    }

    //MARK: - Create views
    
    func changeBackgroundColor(){
        // self.view is a property of UiViewController
        // .backgroundColor is a property of UiView
        self.view.backgroundColor = UIColor.blue
    }
    
    func createScoreView(){
        
        // UI from UIKit
        let containerView = UIView()
        
        // CG is core graphics and Rect is rectangle
        containerView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.screenWidth,
                                     height: self.screenHeight * 0.4)
        
        containerView.backgroundColor = UIColor(red: 0.95,
                                       green: 0.86,
                                       blue: 0.05,
                                       alpha: 1)
        
        self.view.addSubview(containerView)
        
        let player1Label = UILabel(frame: CGRect(x: 5,
                  y: 20,
                  width: 120,
                  height: 30)
        )
        player1Label.text = "Player 1"
        player1Label.textColor = UIColor.brown
        player1Label.font = UIFont.boldSystemFont(ofSize: 28)
        containerView.addSubview(player1Label)
        
        let vsLabel = UILabel(frame: CGRect(x: 5,
                                                 y: 50,
                                                 width: 100,
                                                 height: 30)
        )
        vsLabel.text = "vs"
        vsLabel.textColor = UIColor.brown
        vsLabel.font = UIFont.boldSystemFont(ofSize: 28)
        vsLabel.textAlignment = NSTextAlignment.center
        containerView.addSubview(vsLabel)
        
        let player2Label = UILabel(frame: CGRect(x: 5,
                                                 y: 80,
                                                 width: 120,
                                                 height: 30)
        )
        player2Label.text = "Player 2"
        player2Label.textColor = UIColor.brown
        player2Label.font = UIFont.boldSystemFont(ofSize: 28)
        containerView.addSubview(player2Label)
        
        //logo
        let imageWidth = CGFloat(239.0)
        let imageHeight = CGFloat(160.0)
        let imageView = UIImageView(frame: CGRect(x: screenWidth - imageWidth - 10,
                                                  y: 30,
                                                  width: imageWidth,
                                                  height: imageHeight))
        imageView.image = UIImage(named: "Logo")
        containerView.addSubview(imageView)
        
//        let imageName = "image1.jpg"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: 125, y: 0, width: 400, height: 200)
//        containerView.addSubview(imageView)
        
        //reset button
        let resetButton = UIButton(frame: CGRect(x: screenWidth - 100,
                                                 y: screenHeight * 0.4 - 60,
                                                 width: 50,
                                                 height: 50)
        )
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.setTitleColor(UIColor.blue, for: .highlighted)
        /*
        ADD BORDER RADIUS
        */
        resetButton.layer.borderWidth = 1.0
        resetButton.layer.borderColor = UIColor.black.cgColor
        /*
        ADD CORNER RADIUS
        */
        resetButton.layer.cornerRadius = 25.0
        /*
        ADD TARGET TO BUTTON (SELECTOR)
        */
        resetButton.addTarget(self, action: #selector(GameViewController.resetGame), for: .touchUpInside)
        
        containerView.addSubview(resetButton)
    }
    
    func createGameView(){
        
        // UI from UIKit
        let containerView = UIView()
        
        containerView.frame = CGRect(x: 0,
                                     y: 2 + screenHeight * 0.4,
                                     width: screenWidth,
                                     height: screenHeight * 0.6 - 2)
        
        containerView.backgroundColor = UIColor(red: 0.95,
                                                green: 0.05,
                                                blue: 0.86,
                                                alpha: 1)
        
        self.view.addSubview(containerView)
        
        self.createGridView(containerView: containerView)
    }
    
    /**
     * createGridView is a method of the class GameViewController
     * createGRidView has only one parameter named containerView
     * the parameter containerView is of type UIView
     * the value of the parameter id received from the above method createGameView
     */
    func createGridView(containerView: UIView){
        //let button = UIButton()
    }
    
    //MARK: - Button Actions
    
    func resetGame(){
        print("Want to reset the game")
    }
}
