//
//  AppDelegate.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    ViewController *viewcontroller;
    NSInteger fontS;    //폰트 사이즈 변수를 모든 클래스에서 접근 가능하도록 함
}

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) NSInteger fontS;

@end
