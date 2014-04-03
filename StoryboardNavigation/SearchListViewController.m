//
//  SearchListViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "SearchListViewController.h"
#import "NewsArticleViewController.h"
#import "News.h"
#import "Fliter.h"
#import "HtmlParserclass.h"

@interface SearchListViewController ()

@end

@implementation SearchListViewController

@synthesize xmlConnection;
@synthesize elementType;
@synthesize xmlValue;
@synthesize receiveData;
@synthesize xmlParseData;
@synthesize currectItem;
@synthesize newsdata;
@synthesize currentindex;
@synthesize textbuffer;
@synthesize urlstring;
@synthesize urldata;
@synthesize check;
@synthesize cell;
@synthesize searchResult;
@synthesize linkarr;
@synthesize searchtext;
@synthesize searchResultdetail;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    resultcheck=0;
    
    //[self searchnews];

    
    linkarr=[[NSMutableArray alloc]init];
    
    
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/headline.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/politics.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/self-government.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/international.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/national.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/economy.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/culture.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/regionnews.xml"];
    [linkarr addObject:@"http://www.kyongbuk.co.kr/rss/sportentertainment.xml"];
    
    
    xmlParseData = [[NSMutableArray alloc] init];
    xmlValue = [[NSMutableString alloc] init];
    currectItem = [[NSMutableDictionary alloc] init];
    receiveData = [[NSMutableData alloc] init];
    newsdata = [[NSMutableArray alloc] init];
    aNews=[[News alloc]init];
    fliter=[[Fliter alloc]init];
    textbuffer=[[NSMutableString alloc]init];
    htmlparser=[[HtmlParserclass alloc]init];
    searchResult=[[NSMutableArray alloc]init];
    searchResultdetail=[[NSMutableArray alloc]init];
    
    
    for(int i=0;i<8;i++) {
        
        urlstring = linkarr[i];
        
        
        xmlConnection = [[NSURLConnection alloc]
                         initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]]
                         delegate:self];
        
        if (xmlConnection == nil)
            NSLog(@"Connect error");
        
        else
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    }

            
}

#pragma mark URLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Receive: %@, %@, %d",
		  [response URL],
		  [response MIMEType],
		  [response expectedContentLength]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@", [error localizedDescription]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *str = [[NSString alloc] initWithData:receiveData encoding:-2147481280];
    str = [str stringByReplacingOccurrencesOfString:@"euc-kr" withString:@"utf-8"];
    receiveData=[str dataUsingEncoding:NSUTF8StringEncoding];
    
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receiveData];
	
    [parser setDelegate:self];
	[parser parse];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UITableView *tableView = (UITableView *)[self view];
	[tableView reloadData];
}

#pragma mark XMLParse delegate methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"item"])
		elementType = etItem;
        
        [xmlValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
 
	if (elementType != etItem)
		return;
    
	if ([elementName isEqualToString:@"title"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
		aNews.title=[NSMutableString stringWithString:[fliter settext:xmlValue]];
        
        
	} else if ([elementName isEqualToString:@"link"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.link=[NSMutableString stringWithString:xmlValue];
        
    } else if ([elementName isEqualToString:@"description"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.description=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"category"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.category=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"pubDate"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.pubData=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"item"]) {
		[xmlParseData addObject:[NSDictionary dictionaryWithDictionary:currectItem]];
        [newsdata addObject:aNews];
        aNews = [[News alloc]init];
        
	}
    

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string {
	if (elementType == etItem) {
        [xmlValue appendString:string];
	}
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier]isEqualToString:@"TableIdentifier"])
    {
        
        NewsArticleViewController *viewController=[segue destinationViewController];
        NSIndexPath *currentIndexPath=[self.tableView indexPathForSelectedRow];

            News *buf=[[News alloc]init];
            buf=[searchResult objectAtIndex:currentIndexPath.row];
            NSString *data=buf.title;
            NSMutableString *data1=buf.description;
            NSMutableString *data2=buf.link;
            
            viewController.passData=data;
            viewController.passData1=data1;
            viewController.passData2=data2;
            
    }
    
}


-(void)searchnews {
    
    searchvalue=[searchtext description];
    
    for(int i=0;i<newsdata.count;i++) {
        
        News *buffer=[[News alloc]init];
        buffer=newsdata[i];
        searchrange=[buffer.title rangeOfString:searchvalue];
        
        if(searchrange.location!= NSNotFound) {
            NSLog(@"FOUND");
            [searchResult addObject:buffer];
            
            
        }
        
    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self searchnews];
    newsdata = [[NSMutableArray alloc] init];
    resultcheck++;
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (searchResult.count!=0) {
        return searchResult.count;
    }
    else
        
        return 1;
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (searchResult.count!=0) {
        
        News *buffer=[[News alloc]init];
        buffer=searchResult[indexPath.row];
        cell.textLabel.text=buffer.title;

    }else
    
         cell.textLabel.text=@"검색결과가 없습니다. 다시 검색해 주세요";
    
    
    return cell;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
//[self searchnews];
    
}
-(void)viewWillAppear:(BOOL)animated{

}
-(void)viewDidDisappear:(BOOL)animated{
}


@end
