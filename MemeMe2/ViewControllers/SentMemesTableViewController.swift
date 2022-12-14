//
//  SentMemesTableViewController.swift
//  MemeMe2
//
//  Created by Josh Gutierrez on 10/7/22.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    // MARK: Memes model
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // Setup navigation bar
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createMeme))
    }
    
    // Call the create meme view controller
    @objc func createMeme() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath) as! SentMemesTableViewCell
        
        let meme = memes[indexPath.row]
        cell.memeLabel?.text = (meme.topText ?? "") + (meme.bottomText ?? "")
        cell.memeImageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: present a detailVC
        
        guard let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailVC") as? MemeDetailVC else { return }

        detailController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: Segue
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //Notice that this code works for both Scissors and Paper
//        let controller = segue.destination as! ResultViewController
//        controller.match = self.match
//    }
    
}
