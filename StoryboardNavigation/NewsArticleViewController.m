//
//  ViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27.628.
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import "NewsArticleViewController.h"
#import "CategoryViewController.h"
#import "Fliter.h"
#import "News.h"
#import "HtmlParserclass.h"
#import "MainNewsViewController.h"
#import "AppDelegate.h"
#import "SettingViewController.h"


@interface NewsArticleViewController ()

@end

@implementation NewsArticleViewController
@synthesize passData,passData1,passData2,passData3,imagecheckstr,photourl;
@synthesize textbuffer;
@synthesize saveNewsArr,newsdetailarr;
@synthesize doscrap;
@synthesize newstext;
@synthesize stringobject;
@synthesize webview;
@synthesize photostring;
@synthesize mainScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fliter=[[Fliter alloc]init];
    htmlparsing=[[HtmlParserclass alloc]init];
    newscontroller=[[MainNewsViewController alloc]init];
    news=[[News alloc]init];
    stringobject=[[NSMutableArray alloc]init];
    newstext=[[NSMutableString alloc]init];
    newsdetailarr=[[NSMutableArray alloc]init];
    saveNewsArr=[[NSMutableArray alloc]init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    linkstring=[NSMutableString stringWithString:[passData2 description]];
    newsdetail=[htmlparsing sethtml:linkstring];
    photostring = [htmlparsing getphotourl];
    newdate=[NSString stringWithString:[passData3 description]];
    
    i_height=0;
    i_width=0;
    text_top_margin = 0;
    
    //[self openDB];
    //[self createTableNamed:@"newstable" withField1:@"kindofnews" withField2:@"newstitle" withField3:@"newscontent" withField4:@"newsdate"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    if (imagecheck) {
        NSLog(@"imagecheck=%@",@"ok");
    }
   
    
    for (NSString *line in [[newsdetail substringFromIndex:0] componentsSeparatedByString:@"\n"])
        [newsdetailarr addObject:line];
    
    //메인 스크롤뷰 얼로케이션
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,520)];
    mainScrollView.showsVerticalScrollIndicator=YES;
    mainScrollView.scrollEnabled=YES;
    mainScrollView.userInteractionEnabled=YES;
    mainScrollView.isAccessibilityElement=NO;
    [mainScrollView sizeToFit];

    //타이틀 얼로케이션
    titleview =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 25.0f, 290.0f, 150.0f)];
    [titleview setText:[passData description]];
    titleview.lineBreakMode = YES;
    titleview.userInteractionEnabled=YES;
    titleview.accessibilityTraits=UIAccessibilityTraitNone;
    titleview.tag = 10;
    titleview.numberOfLines = 0;
    titleview.lineBreakMode = YES;
    titleview.adjustsFontSizeToFitWidth = YES;
    [titleview setFont:[UIFont systemFontOfSize:appDelegate.fontS]];
    [titleview sizeToFit];
    [mainScrollView addSubview:titleview];
    
    if (!imagecheck) {
        
        //사진이 있을 때, 사진 웹뷰에 로드
        if (photostring!=NULL) {
        
            NSLog(@"titleview.frame.size.height=%f",titleview.frame.size.height);
            webview = [[UIWebView alloc] initWithFrame:CGRectMake(30.0f, titleview.frame.size.height+40.0f, 250.0f, 150.0f)];
            NSURL *myURL = [NSURL URLWithString:photostring];
            NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
            [webview loadRequest:myURLReq];
            [webview setScalesPageToFit:YES];
        
        }

        [webview sizeToFit];
        [mainScrollView addSubview:webview];
        
    }
    
    [self.view addSubview:mainScrollView];
    
}
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([htmlparsing getphotourl]==NULL) {
         text_top_margin=titleview.frame.size.height+20; //사진이 없을 경우 텍스트 마진
    }else {
    
        if ([webview sizeThatFits:CGSizeMake(webview.frame.size.width, FLT_MAX)].height > webview.frame.size.height) { // 사진이 있을 경우, 웹뷰 사이즈보다 큰 사진 받아올때,
        
            CGRect frame = webview.frame;
            frame.size.height = 1;
            webview.frame = frame;
            CGSize fittingSize = [webview sizeThatFits:CGSizeMake(webview.frame.size.width, FLT_MAX)];
            frame.size = fittingSize;
            webview.frame = frame;
            
            text_top_margin=webview.frame.size.height+80; // 그때의 텍스트 마진
            
        }else {
            
              text_top_margin=webview.frame.size.height+40; // 웹뷰와 같거나 작은 사이즈 받아올때 마진
        }
    }
    CGSize textViewSize;
    for (int i=0; i<[newsdetailarr count]; i++) {
        
        imagetextview=[[UILabel alloc]initWithFrame:CGRectMake(20, text_top_margin+i_height+40, 280, i_height)];
        [imagetextview setFont:[UIFont systemFontOfSize:15.0f]];
        [imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
        imagetextview.userInteractionEnabled=YES;
        imagetextview.accessibilityTraits=UIAccessibilityTraitNotEnabled;
        imagetextview.multipleTouchEnabled=YES;
        imagetextview.opaque=NO;
        imagetextview.tag = 10;
        imagetextview.numberOfLines = 0;
        
        NSMutableString * buffer =[NSMutableString stringWithString:newsdetailarr[i]];
        [buffer appendString:@"\n"];
        
        [imagetextview setText:buffer];
        imagetextview.lineBreakMode = YES;
        [imagetextview sizeToFit];
        
        textViewSize = [imagetextview sizeThatFits:CGSizeMake(imagetextview.frame.size.width, FLT_MAX)];
        i_height+=textViewSize.height;
        i_width+=textViewSize.width;
        
        if (textViewSize.width < 150) {
            imagetextview.isAccessibilityElement=NO;   //빈줄인 라벨 접근 안하기 위함
        }
        [mainScrollView addSubview:imagetextview];
    }
    mainScrollView.contentSize=CGSizeMake(320,i_height+text_top_margin+textViewSize.height+120);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:animated];
    [imagetextview release];
    [textview release];
    [mainScrollView release];
   
}

