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
    NSMutableString *str=[NSMutableString stringWithString:[passData1 description]];
    NSMutableString *linkstring=[NSMutableString stringWithString:[passData2 description]];
    self.Textscroll.text=[htmlparsing sethtml:linkstring];
    self.Textscroll.editable = NO;
    textbuffer=[htmlparsing sethtml:linkstring];
    
    [doscrap setAction:@selector(doSaveNewsdetail)];
    
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
