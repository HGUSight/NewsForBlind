//
//  HanjatoHangle.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 3. 5..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "HanjatoHangle.h"
#import "MakeHanjaHangleMap.h"

@implementation HanjatoHangle

  -(unichar)gethanja:(int)hanja {
      
      NSRange range;
      const char* cString;
      unichar returnvalue;
     
      
      makemap=[[MakeHanjaHangleMap alloc]init];
      [makemap makehanjahanglemap];

    for(int i=0;i<[makemap.hanjaarray count];i++) {
          if(hanja==[makemap.hanjaarray[i] intValue]) {
              
              hangletext=[NSMutableString stringWithString:makemap.hanglearray[i]];
              range=[hangletext rangeOfString:@"0x"];

              if(range.location != NSNotFound) {
                  
                [hangletext deleteCharactersInRange:range];
                  
              }
            
              //NSLog(@"한자를 한글로:%@",hangletext);
              cString= [hangletext cStringUsingEncoding:[NSString defaultCStringEncoding]];
              int hexValue = (int)strtol(cString, NULL, 16);
              //NSLog(@"한자를 한글로:%C",hexValue);
              returnvalue=(unichar)hexValue;
             // NSLog(@"한자를 한글로:%C",returnvalue);
              
              return returnvalue;
              
          }
      }
      
}
@end
