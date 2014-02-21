//
//  ViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fliter;
@class HtmlParserclass;
@class MainNewsViewController;

@interface NewsArticleViewController : UIViewController{
    
    Fliter *fliter;
    HtmlParserclass *htmlparsing;
    MainNewsViewController *newscontroller;
   
}

@property (retain, nonatomic) IBOutlet UITextView *Textscroll;
@property (strong, nonatomic) IBOutlet UILabel *IbIMessage;
@property (strong, nonatomic)id passData;
@property (strong, nonatomic)id passData1;
@property (strong, nonatomic)id passData2;
@property (nonatomic, retain) NSString *textbuffer;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doscrap;


@end
