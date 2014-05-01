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
    
    linkstring=[NSMutableString stringWithString:[passData2 description]];
   
    newsdetail=[htmlparsing sethtml:linkstring];
    photostring = [htmlparsing getphotourl];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    //타이틀 설정 및 텍스트 삽입
    titleview =[[UITextView alloc]initWithFrame:CGRectMake(10.0f, 60.0f, 280.0f, 90.0f)];
    titleview.editable = NO;
    titleview.selectable= NO;
    titleview.userInteractionEnabled=YES;
    titleview.scrollEnabled = NO;
    titleview.accessibilityTraits=UIAccessibilityTraitNone;
    [titleview setText:[passData description]];
    

    
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,520)];
    mainScrollView.showsVerticalScrollIndicator=YES;
    mainScrollView.scrollEnabled=YES;
    mainScrollView.userInteractionEnabled=YES;
    mainScrollView.isAccessibilityElement=NO;
    //mainScrollView.contentSize=CGSizeMake(320,2000);
    [mainScrollView sizeToFit];

    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [titleview setFont:[UIFont systemFontOfSize:appDelegate.fontS]];
    
    
    
        
        int i_height=0;
        int i_width=0;
        int text_top_margin = 150;
    
        for (NSString *line in [[newsdetail substringFromIndex:6] componentsSeparatedByString:@"\n"]) {
            if (![line isEqualToString:@"\n"]) {
                [newsdetailarr addObject:line];
            }
            
        }
    
    if (photostring!=NULL) {

        webview = [[UIWebView alloc] initWithFrame:CGRectMake(30.0f, 150.0f, 250.0f, 150.0f)];
        text_top_margin = 260;
        
        UIScrollView *scrollView = nil;
        if ([webview respondsToSelector:@selector(scrollView)]) { //iOS 5+
            scrollView = webview.scrollView;
        } else { //iOS 4-
            for(UIView *view in webview.subviews){
                if([view isKindOfClass:[UIScrollView class] ]){
                    scrollView = (UIScrollView *) view;
                    break;
                }
            }
        }
        scrollView.scrollEnabled = NO;
        scrollView.bounces = NO;
        scrollView.backgroundColor=[UIColor clearColor];
    
        NSURL *myURL = [NSURL URLWithString:photostring];
        NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
        [webview loadRequest:myURLReq];
        [webview setScalesPageToFit:YES];
        }
        
        for (int i=0; i<[newsdetailarr count]; i++) {
            
            //NSLog(@"height=%d,width=%d",i_height,i_width);
            
            imagetextview=[[UITextView alloc]initWithFrame:CGRectMake(20, text_top_margin+i_height, 280, 1000+i_height)];
            [imagetextview setFont:[UIFont systemFontOfSize:15.0f]];
            [imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
            imagetextview.editable = NO;
            imagetextview.selectable= NO;
            imagetextview.userInteractionEnabled=YES;
            imagetextview.accessibilityTraits=UIAccessibilityTraitNone;
            imagetextview.multipleTouchEnabled=NO;
            imagetextview.opaque=NO;
            //textview.
            
            [imagetextview setScrollEnabled:YES];
            [imagetextview setText:newsdetailarr[i]];
            [imagetextview sizeToFit];
            [imagetextview setScrollEnabled:NO];
            
            CGSize textViewSize = [imagetextview sizeThatFits:CGSizeMake(imagetextview.frame.size.width, FLT_MAX)];
            i_height+=textViewSize.height;
            i_width+=textViewSize.width;
            
            if (textViewSize.width==10) {
                imagetextview.isAccessibilityElement=NO;
            }
            
            
            [mainScrollView addSubview:imagetextview];
            
        }
    
        mainScrollView.contentSize=CGSizeMake(320,i_height+310);
        
        [mainScrollView addSubview:webview];
        
       
        [titleview setUserInteractionEnabled:YES];
        [titleview setSelectable:NO];
        [mainScrollView addSubview:titleview];
        
       
        [self.view addSubview:mainScrollView];
    
    
    //기사 내용 폰트 조절
    
    //[imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    
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
