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

    
    CGRect ViewRect=CGRectMake(50.0f, 30.0f, 200.0f, 100.0f);
    webview = [[UIWebView alloc] initWithFrame:ViewRect];
    [self.view addSubview:webview];
    
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
    
   
   
    
    
    
    self.IbIMessage.text=[passData description];

    NSMutableString *linkstring=[NSMutableString stringWithString:[passData2 description]];
    //newsdetail =[htmlparsing sethtml:linkstring];
    //newsdetail = [newsdetail substringFromIndex:64];
    //self.Textscroll.text=[htmlparsing sethtml:linkstring];
   // self.Textscroll.editable = NO;
    
    /*
    for(NSString *line in [newstext componentsSeparatedByString:@"."]) {
        
        [stringobject addObject:line];
        
    }
    */
    //for(int i=0;i<stringobject.count;i++) {
        CGRect textViewRect=CGRectMake(20.0f, 100.0f, 280.0f, 330.0f);
        UITextView *textview=[[UITextView alloc]initWithFrame: textViewRect];
        
        [textview setFont:[UIFont systemFontOfSize:12.0f]];
        [textview setText:[htmlparsing sethtml:linkstring]];
        [self.view addSubview:textview];
        textview.editable = NO;
    
        
    //}

    
    textbuffer=[htmlparsing sethtml:linkstring];
    [doscrap setAction:@selector(doSaveNewsdetail)];
    
    
    
    
    
    
    //라벨 사이즈가 조정되도록
    //self.IbIMessage.adjustsFontSizeToFitWidth = YES;
    //[self.IbIMessage sizeToFit];
    //self.IbIMessage.numberOfLines = 0;
    

    
    //AppDelegate 사용하도록 설정
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //기사 내용 폰트 조절
    [self.Textscroll setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    
    //기사 제목 폰트 조절
    [self.IbIMessage setFont:[UIFont systemFontOfSize:appDelegate.fontS]];
    [self.IbIMessage setLineBreakMode:UILineBreakModeClip];
    [self.IbIMessage setNumberOfLines:3];
    
    CGSize constraintSize = CGSizeMake(320, 20);
    CGSize newSize = [self.IbIMessage.text sizeWithFont:[UIFont systemFontOfSize:appDelegate.fontS] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeClip];
    CGFloat labelHeight = MAX(newSize.height, 20);
    [self.IbIMessage setFrame:CGRectMake(self.IbIMessage.frame.origin.x, self.IbIMessage.frame.origin.y, self.IbIMessage.frame.size.width, labelHeight)];
    [self.IbIMessage setText:self.IbIMessage.text];

    
    /*
    CGSize labelSize = [self.IbIMessage.text sizeWithFont:self.IbIMessage.font
                                        constrainedToSize:self.IbIMessage.frame.size
                                            lineBreakMode:self.IbIMessage.lineBreakMode];
    self.IbIMessage.frame = CGRectMake(
                                       self.IbIMessage.frame.origin.x, self.IbIMessage.frame.origin.y,
                                       self.IbIMessage.frame.size.width, labelSize.height);
    */
   // [htmlparsing sethtml:linkstring];
    //NSLog(@"linkstring:%@",linkstring);

   
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ", (int)webView.frame.size.width]];
    NSLog(@"ghdkgshlghsaklghslghkghsdkl");
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"[imagedelete description]=%@",[imagedelete description]);
    
    //if ([[imagedelete description] isEqual:@"On"]) {
        photostring = [htmlparsing getphotourl];
        NSURL *myURL = [NSURL URLWithString:photostring];
        NSLog(@"[photourl description]=%@",photostring);
        NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
        [webview loadRequest:myURLReq];
        
    //}
   
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
