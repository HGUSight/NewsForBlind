//
//  TextFieldViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "TextFieldViewController.h"
#import "SearchListViewController.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
}


#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if([[segue identifier]isEqualToString:@"SearchIdentifier"])
    {
        
        SearchListViewController *viewController=[segue destinationViewController];
        
        searchtext=self.textfield.text;
        
        viewController.searchtext=searchtext;
        
        NSLog(@"textfield:%@",searchtext);
        
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
