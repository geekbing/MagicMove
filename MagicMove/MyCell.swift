//
//  MyCell.swift
//  MagicMove
//
//  Created by Bing on 6/29/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell
{
    // 头像
    var avatar : UIImageView?
    // 名字
    var name: UILabel?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // 头像
        avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        avatar?.contentMode = UIViewContentMode.ScaleToFill
        avatar?.layer.masksToBounds = true
        avatar?.layer.cornerRadius = 40
        self.contentView.addSubview(avatar!)
        
        // 名字
        name = UILabel(frame: CGRectMake(0, 80, 80, 20))
        name?.textAlignment = .Center
        name?.numberOfLines = 0
        name?.font = UIFont.boldSystemFontOfSize(14.0)
        name?.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(name!)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
