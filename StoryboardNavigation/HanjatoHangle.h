//
//  HanjatoHangle.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 3. 5..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HanjatoHangle : NSObject {
    
    NSMutableArray *hanjatohangle;
    NSMutableArray * hanjaarray;
    NSMutableArray * hanglearray;
    NSString * filePath;
    NSMutableArray *list;
    NSCharacterSet *character;
    
}

-(void)gethanja:(char)hanja;

@end
