//
//  MakeHanjaHangleMap.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 3. 22..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MakeHanjaHangleMap : NSObject {
    NSMutableArray *hanjatohangle;
    NSMutableArray * hanjaarray;
    NSMutableArray * hanglearray;
    NSString * filePath;
    NSMutableArray *list;
    NSCharacterSet *character;
}

@property (nonatomic, retain)NSMutableArray *hanjatohangle;
@property (nonatomic, retain)NSMutableArray * hanjaarray;
@property (nonatomic, retain)NSMutableArray * hanglearray;
@property (nonatomic, retain)NSString * filePath;
@property (nonatomic, retain)NSMutableArray *list;
@property (nonatomic, retain)NSCharacterSet *character;

-(void)makehanjahanglemap;

@end
