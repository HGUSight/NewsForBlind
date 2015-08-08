//
//  TextFieldViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//
//  Edited by 김지웅 on 2015. 6. 8


#import "TextFieldViewController.h"
#import "SearchListViewController.h"
#import "GetDataClass.h"

@interface TextFieldViewController()

@end

@implementation TextFieldViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    getdataclass=[[GetDataClass alloc]init];
    [getdataclass getdataclass];

    
    UIImage* myImage = [UIImage imageNamed:@"kyongbuklogo.png"];
    //[[UINavigationBar appearance] setBackgroundImage:myImage forBarMetrics:UIBarMetricsDefault];
    
    
    UIImageView* myImageView = [[UIImageView alloc] initWithImage:myImage];
    [myImageView setIsAccessibilityElement:YES];
    [myImageView setAccessibilityLabel:@"경북일보"];
    [myImageView setAccessibilityTraits:UIAccessibilityTraitStaticText];
    myImageView.frame=CGRectMake(0, 0, 10, 30);
    [self.navigationItem setTitleView:myImageView];
    [self.navigationItem setIsAccessibilityElement:YES];
    
    
    [self.textfield setDelegate:self];
    [self.textfield setReturnKeyType:UIReturnKeyDone];
    [self.textfield addTarget:self action:@selector(textFieldDoneEditing:)forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.textfield becomeFirstResponder];

   
}

-(void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
     [self.textfield setText: @""];
}
-(void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
  
     [self.textfield becomeFirstResponder]; // 검색하기 탭에 들어올때마다 focus를 textfield에 잡도록 한다.
    
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
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.searchStart);
    // 완료 버튼을 누르면 자동으로 focus가 검색시작 버튼으로 이동
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


- (void)dealloc {
    [_searchStart release];
    [_searchStart release];
    [super dealloc];
}
@end
