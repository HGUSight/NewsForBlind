//
//  SettingViewController.m
//  StoryboardNavigation
//
//  Created by csee on 2014. 2. 22..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "NewsArticleViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    articleController=[[NewsArticleViewController alloc]init];
    imagecheck=[[NSString alloc]initWithString:@"true"];
    self.mySlider.minimumValue = 15;
    self.mySlider.maximumValue = 30;
    
    [self.hideImage addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

}

- (IBAction)sliderChanged:(id)sender
{
    //슬라이더에서 값을 가지고 옴
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    
    //테스트로 라벨에 크기를 찍어봄: self.myLabel.text = [NSString stringWithFormat:@"%d",val];
    [self.myLabel setFont:[UIFont systemFontOfSize:val]];
    
    //라벨 사이즈가 조정되도록
    self.myLabel.adjustsFontSizeToFitWidth = YES;
    [self.myLabel sizeToFit];
    
    //글로벌 변수에 지정한 폰트 사이즈를 저장하여 다른 페이지에서도 폰트 크기를 적용할 수 있도록 함
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fontS = val;
}

- (IBAction)flip:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (self.hideImage.on) {
        
        appDelegate.imageHiding = true;
        imagecheck=[[NSString alloc]initWithString:@"true"];
        articleController.imagecheckstr=imagecheck;
        NSLog(@"dfsfdfdg=%@",articleController.imagecheckstr);
    }
    else {
        
        appDelegate.imageHiding = false;
        imagecheck=[[NSString alloc]initWithString:@"false"];
        articleController.imagecheckstr=imagecheck;
        NSLog(@"dfsfdfdg=%@",articleController.imagecheckstr);

    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


@end

