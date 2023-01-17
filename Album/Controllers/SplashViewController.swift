//
//  SplashViewController.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 9.01.2023.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoImageView = UIImageView(image: UIImage(named: "albumss"))
        let screenSize = UIScreen.main.bounds
        logoImageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        view.addSubview(logoImageView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "AlbumsVC", sender: nil)
        }
    }
}




