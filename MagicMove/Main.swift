//
//  Main.swift
//  MagicMove
//
//  Created by Bing on 6/29/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

class Main: UIViewController
{
    var collectionView: UICollectionView!
    
    var dataArr = [["name": "Gril1", "avatar": "avatar1.jpg"],
                   ["name": "Gril2", "avatar": "avatar2.jpg"],
                   ["name": "Gril3", "avatar": "avatar3.jpg"],
                   ["name": "Gril4", "avatar": "avatar4.jpg"],
                   ["name": "Gril5", "avatar": "avatar5.jpg"],
                   ["name": "Gril6", "avatar": "avatar6.jpg"],
                   ["name": "Gril7", "avatar": "avatar7.jpg"],
                   ["name": "Gril8", "avatar": "avatar8.jpg"],
                   ["name": "Gril9", "avatar": "avatar9.jpg"],
                   ["name": "Gril10", "avatar": "avatar10.jpg"],
                   ["name": "Gril11", "avatar": "avatar11.jpg"],
                   ["name": "Gril12", "avatar": "avatar12.jpg"],
                   ["name": "Gril13", "avatar": "avatar13.jpg"],
                   ["name": "Gril14", "avatar": "avatar14.jpg"],
                   ["name": "Gril15", "avatar": "avatar15.jpg"],
                   ["name": "Gril16", "avatar": "avatar16.jpg"],
                   ["name": "Gril17", "avatar": "avatar17.jpg"],
                   ["name": "Gril18", "avatar": "avatar18.jpg"],
                   ["name": "Gril19", "avatar": "avatar19.jpg"],
                   ["name": "Gril20", "avatar": "avatar20.jpg"],
                   ["name": "Gril21", "avatar": "avatar21.jpg"],
                   ["name": "Gril22", "avatar": "avatar22.jpg"],
                   ["name": "Gril23", "avatar": "avatar23.jpg"]]
    
    var selectedCell: MyCell?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Magic Move"
        
        self.automaticallyAdjustsScrollViewInsets = false
        // 流式布局对象
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(MyCell.classForCoder(), forCellWithReuseIdentifier: "MyCell")
        self.view.addSubview(collectionView)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension Main: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! MyCell
        
        cell.avatar?.image = UIImage(named: dataArr[indexPath.item]["avatar"]!)
        cell.name?.text = dataArr[indexPath.item]["name"]
        
        return cell
    }
}

extension Main: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? MyCell
        let detailVC = Detail()
        detailVC.avatar = self.selectedCell?.avatar!.image
        detailVC.descStr = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension Main: UINavigationControllerDelegate
{
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        if operation == .Push
        {
            return MagicMovePush()
        }
        else
        {
            return nil
        }
    }
}