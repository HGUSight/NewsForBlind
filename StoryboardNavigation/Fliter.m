//
//  Fliter.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 1. 24..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "Fliter.h"
#import "HanjatoHangle.h"

@implementation Fliter


- (NSMutableString *) settext:(NSMutableString *)s1 {
    
    hanjatohangle= [[HanjatoHangle alloc]init];
    
    for(int i = 0; i < [s1 length]; i++) {
        
        teg = [s1 rangeOfString:@"<[^<]*>" options:NSRegularExpressionSearch];
        misteg= [s1 rangeOfString:@"<!--"];
        equalchar=[s1 rangeOfString:@"= "];
        wavesymbol=[s1 rangeOfString:@"∼"];
        wavesymbol2=[s1 rangeOfString:@"~"];
        centerdot=[s1 rangeOfString:@"·"];
        corporationmark=[s1 rangeOfString:@"(주)"];
        hanja=[s1 rangeOfString:@"[\u4E00-\u9FBF]" options:NSRegularExpressionSearch];
        
        if(teg.location != NSNotFound) {
           
            [s1 deleteCharactersInRange:teg];
           
        }else if(misteg.location != NSNotFound) {
            
            [s1 deleteCharactersInRange:misteg];
        
        }else if(equalchar.location!=NSNotFound) {
           
            [s1 replaceCharactersInRange:equalchar withString:@"는"];
            
        }else if(wavesymbol.location!=NSNotFound) {
            
            [s1 replaceCharactersInRange:wavesymbol withString:@"에서 "];
        
        }else if(wavesymbol2.location!=NSNotFound) {
            
            [s1 replaceCharactersInRange:wavesymbol2 withString:@"에서 "];
            
        }else if(centerdot.location!=NSNotFound) {
            
            [s1 replaceCharactersInRange:centerdot withString:@" "];
            
        }else if(corporationmark.location!=NSNotFound) {
            
            [s1 replaceCharactersInRange:corporationmark withString:@"㈜"];
            
        }else if(hanja.location!= NSNotFound) {
            
            char hanjachar=[s1 characterAtIndex:hanja.location];
            NSLog(@"char: %C",[s1 characterAtIndex:hanja.location]);
            NSLog(@"char: %X",[s1 characterAtIndex:hanja.location]);
            //[hanjatohangle gethanja:hanjachar];
            
        }else {
           
            break;
        }
    
    }
    
    return s1;

}

@end
