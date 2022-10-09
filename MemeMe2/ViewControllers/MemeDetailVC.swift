//
//  MemeDetailVC.swift
//  MemeMe2
//
//  Created by Josh Gutierrez on 10/9/22.
//

import UIKit

class MemeDetailVC: UIViewController {
    
    var meme: Meme!
    var picture: UIImage!

    @IBOutlet weak var memedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.memedImageView.image = meme.memedImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
