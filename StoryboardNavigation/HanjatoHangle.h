//
//  HanjatoHangle.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 3. 5..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MakeHanjaHangleMap;

@interface HanjatoHangle : NSObject {
    
   
    MakeHanjaHangleMap *makemap;
    NSMutableString * hangletext;
    
    
}

-(unichar)gethanja:(int)hanja;

@end
