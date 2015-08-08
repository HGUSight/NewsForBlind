//
//  TextFieldViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetDataClass;

@interface TextFieldViewController : UIViewController <UITextFieldDelegate>  {
    
    NSString *searchtext;
    GetDataClass *getdataclass;
}
- (IBAction) textFieldDoneEditing:(id) sender;
- (IBAction) Keyboardhidding:(id) sender;
@property (retain, nonatomic) IBOutlet UIButton *cancel;
@property (retain, nonatomic) IBOutlet UITextField *textfield;
@property (retain, nonatomic) IBOutlet UIButton *searchStart;


@end
