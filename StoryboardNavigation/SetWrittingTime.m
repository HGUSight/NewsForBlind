//
//  SetWrittingTime.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 24..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//
//  Edited by 김지웅 on 2015. 6. 8

#import "SetWrittingTime.h"

@implementation SetWrittingTime

-(NSString*)setTime:(NSString*)getTime {
    
    if ( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Sun"]) {
        day=@"일요일";
    }else if( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Mon"]) {
        day=@"월요일";
    }else if( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Tue"]) {
        day=@"화요일";
    }else if( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Wed"]) {
        day=@"수요일";
    }else if( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Thu"]) {
        day=@"목요일";
    }else if( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Fri"]) {
        day=@"금요일";
    }else if( [[getTime substringWithRange:NSMakeRange(0,3)] isEqualToString:@"Sat"]) {
        day=@"토요일";
    }else ;
    
     
    if ( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Jan "]) {
        month=@"1월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Feb "]) {
        month=@"2월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Mar "]) {
        month=@"3월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Apr "]) {
        month=@"4월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"May "]) {
        month=@"5월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Jun "]) {
        month=@"6월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Jul "]) {
        month=@"7월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Aug "]) {
        month=@"8월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Sep "]) {
        month=@"9월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Oct "]) {
        month=@"10월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Nov "]) {
        month=@"11월";
    }else if( [[[getTime substringWithRange:NSMakeRange(6,6)] substringFromIndex:2] isEqualToString:@"Dec "]) {
        month=@"12월";
    }else ;

    daynum=[getTime substringWithRange:NSMakeRange(4,4)];
    
    writtingtime=[NSString stringWithFormat:@"%@ %@일 %@",month,daynum,day];
    
    return writtingtime;
}

@end
