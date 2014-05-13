//
//  SearchListViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@class Fliter;
@class HtmlParserclass;
@class GetDataClass;

typedef enum {
	etNone = 0,
	etItem
}eElementType;


@interface SearchListViewController : UITableViewController {
    
    NSString *searchvalue;
	eElementType elementType;
	NSMutableString *xmlValue;
	NSMutableData *receiveData;
	NSMutableArray *xmlParseData;
	NSMutableDictionary *currectItem;
    NSMutableArray *newsdata;
    News *aNews;
    NSIndexPath *currentindex;
    Fliter *fliter;
    NSMutableArray *searchResult;
    UITableViewCell *cell;
    NSRange searchrange;
    int resultcheck;
    GetDataClass *getdata;
    
    
}

@property (strong, nonatomic)id searchtext;
@property (nonatomic)eElementType elementType;
@property (nonatomic, retain)NSMutableString *xmlValue;
@property (nonatomic, retain)NSMutableData *receiveData;
@property (nonatomic, retain)NSMutableArray *xmlParseData;
@property (nonatomic, retain)NSMutableDictionary *currectItem;
@property (nonatomic, retain)NSMutableArray *newsdata;
@property (nonatomic,retain) NSIndexPath *currentindex;
@property (strong, nonatomic)id urldata;
@property (strong, nonatomic)id check;
@property (strong, nonatomic)NSMutableArray *searchResult;
@property (nonatomic, retain)UITableViewCell *cell;



@end
