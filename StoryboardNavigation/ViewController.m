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
@interface ViewController ()

@end

@implementation ViewController
@synthesize passData,passData1;
@synthesize textbuffer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fliter=[[Fliter alloc]init];
    self.IbIMessage.text=[passData description];
    NSMutableString *str; 
    str =[NSMutableString stringWithString:[passData1 description]];
    textbuffer=[fliter settext:str];
    self.Textscroll.text=textbuffer;
    self.Textscroll.editable = NO;
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

- (void)viewDidUnload{
    [super viewDidUnload];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:animated];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
     [self.navigationController popToRootViewControllerAnimated:NO];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
@end
