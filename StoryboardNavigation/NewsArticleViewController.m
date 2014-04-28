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
    
    linkstring=[NSMutableString stringWithString:[passData2 description]];
    self.IbIMessage.text=[passData description];
    
    newsdetail=[htmlparsing sethtml:linkstring];
    photostring = [htmlparsing getphotourl];
    
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,540)];
    mainScrollView.showsVerticalScrollIndicator=YES;
    mainScrollView.scrollEnabled=YES;
    mainScrollView.userInteractionEnabled=YES;
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize=CGSizeMake(320,1100);
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    
       NSLog(@"[photourl description]=%@",photostring);
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //기사 제목 폰트 조절
    CGRect textViewRect=CGRectMake(20.0f, 120.0f, 280.0f, 60.0f);
    
    titleview =[[UITextView alloc]initWithFrame: textViewRect];
    [titleview setFont:[UIFont systemFontOfSize:appDelegate.fontS+5]];
    titleview.editable = NO;
    titleview.selectable= YES;
    titleview.isAccessibilityElement=YES;
    titleview.userInteractionEnabled=YES;
    [titleview setText:self.IbIMessage.text];
    titleview.scrollEnabled = NO;
    titleview.bounces = NO;
    
    [self.view addSubview:titleview];
    
    ////////////
    
    
    
    ////////////
    
    if (photostring!=NULL) {
        
        CGRect ViewRect=CGRectMake(40.0f, 120.0f, 240.0f, 100.0f);
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
        [webview setScalesPageToFit:YES];
        
       
        CGRect textViewRect=CGRectMake(20.0f, 260.0f, 280.0f, 1000.0f);
        imagetextview=[[UITextView alloc]initWithFrame: textViewRect];
        imagetextview.editable = NO;
        imagetextview.scrollEnabled = NO;
        imagetextview.selectable= YES;

        
        [imagetextview setIsAccessibilityElement:YES];
        [imagetextview setFont:[UIFont systemFontOfSize:12.0f]];

        [imagetextview setText:newsdetail];
        
        [mainScrollView addSubview:webview];
        [mainScrollView addSubview:imagetextview];
        //[mainScrollView addSubview:titleview];
        [mainScrollView setIsAccessibilityElement:YES];
       
    }else {
        
        CGRect textViewRect=CGRectMake(20.0f, 120.0f, 280.0f, 370.0f);
        textview=[[UITextView alloc]initWithFrame: textViewRect];
        
        [textview setFont:[UIFont systemFontOfSize:12.0f]];
        textview.editable = NO;
        textview.selectable= YES;
        textview.isAccessibilityElement=YES;
        textview.userInteractionEnabled=YES;
        
        [textview setText:newsdetail];
        [self.view addSubview:textview];
        //[self.view addSubview:titleview];
        
    }
    
    
    
    //기사 내용 폰트 조절
    [textview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    [imagetextview setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    
    
    
    
    
    /*
    [self.IbIMessage setFont:[UIFont systemFontOfSize:appDelegate.fontS]];
    [self.IbIMessage setLineBreakMode:UILineBreakModeClip];
    [self.IbIMessage setNumberOfLines:3];
    
    CGSize constraintSize = CGSizeMake(320, 20);
    CGSize newSize = [self.IbIMessage.text sizeWithFont:[UIFont systemFontOfSize:appDelegate.fontS] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeClip];
    CGFloat labelHeight = MAX(newSize.height, 20);
    [self.IbIMessage setFrame:CGRectMake(self.IbIMessage.frame.origin.x, self.IbIMessage.frame.origin.y, self.IbIMessage.frame.size.width, labelHeight)];
    [self.IbIMessage setText:self.IbIMessage.text];*/
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}


- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
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


 - (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    NSString *webHeight = [webview stringByEvaluatingJavaScriptFromString:@"document.height;"];
    NSLog(@"WebView Height %@", webHeight);
    
    CGRect frame = webview.frame;
    frame.size.height = 1;
    webview.frame = frame;
    CGSize fittingSize = [webview sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webview.frame = frame;
 
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    mainScrollView.contentSize = webview.bounds.size;
}

- (CGFloat)measureHeightOfUITextView:(UITextView *)textView
{
    if ([textView respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        // This is the code for iOS 7. contentSize no longer returns the correct value, so
        // we have to calculate it.
        //
        // This is partly borrowed from HPGrowingTextView, but I've replaced the
        // magic fudge factors with the calculated values (having worked out where
        // they came from)
        
        CGRect frame = textView.bounds;
        
        // Take account of the padding added around the text.
        
        UIEdgeInsets textContainerInsets = textView.textContainerInset;
        UIEdgeInsets contentInsets = textView.contentInset;
        
        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
        
        frame.size.width -= leftRightPadding;
        frame.size.height -= topBottomPadding;
        
        NSString *textToMeasure = textView.text;
        if ([textToMeasure hasSuffix:@"\n"])
        {
            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
        }
        
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
        
        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        
        CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
        return measuredHeight;
    }
    else
    {
        return textView.contentSize.height;
    }
}
@end
