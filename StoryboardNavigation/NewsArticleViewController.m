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
@synthesize passData,passData1,passData2,imagecheckstr,photourl;
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
    i_height=0;
    i_width=0;
    text_top_margin = 0;
    
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
    news.title=[NSMutableString stringWithString:[passData description]];
    news.description=[NSMutableString stringWithString:newsdetail];
    [saveNewsArr addObject:news];
    NSLog(@"SAVE TITLE:%@",news.title);
    news = [[News alloc]init];
    
    
}


@end
