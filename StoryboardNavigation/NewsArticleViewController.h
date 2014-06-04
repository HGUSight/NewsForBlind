//
//  ViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class Fliter;
@class HtmlParserclass;
@class MainNewsViewController;
@class News;
@class AppDelegate;
@class SettingViewController;


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
    UILabel *imagetextview;
    UILabel *textview;
    NSMutableString * linkstring;
    NSString *newsdetail;
    UIScrollView * mainScrollView;
    UILabel *titleview;
    NSMutableArray * newsdetailarr;
    int i_height;
    int i_width;
    int text_top_margin;
    AppDelegate *appDelegate;
    NSString * newdate;
    sqlite3 *db;
       

}


@property (strong, nonatomic)id passData;
@property (strong, nonatomic)id passData1;
@property (strong, nonatomic)id passData2;
@property (strong, nonatomic)id passData3;
@property (nonatomic, retain) NSString *textbuffer;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doscrap;
@property (strong, nonatomic) NSMutableArray *saveNewsArr;
@property (strong, nonatomic) NSMutableString *newstext;
@property (strong, nonatomic) NSMutableArray *stringobject;
@property (strong, nonatomic )id imagecheckstr;
@property (strong, nonatomic )id photourl;
@property (strong, nonatomic )UIScrollView *mainScrollView;
@property (strong, nonatomic )UIWebView *webview;
@property (strong, nonatomic) NSString * photostring;
@property (strong, nonatomic) NSMutableArray *newsdetailarr;

-(IBAction)doSaveNewsdetail:(id)sender;
-(NSString*)filePath;
-(void)openDB;
-(void)createTableNamed:(NSString *)tableName withField1:(NSString *) field1 withField2:(NSString *) field2 withField3:(NSString *) field3 withField4:(NSString *) field4;
-(void)insertRecordIntoTable:(NSString *)tableName withField1:(NSString *) field1 fieldvalue:(NSString *)fieldvalue withField2:(NSString *) field2 field2value:(NSString *)field2value withField3:(NSString *) field3 field3value:(NSString *)field3value withField4:(NSString *) field4 field4value:(NSString *)field4value;
-(void)getAllRowsFromTableNamed: (NSString *)tableName;





@end
