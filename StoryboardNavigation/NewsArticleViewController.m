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


@interface NewsArticleViewController ()

@end

@implementation NewsArticleViewController
@synthesize passData,passData1,passData2;
@synthesize textbuffer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fliter=[[Fliter alloc]init];
    htmlparsing=[[HtmlParserclass alloc]init];
    
    self.IbIMessage.text=[passData description];
    NSMutableString *str=[NSMutableString stringWithString:[passData1 description]];
    NSMutableString *linkstring=[NSMutableString stringWithString:[passData2 description]];
    textbuffer=[fliter settext:str];
    self.Textscroll.text=[htmlparsing sethtml:linkstring];
    self.Textscroll.editable = NO;
    
    
    
   // [htmlparsing sethtml:linkstring];
    NSLog(@"linkstring:%@",linkstring);
   
    
    
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
- (void)dealloc {
    [_Textscroll release];
    [super dealloc];
}
@end
