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
@class News;
@class AppDelegate;

@interface NewsArticleViewController : UIViewController{
    
    Fliter *fliter;
    HtmlParserclass *htmlparsing;
    MainNewsViewController *newscontroller;
    NSMutableArray * saveNewsArr;
    News *news;
    NSMutableString *newstext;
    NSMutableArray *stringobject;
    UIWebView *webview;
    NSString *potostring;
    UITextView *imagetextview;
    UITextView *textview;
    NSMutableString * linkstring;
    NSString *newsdetail;

}

@property (retain, nonatomic) IBOutlet UIScrollView *Mainscrollview;

@property (strong, nonatomic) IBOutlet UILabel *IbIMessage;
@property (strong, nonatomic)id passData;
@property (strong, nonatomic)id passData1;
@property (strong, nonatomic)id passData2;
@property (nonatomic, retain) NSString *textbuffer;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doscrap;
@property (strong, nonatomic) NSMutableArray *saveNewArr;
@property (strong, nonatomic) NSMutableString *newstext;
@property (strong, nonatomic) NSMutableArray *stringobject;
@property (strong, nonatomic )id imagedelete;
@property (strong, nonatomic )id photourl;
@property (strong, nonatomic )UIWebView *webview;
@property (strong, nonatomic) NSString * photostring;




@end