-(IBAction)doSaveNewsdetail:(id)sender
{
    [self insertRecordIntoTable:@"newstable" withField1:@"kindofnews" fieldvalue:@"경북일보" withField2:@"newstitle" field2value:[passData description] withField3:@"newscontent" field3value:[htmlparsing sethtml:linkstring] withField4:@"newsdate" field4value:newdate];
    
}
-(NSString *)filePath
{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDir=[paths objectAtIndex:0];
    
    return  [documentsDir stringByAppendingPathComponent:@"database.sql"];
    
}

-(void)openDB
{
    if(db==NULL) {
        sqlite3 *newDBconnection;
        
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *documentsDir=[paths objectAtIndex:0];
        NSString *path =[documentsDir stringByAppendingPathComponent:@"klb_db.sqlite"];
        
        if (sqlite3_open([path UTF8String], &newDBconnection)==SQLITE_OK) {
            NSLog(@"Database Successfully Opened :)");
            db = newDBconnection;
        }else if (sqlite3_open([path UTF8String], &newDBconnection)!=SQLITE_OK) {
            sqlite3_close(db);
            sqlite3_close(newDBconnection);
            
            NSAssert(0,@"Database failed to open");
        }

    }
    
}
-(void)createTableNamed:(NSString *)tableName withField1:(NSString *) field1 withField2:(NSString *) field2 withField3:(NSString *) field3 withField4:(NSString *) field4
{
    char *err;
    
    NSString *sql= [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT, '%@' TEXT PRIMARY KEY, '@' TEXT, '@' TEXT);",tableName, field1,field2,field3,field4];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0,@"Tabled failed to create");
    }
    
}
-(void)insertRecordIntoTable:(NSString *)tableName withField1:(NSString *) field1 fieldvalue:(NSString *)fieldvalue withField2:(NSString *) field2 field2value:(NSString *)field2value withField3:(NSString *) field3 field3value:(NSString *)field3value withField4:(NSString *) field4 field4value:(NSString *)field4value
{
    NSString *sql =[NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@', '%@', %@', '%@') VALUES ('%@', '%@', %@', '%@')",tableName,field1, field2, field3, field4, fieldvalue, field2value, field3value, field4value];
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0,@"Error updating table");
    }
    
}
-(void)getAllRowsFromTableNamed: (NSString *)tableName
{
    NSString *sql= [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *field1 =(char *)sqlite3_column_text(statement,0);
            NSString *field1str =[[NSString alloc]initWithUTF8String:field1];
            
            char *field2 =(char *)sqlite3_column_text(statement,1);
            NSString *field2str =[[NSString alloc]initWithUTF8String:field2];
            
            char *field3 =(char *)sqlite3_column_text(statement,2);
            NSString *field3str =[[NSString alloc]initWithUTF8String:field3];
            
            char *field4 =(char *)sqlite3_column_text(statement,3);
            NSString *field4str =[[NSString alloc]initWithUTF8String:field4];
            
        }
        
        sqlite3_finalize(statement);
    }
}



@end
