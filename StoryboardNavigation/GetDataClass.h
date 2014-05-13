//
//  GetDataClass.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 5. 13..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

NSMutableArray *totaldataarray;

@interface GetDataClass : NSObject {
    
    NSURLConnection *xmlConnection;
	NSMutableData *receiveData;
    NSString *urlstring;
    NSMutableArray *linkarr;

}

-(void)getdataclass;

@end
