//
//  ViewController.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/7/24.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var githubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         setupView()
    }

    private func setupView() {
        self.loginButton.layer.cornerRadius = 20
        self.githubView.layer.cornerRadius = 22
    }

    @IBAction func loginBtnDidTap(_ sender: Any) {
        self.view.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
    }
    
    @IBAction func appleBtnDidTap(_ sender: Any) {
        print("애플 로그인")
    }
    @IBAction func githubBtnDidTap(_ sender: Any) {
        print("깃허브 로그인")
    }
}
