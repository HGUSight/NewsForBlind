//
//  SettingViewController.h
//  StoryboardNavigation
//
//  Created by csee on 2014. 2. 22..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@class NewsArticleViewController;

@interface SettingViewController : UITableViewController {
    
    NewsArticleViewController * articleController;
}
@property (retain, nonatomic) IBOutlet UISlider *mySlider;
@property (retain, nonatomic) IBOutlet UILabel *myLabel;
@property (retain, nonatomic) IBOutlet UISwitch *hideImage;


- (IBAction)sliderChanged:(id)sender;
- (IBAction)flip:(id)sender;

@end
