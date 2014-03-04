//
//  ViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
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
@synthesize passData,passData1,passData2;
@synthesize textbuffer;
@synthesize saveNewArr;
@synthesize doscrap;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fliter=[[Fliter alloc]init];
    htmlparsing=[[HtmlParserclass alloc]init];
    newscontroller=[[MainNewsViewController alloc]init];
    news=[[News alloc]init];
    
    
    self.IbIMessage.text=[passData description];

    NSMutableString *linkstring=[NSMutableString stringWithString:[passData2 description]];
    self.Textscroll.text=[htmlparsing sethtml:linkstring];
    self.Textscroll.editable = NO;
    
    
    textbuffer=[htmlparsing sethtml:linkstring];
    [doscrap setAction:@selector(doSaveNewsdetail)];
    
    //라벨 사이즈가 조정되도록
    self.IbIMessage.adjustsFontSizeToFitWidth = YES;
    [self.IbIMessage sizeToFit];
    self.IbIMessage.numberOfLines = 0;
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.IbIMessage setFont:[UIFont systemFontOfSize:appDelegate.fontS+10]];
    [self.Textscroll setFont:[UIFont boldSystemFontOfSize:appDelegate.fontS]];
    
    CGSize labelSize = [self.IbIMessage.text sizeWithFont:self.IbIMessage.font
                                        constrainedToSize:self.IbIMessage.frame.size
                                            lineBreakMode:self.IbIMessage.lineBreakMode];
    self.IbIMessage.frame = CGRectMake(
                                       self.IbIMessage.frame.origin.x, self.IbIMessage.frame.origin.y,
                                       self.IbIMessage.frame.size.width, labelSize.height);
    
   // [htmlparsing sethtml:linkstring];
    //NSLog(@"linkstring:%@",linkstring);

   
	// Do any additional setup after loading the view, typically from a nib.
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
