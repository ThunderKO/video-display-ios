//
//  ViewController.swift
//  VideoTrainingDemo
//
//  Created by Farren Tong on 10/2/2019.
//  Copyright © 2019 FEHD EdUHK. All rights reserved.
//

import UIKit
import FSPagerView
import SideMenu

class MainVC: UIViewController,
    FSPagerViewDataSource, FSPagerViewDelegate
{

    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    fileprivate var numberOfItems = 7
    fileprivate var login = 1
    var sideMenuNC : MySideMenuNC?

    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
            self.pagerView.automaticSlidingInterval = 3.0
            self.pagerView.isInfinite = true
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }

    //
    // implements UIView / UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.login = 1
        
        // SideMenu
        sideMenuNC = storyboard!.instantiateViewController(withIdentifier: "MySideMenuNC") as? MySideMenuNC
        sideMenuNC!.dismissComplete = self.selectMenu
        // Define the menus
        // let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: YourViewController)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        let menuLeftNavigationController = sideMenuNC! as UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        // let menuRightNavigationController = UISideMenuNavigationController(rootViewController: YourViewController)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        // SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        // (Optional) Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // (Optional) Prevent status bar area from turning black when menu appears:
        SideMenuManager.default.menuFadeStatusBar = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.login >= 1 {
            self.login = 0
            self.performSegue(withIdentifier: "showLogin", sender: nil)
        }
    }
    
    //
    // implements FSPagerViewDataSource
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return numberOfItems
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.textLabel?.text = "Image \(index+1)"
        return cell
    }
    
    // implements FSPagerViewDelegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }

    
    
    //
    // Main Sections
    
    @IBAction func clickThumbnail(_ sender: Any) {
        self.performSegue(withIdentifier: "showVideoDetail", sender: self)
    }

    @IBAction func clickMenu(_ sender: Any) {

        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)

    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }
    
    
    func selectMenu(selected: String) {
        switch selected {
        case "Logout":
            self.performSegue(withIdentifier: "showLogin", sender: self)
        case "Search":
            self.performSegue(withIdentifier: "showSearch", sender: self)
        case "History":
            self.performSegue(withIdentifier: "showHistory", sender: self)
        case "Downloaded":
            self.performSegue(withIdentifier: "showDownloaded", sender: self)
        default:
            ()
        }
    }
    
}


extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "video_cell", for: indexPath) as! VideoCollectionViewCell
        
        let img = UIImage(named: self.imageNames[indexPath.row])
        cell.thumbnailButton.setImage(img, for: UIControl.State.normal)
        
        return cell
    }
    
    
}
