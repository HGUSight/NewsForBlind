//
//  SetWrittingTime.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 24..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetWrittingTime : NSObject {
                            
    NSString *month;
    NSString *day;
    NSString *daynum;
    NSString *writtingtime;
    
}

-(NSString*)setTime:(NSString*)getTime;
@end
