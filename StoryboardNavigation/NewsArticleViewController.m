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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    linkstring=[NSMutableString stringWithString:[passData2 description]];
   
    newsdetail=[htmlparsing sethtml:linkstring];
    photostring = [htmlparsing getphotourl];
    
   
    
    i_height=0;
    i_width=0;
    text_top_margin = 0;
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    for (NSString *line in [[newsdetail substringFromIndex:4] componentsSeparatedByString:@"\n"]) {
        if (![line isEqualToString:@"\n"]) {
            [newsdetailarr addObject:line];
        }
        
    }
    
    
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,520)];
    mainScrollView.showsVerticalScrollIndicator=YES;
    mainScrollView.scrollEnabled=YES;
    mainScrollView.userInteractionEnabled=YES;
    mainScrollView.isAccessibilityElement=NO;
    [mainScrollView sizeToFit];

    titleview =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 65.0f, 290.0f, 150.0f)];
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
    
    if (photostring!=NULL) {
        
        NSLog(@"titleview.frame.size.height=%f",titleview.frame.size.height);
        webview = [[UIWebView alloc] initWithFrame:CGRectMake(30.0f, titleview.frame.size.height+75.0f, 250.0f, 190.0f)];
        NSURL *myURL = [NSURL URLWithString:photostring];
        NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
        [webview loadRequest:myURLReq];
        [webview setScalesPageToFit:YES];
        
    }

    /*
        for (int i=0; i<[newsdetailarr count]; i++) {
            
            //NSLog(@"height=%d,width=%d",i_height,i_width);
            
            imagetextview=[[UILabel alloc]initWithFrame:CGRectMake(20, text_top_margin+i_height+40, 280, i_height)];
            [imagetextview setFont:[UIFont systemFontOfSize:15.0f]];
            [imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
            //imagetextview.editable = NO;
            //imagetextview.selectable= YES;
            imagetextview.userInteractionEnabled=YES;
            imagetextview.accessibilityTraits=UIAccessibilityTraitNotEnabled;
            imagetextview.multipleTouchEnabled=YES;
            imagetextview.opaque=NO;
            imagetextview.tag = 10;
            imagetextview.numberOfLines = 0;
            
            
            //[imagetextview setScrollEnabled:YES];
            NSMutableString * buffer =[NSMutableString stringWithString:newsdetailarr[i]];
            [buffer appendString:@"\n"];

            [imagetextview setText:buffer];
            imagetextview.lineBreakMode = YES;

            [imagetextview sizeToFit];
                        //[imagetextview setScrollEnabled:NO];
            
            CGSize textViewSize = [imagetextview sizeThatFits:CGSizeMake(imagetextview.frame.size.width, FLT_MAX)];
            i_height+=textViewSize.height;
            i_width+=textViewSize.width;
            
            if (textViewSize.width==10) {
                imagetextview.isAccessibilityElement=NO;
            }
            
            
            [mainScrollView addSubview:imagetextview];
            
        }
    
        mainScrollView.contentSize=CGSizeMake(320,i_height+310);
        */
    [webview sizeToFit];
    [mainScrollView addSubview:webview];
    [self.view addSubview:mainScrollView];
    
}


-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([webview sizeThatFits:CGSizeMake(webview.frame.size.width, FLT_MAX)].height > webview.frame.size.height) {
        
        CGRect frame = webview.frame;
        frame.size.height = 1;
        webview.frame = frame;
        CGSize fittingSize = [webview sizeThatFits:CGSizeMake(webview.frame.size.width, FLT_MAX)];
        frame.size = fittingSize;
        webview.frame = frame;
        
    }
    
    if ([htmlparsing getphotourl]==NULL) {
         text_top_margin=titleview.frame.size.height+60;
    }else {
        text_top_margin=webview.frame.size.height+40;
    }
    //text_top_margin=webview.frame.size.height+150;
    NSLog(@"text_top_margin=%d",text_top_margin);
    NSLog(@"webview.frame.size.height=%f",webview.frame.size.height);

    for (int i=0; i<[newsdetailarr count]; i++) {
        
        //NSLog(@"height=%d,width=%d",i_height,i_width);
        
        imagetextview=[[UILabel alloc]initWithFrame:CGRectMake(20, text_top_margin+i_height+40, 280, i_height)];
        [imagetextview setFont:[UIFont systemFontOfSize:15.0f]];
        [imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
        //imagetextview.editable = NO;
        //imagetextview.selectable= YES;
        imagetextview.userInteractionEnabled=YES;
        imagetextview.accessibilityTraits=UIAccessibilityTraitNotEnabled;
        imagetextview.multipleTouchEnabled=YES;
        imagetextview.opaque=NO;
        imagetextview.tag = 10;
        imagetextview.numberOfLines = 0;
        
        
        //[imagetextview setScrollEnabled:YES];
        NSMutableString * buffer =[NSMutableString stringWithString:newsdetailarr[i]];
        [buffer appendString:@"\n"];
        
        [imagetextview setText:buffer];
        imagetextview.lineBreakMode = YES;
        
        [imagetextview sizeToFit];
        //[imagetextview setScrollEnabled:NO];
        
        CGSize textViewSize = [imagetextview sizeThatFits:CGSizeMake(imagetextview.frame.size.width, FLT_MAX)];
        i_height+=textViewSize.height;
        i_width+=textViewSize.width;
        
        if (textViewSize.width==10) {
            imagetextview.isAccessibilityElement=NO;
        }
        
        
        [mainScrollView addSubview:imagetextview];
        
    }
    
    mainScrollView.contentSize=CGSizeMake(320,i_height+310);
    
    
   

    
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
