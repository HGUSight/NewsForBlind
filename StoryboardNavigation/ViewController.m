//
//  ViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import "ViewController.h"
#import "ThirdViewController.h"
#import "Fliter.h"
#import "News.h"
#import "NowViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize passData,passData1;
@synthesize textbuffer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fliter=[[Fliter alloc]init];
    nowviewctr=[[NowViewController alloc]init];
   
    self.IbIMessage.text=[passData description];
    NSMutableString *str; 
    str =[NSMutableString stringWithString:[passData1 description]];
    textbuffer=[fliter settext:str];
    self.Textscroll.text=textbuffer;
    self.Textscroll.editable = NO;
    nowviewctr.nowViewcontroller=@"viewcontroller";
   
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_Textscroll release];
    [super dealloc];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:animated];
}
@end
