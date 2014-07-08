//
//  TextFieldViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "TextFieldViewController.h"
#import "SearchListViewController.h"
#import "GetDataClass.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    getdataclass=[[GetDataClass alloc]init];
    [getdataclass getdataclass];

    UIImage* myImage = [UIImage imageNamed:@"kyoungbooklogo.png"];
    UIImageView* myImageView = [[UIImageView alloc] initWithImage:myImage];
    [myImageView setIsAccessibilityElement:YES];
    [myImageView setAccessibilityLabel:@"경북일보"];
    [myImageView setAccessibilityTraits:UIAccessibilityTraitStaticText];
    myImageView.frame=CGRectMake(0, 0, 10, 30);
    
    [self.navigationItem setTitleView:myImageView];
    [self.navigationItem setIsAccessibilityElement:YES];
    
}
-(void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
     [self.textfield setText: @""];
}
-(void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
    
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.textfield);
    
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if([[segue identifier]isEqualToString:@"SearchIdentifier"])
    {
        
        SearchListViewController *viewController=[segue destinationViewController];
        
        searchtext=self.textfield.text;
        
        viewController.searchtext=searchtext;
        
    }
    
}
- (IBAction) textFieldDoneEditing:(id) sender // 텍스트 필드 입력 종료 액션
{
	/*[sender resignFirstResponder]; // 센더 (텍스트 필드)에게 최초 응답자 자리에서 물러나라는 메시지이다.
    SearchListViewController *viewcontroller = [[SearchListViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    searchtext=self.textfield.text;
    viewcontroller.searchtext=searchtext;
     */
    [self.textfield resignFirstResponder];

}
- (IBAction) Keyboardhidding:(id) sender // 텍스트 필드 입력 종료 액션
{
	[self.textfield resignFirstResponder]; // 센더 (텍스트 필드)에게 최초 응답자 자리에서 물러나라는 메시지이다.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}


@end
