//
//  SearchViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 21..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@class Fliter;
@class HtmlParserclass;



typedef enum {
	etNone = 0,
	etItem
}eElementType;

@interface SearchViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate,NSXMLParserDelegate> {
    NSURLConnection *xmlConnection;
	eElementType elementType;
	NSMutableString *xmlValue;
	NSMutableData *receiveData;
	NSMutableArray *xmlParseData;
	NSMutableDictionary *currectItem;
    NSMutableArray *newsdata;
    News *aNews;
    NSIndexPath *currentindex;
    NSMutableString *textbuffer;
    Fliter *fliter;
    NSString *urlstring;
    NSString *checkString;
    HtmlParserclass *htmlparser;
    NSMutableArray *serachResult;
    UITableViewCell *cell;
    int controlFlag;
    NSMutableArray *titlelist;
    NSMutableArray *searchResultdetail;
    
}
@property (nonatomic, retain)NSURLConnection *xmlConnection;
@property (nonatomic)eElementType elementType;
@property (nonatomic, retain)NSMutableString *xmlValue;
@property (nonatomic, retain)NSMutableData *receiveData;
@property (nonatomic, retain)NSMutableArray *xmlParseData;
@property (nonatomic, retain)NSMutableDictionary *currectItem;
@property (nonatomic, retain)NSMutableArray *newsdata;
@property (nonatomic) NSIndexPath *currentindex;
@property (nonatomic, retain) NSMutableString *textbuffer;
@property (nonatomic,retain) NSString *urlstring;
@property (nonatomic,retain) NSString *checkString;
@property (strong, nonatomic)id urldata;
@property (strong, nonatomic)id check;
@property (strong, nonatomic)NSMutableArray *searchResult;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (nonatomic, retain)UITableViewCell *cell;
@property (nonatomic)int controlFlag;
@property (nonatomic, strong)NSMutableArray *titlelist;
@property (nonatomic, strong)NSMutableArray *searchResultdetail;

@end
