//
//  ViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fliter;
@interface ViewController : UIViewController{
    Fliter *fliter;
}
@property (strong, nonatomic) IBOutlet UILabel *IbIMessage;
@property (retain, nonatomic) IBOutlet UITextView *Textscroll;
@property (strong, nonatomic)id passData;
@property (strong, nonatomic)id passData1;
@property (nonatomic, retain) NSString *textbuffer;
@end
