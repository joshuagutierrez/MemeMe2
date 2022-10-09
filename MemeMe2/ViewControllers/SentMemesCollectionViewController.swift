//
//  SentMemesCollectionViewController.swift
//  MemeMe2
//
//  Created by Josh Gutierrez on 10/7/22.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        let space:CGFloat = 3.0
        let dimensionw = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionh = (view.frame.size.height - (2 * space)) / 3.0
        //TODO: also use view.frame.size.height to get the spacing right

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionw, height: dimensionh)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.memeLabel?.text = (meme.topText ?? "") + (meme.bottomText ?? "")
        cell.memeImageView?.image = meme.memedImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: present a detailVC
        
        guard let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailVC") as? MemeDetailVC else { return }

        detailController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: Segue
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //Notice that this code works for both Scissors and Paper
//        let controller = segue.destination as! MemeDetailVC
//        controller.meme = self.match
//    }

}
