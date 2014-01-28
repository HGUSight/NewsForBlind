//
//  ThirdViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 1. 26..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UITableViewController {
    
    NSMutableArray *itemlist;
    int num;
    
}

@property (nonatomic,retain) NSMutableArray *itemlist;

@property (retain, nonatomic) IBOutlet UITableViewCell *categoryurl;



@end
