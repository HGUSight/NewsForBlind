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
@synthesize passData,passData1,passData2,imagedelete,photourl;
@synthesize textbuffer;
@synthesize saveNewArr;
@synthesize doscrap;
@synthesize newstext;
@synthesize stringobject;
@synthesize webview;
@synthesize photostring;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fliter=[[Fliter alloc]init];
    htmlparsing=[[HtmlParserclass alloc]init];
    newscontroller=[[MainNewsViewController alloc]init];
    news=[[News alloc]init];
    stringobject=[[NSMutableArray alloc]init];
    newstext=[[NSMutableString alloc]init];
    
    linkstring=[NSMutableString stringWithString:[passData2 description]];
    self.IbIMessage.text=[passData description];
    
    
    newsdetail=[htmlparsing sethtml:linkstring];
    photostring = [htmlparsing getphotourl];

}
-(void)viewWillAppear:(BOOL)animated{
    
    
       NSLog(@"[photourl description]=%@",photostring);
    
    if (photostring!=NULL) {
        
        CGRect ViewRect=CGRectMake(40.0f, 120.0f, 240.0f, 400.0f);
        webview = [[UIWebView alloc] initWithFrame:ViewRect];
        
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
        NSLog(@"[photourl description]=%@",photostring);
        NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
        [webview loadRequest:myURLReq];
        webview.scalesPageToFit = YES;
        [self.view addSubview:webview];

        
        
        CGRect textViewRect=CGRectMake(20.0f, 260.0f, 280.0f, 280.0f);
        imagetextview=[[UITextView alloc]initWithFrame: textViewRect];
        
        [imagetextview setFont:[UIFont systemFontOfSize:12.0f]];
        [imagetextview setText:newsdetail];
        [self.view addSubview:imagetextview];
        imagetextview.editable = NO;

       
    }else {
        
        CGRect textViewRect=CGRectMake(20.0f, 120.0f, 280.0f, 370.0f);
        textview=[[UITextView alloc]initWithFrame: textViewRect];
        
        [textview setFont:[UIFont systemFontOfSize:12.0f]];
        [textview setText:newsdetail];
        [self.view addSubview:textview];
        textview.editable = NO;
        
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //기사 내용 폰트 조절
    [textview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    [imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    
    //기사 제목 폰트 조절
    [self.IbIMessage setFont:[UIFont systemFontOfSize:appDelegate.fontS]];
    [self.IbIMessage setLineBreakMode:UILineBreakModeClip];
    [self.IbIMessage setNumberOfLines:3];
    
    CGSize constraintSize = CGSizeMake(320, 20);
    CGSize newSize = [self.IbIMessage.text sizeWithFont:[UIFont systemFontOfSize:appDelegate.fontS] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeClip];
    CGFloat labelHeight = MAX(newSize.height, 20);
    [self.IbIMessage setFrame:CGRectMake(self.IbIMessage.frame.origin.x, self.IbIMessage.frame.origin.y, self.IbIMessage.frame.size.width, labelHeight)];
    [self.IbIMessage setText:self.IbIMessage.text];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:animated];
}

-(void)doSaveNewsdetail
{
    news.title=[NSMutableString stringWithString:[passData description]];
    news.description=[NSMutableString stringWithString:textbuffer];
    [saveNewArr addObject:news];
    news = [[News alloc]init];
    NSLog(@"SAVE TITLE:%@",news.title);

    
    
    
}



@end
