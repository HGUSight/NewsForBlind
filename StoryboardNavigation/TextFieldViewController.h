//
//  TextFieldViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldViewController : UIViewController {
    
    NSString *searchtext;
}

@property (retain, nonatomic) IBOutlet UITextField *textfield;


@end
