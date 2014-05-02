//
//  MakeHanjaHangleMap.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 3. 22..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "MakeHanjaHangleMap.h"

@implementation MakeHanjaHangleMap
@synthesize hanjatohangle;
@synthesize hanjaarray;
@synthesize hanglearray;
@synthesize list;
@synthesize character;
@synthesize filePath;


-(void)makehanjahanglemap {
    
    int index=0;
    int i=0;
    list=[[NSMutableArray alloc]init];
    hanjatohangle=[[NSMutableArray alloc]init];
    hanjaarray=[[NSMutableArray alloc]init];
    hanglearray=[[NSMutableArray alloc]init];
    
    
    filePath=[[NSBundle mainBundle] pathForResource:@"hanja" ofType:@"txt"];
    
    if(filePath) {
        
        NSRange range;
        NSString *content=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        for (NSString *line in [content componentsSeparatedByString:@"\n"]) {
            range=[line rangeOfString:@"/*"];
                    if (range.location==NSNotFound) {
                        for(NSString *hanja in [line componentsSeparatedByString:@","]) {
                            [hanjatohangle addObject:hanja];
                        }
                    }
        }
        
    }
    
    for (i=0;i<[hanjatohangle count];i++) {
        
          NSNumber *hanjaint=[NSNumber numberWithInt:(0x4E00+index++)];
          [hanjaarray addObject:hanjaint];
          [hanglearray addObject:hanjatohangle[i]];
        
    }

}

@end
