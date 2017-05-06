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
    var numberOfTotalTurns = 0
    var gameButtons : Array<UIButton> = []
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
        // init for width and height
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
        
        self.createGridView(container: containerView)
    }
    
    /**
     * createGridView is a method of the class GameViewController
     * createGRidView has only one parameter named containerView
     * the parameter containerView is of type UIView
     * the value of the parameter id received from the above method createGameView
     */
    func createGridView(container: UIView){
        
        // delete previous buttons if available
        if container.subviews.count > 0 {
            // remove all buttons from the game buttons array
            self.gameButtons = Array<UIButton>()
            // remove all buttons from the list of subviews
            for button in container.subviews {
                button.removeFromSuperview()
            }
        }
        
        
        let buttonWidth = container.frame.size.width/3
        let buttonHeight = container.frame.size.height/3
        
        for i in 0...2{
            for j in 0...2{
                let button = UIButton(frame: CGRect(x: buttonWidth * CGFloat(j),
                                                    y: buttonHeight * CGFloat(i),
                                                    width: buttonWidth,
                                                    height: buttonHeight)
                )
                button.backgroundColor = UIColor.init(colorLiteralRed: 0.1, green: 1, blue: 0.05, alpha: 1)
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.black.cgColor
                
                button.addTarget(self, action: #selector(GameViewController.addGameValue(sender:)), for: .touchUpInside)
                
                button.tag = i * 3 + j
                self.gameButtons.append(button)
                container.addSubview(button)
            }
        }
        
        for button in self.gameButtons{
            print(button.tag)
        }
    }
    
    //MARK: - Button Actions
    
    func resetGame(){
        print("Want to reset the game")
        createGameView()
        self.numberOfTotalTurns = 0
    }
    
    func addGameValue(sender: UIButton){
        print(sender.tag)
        if (sender.currentTitle == "X" || sender.currentTitle == "O")
        {
            sender.backgroundColor = UIColor.white
            sender.setTitle("-", for: .normal)
            self.numberOfTotalTurns -= 1
        }
        else{
            sender.backgroundColor = UIColor.blue
            sender.setTitle(getToken(), for: .normal)
            self.numberOfTotalTurns += 1
        }
        
        self.showWinner()
    }
    
    func getToken() -> String {
        if self.numberOfTotalTurns % 2 == 0
        {
            return "X"
        }
        else
        {
            return "O"
        }
    }
    
    func showWinner(){
        for button in self.gameButtons{
            if (button.currentTitle != "X" && button.currentTitle != "O")
            {
                return
            }
        }
        
        for k in 0...2 {
            if (gameButtons[k].currentTitle == gameButtons[k + 1].currentTitle
                && gameButtons[k + 1].currentTitle == gameButtons[k + 2].currentTitle
                && gameButtons[k].currentTitle == gameButtons[k + 2].currentTitle
                ){
                print("=== " + gameButtons[k].currentTitle! + " WON === LINE " + k + " ===")
                return
            }
        }
        
        print("GAME OVER! === TIE ===")
    }
}
