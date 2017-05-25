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
    var tags =  [Int: String]()
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
        for k in 0...8 {
            self.tags[k] = ""
        }
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
        // remove all button tags from the game button tags array
        for k in 0...8 {
            self.tags[k] = ""
        }
        
        // delete previous buttons if available
        if container.subviews.count > 0 {
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
                button.setTitle("", for: .normal)
                
                button.addTarget(self, action: #selector(GameViewController.addGameValue(sender:)), for: .touchUpInside)
                
                button.tag = i * 3 + j
                //self.gameButtons.append(button)
                container.addSubview(button)
            }
        }
    }
    
    //MARK: - Button Actions
    
    func resetGame(){
        print("GAME RESET")
        createGameView()
        self.numberOfTotalTurns = 0
    }
    
    func getRowIndex(tag: Int) -> Int{
        // line number is 0 if TAG in [0,2], 1 if TAG in [3,5] and 2 if TAG in [6,8]
        var lineIndex = 0
        switch tag {
        case 3:
            lineIndex = 1
        case 4:
            lineIndex = 1
        case 5:
            lineIndex = 1
            break
        case 6:
            lineIndex = 2
        case 7:
            lineIndex = 2
        case 8:
            lineIndex = 2
            break
        default:
            lineIndex = 0
        }

        return lineIndex
    }
    
    func getColumnIndex(tag: Int) -> Int{
        // column number is 0 if TAG in [0,3,6], 1 if TAG in [1, 4, 7] and 2 if TAG in [2, 5, 8]
        
        return Int(tag) % 3
    }
    
    func addGameValue(sender: UIButton){
        let currentTag = sender.tag
        if (self.tags[currentTag] == "")
        {
            let token = getToken()
            self.tags[sender.tag] = token
            
            sender.backgroundColor = UIColor.blue
            sender.setTitle(token, for: .normal)
            
            let rowIndex = getRowIndex(tag: sender.tag)
            let columnIndex = getColumnIndex(tag: sender.tag)
            
            let s1 = "# MOVE " + token + " @tag: " + String(sender.tag)
            let s2 = "@ R C [" + String(rowIndex)+","+String(columnIndex) + "]"
            //let s3 = "PREV: " + self.tags[tag]!
            print(s1 + s2)
            
            if(endConditionWasReached(tag: Int(sender.tag)) == false){
                self.numberOfTotalTurns += 1
            }
            else{
                resetGame() //move this else inside the delegate from alertView!!!
            }
        }
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
    
    // Check end condition
    func endConditionWasReached(tag: Int) -> Bool{
        //#############################################################
        // init
        
        let rowIndex = getRowIndex(tag: tag)
        let columnIndex = getColumnIndex(tag: tag)
        let token = getToken()
        let s1 = "# MOVE " + token + " @tag: " + String(tag)
        let s2 = "@ R C [" + String(rowIndex)+","+String(columnIndex) + "]"
        //let s3 = "PREV: " + self.tags[tag]!
        print(s1 + s2)
        //#############################################################
        // 1. check line
        for k in 0...2 {
            let currentTag = rowIndex*3 + k
            //print(String(currentTag))
            let currentTitle = self.tags[currentTag]
            
            if( currentTitle != token){
                break
            }
            
            if(k == 2)
            {
                showGameResult(result: "GAME OVER! === " + token + " WON! ===" + " @R" + String(rowIndex))
                return true
            }
        }
        //#############################################################
        // 2. check column
        for k in 0...2 {
            let currentTag = 3*k + columnIndex
            //print(String(currentTag))
            let currentTitle = self.tags[currentTag]
            
            if(currentTitle != token){
                break
            }

            if(k == 2)
            {
                showGameResult(result: "GAME OVER! === " + token + " WON! ===" + " @C" + String(columnIndex))
                return true
            }
        }
        //#############################################################
        // 3. check diagonals
        if (columnIndex == rowIndex){
            // the pressed button is on the diagonal
            for k in 0...2 {
                let currentTag = k*3 + k
                //print(String(currentTag))
                let currentTitle = self.tags[currentTag]
                if(currentTitle != token){
                    break
                }
                if(k == 2){
                    showGameResult(result: "GAME OVER! === " + token + " WON! ===" + " @D")
                    return true
                }
            }
        }
        //#############################################################
        // 4. check anti diagonals
        if (columnIndex + rowIndex == 2){
            // the pressed button is on the anti diagonal
            for k in 0...2 {
                let currentTag = k*3 + 2 - k
                //print(String(currentTag))
                let currentTitle = self.tags[currentTag]
                if(currentTitle != token){
                    break
                }
                if(k == 2){
                    showGameResult(result: "GAME OVER! === " + token + " WON! ===" + " @AD")
                    return true
                }
            }
        }
        //#############################################################
        // 5. check tie / draw
        // "draw or tie is to finish a competition with identical or inconclusive results" - https://en.wikipedia.org/wiki/Tie_(draw)
        if(self.numberOfTotalTurns == 9){
            for tag in self.tags{
                if (tag.value == "")
                {
                    return false
                }
            }
            showGameResult(result: "GAME OVER! === TIE ===")
            return true
        }
        
        return false
    }
    
    func showGameResult(result: String)
    {
        let alert = UIAlertView(title: "Game result:",
                                message: result,
                                delegate: nil,
                                //delegate: delete(resetGame()),
                                cancelButtonTitle: "Reset"
        )
        
        alert.show()
    }
}
