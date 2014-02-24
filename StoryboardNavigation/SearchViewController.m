//
//  SearchViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 24..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "SearchViewController.h"
#import "NewsArticleViewController.h"
#import "News.h"
#import "Fliter.h"
#import "HtmlParserclass.h"

@interface SearchViewController ()

@end

@implementation SearchViewController


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
@synthesize checkString;
@synthesize searchResult;
@synthesize searchbar;
@synthesize cell;
@synthesize controlFlag;
@synthesize titlelist;
@synthesize searchResultdetail;
@synthesize linkarr;

BOOL moveBack;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [searchbar becomeFirstResponder];
    
   // UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.searchbar);
    
    controlFlag = 0;
    checkString =[check description];
    
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
    titlelist=[[NSMutableArray alloc]init];
    searchResultdetail=[[NSMutableArray alloc]init];



    for(int i=0;i<=8;i++) {
        
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

-(void)viewWillAppear:(BOOL)animated
{
     UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.searchbar);
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
		aNews.title=[NSMutableString stringWithString:xmlValue];
        [self.titlelist addObject:aNews.title];
        
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
    moveBack = false;
    
    if([[segue identifier]isEqualToString:@"TableIdentifier"])
    {
        
        NewsArticleViewController *viewController=[segue destinationViewController];
        NSIndexPath *currentIndexPath=[self.tableView indexPathForSelectedRow];
        NSIndexPath *indexPath=nil;
        
        
        if(self.searchDisplayController.isActive) {
            
            indexPath=[[self.searchDisplayController searchResultsTableView]indexPathForSelectedRow];
            News *buf=[[News alloc]init];
            buf=[searchResultdetail objectAtIndex:indexPath.row];
            NSString *data=buf.title;
            NSMutableString *data1=buf.description;
            NSMutableString *data2=buf.link;
            
            viewController.passData=data;
            viewController.passData1=data1;
            viewController.passData2=data2;
            
            
        }else {
            
            News *buf=[[News alloc]init];
            buf=[newsdata objectAtIndex:currentIndexPath.row];
            NSString *data=buf.title;
            NSMutableString *data1=buf.description;
            NSMutableString *data2=buf.link;
            
            viewController.passData=data;
            viewController.passData1=data1;
            viewController.passData2=data2;
            
        }
        
    }
    
}


-(void)searchThroughData
{
    self.searchResult=nil;
    NSPredicate *resultPredicate=[NSPredicate predicateWithFormat:@"self contains [search]%@",self.searchbar.text];
    
    self.searchResult=[[self.titlelist filteredArrayUsingPredicate:resultPredicate]mutableCopy];
    
    [self stringToObject];
    
}
-(void)stringToObject
{
    News *buf=[[News alloc]init];
    
    for(int i=0;i<self.searchResult.count;i++) {
        for(int j=0;j<self.newsdata.count;j++) {
            buf=newsdata[j];
            if([searchResult[i] isEqual: buf.title]) {
                [searchResultdetail addObject:buf];
                
            }
            
        }
    }
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchThroughData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==self.tableView) {
        
        return newsdata.count;
        
    }else {
        
        [self searchThroughData];
        return searchResult.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResuableCellWithIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cell.textLabel.text=[searchResult objectAtIndex:indexPath.row];
    }
    else {
        
        NSDictionary *dict = [xmlParseData objectAtIndex:indexPath.row];
        [[cell textLabel] setText:[dict objectForKey:@"title"]];
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.searchDisplayController.isActive) {
        [self performSegueWithIdentifier:@"TableIdentifier" sender:self];
    }
    
	[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"LastIndex"];
	
	[self selectTableViewCell:indexPath];
	
}
- (void)selectTableViewCell:(NSIndexPath*)indexPath
{
	@try {
		[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        NSManagedObjectModel *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
	}
	@catch (NSException * e) {
		
	}
	@finally {
        
	}
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    checkString =[check description];
    
    if(![checkString  isEqual: @"category"]) {
        moveBack = false;
    }else{
        moveBack = true;
        
    }
    
    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastIndex"];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    //[self performSelector:@selector(selectTableViewCell:) withObject:indexPath afterDelay:0.1];
    
    UITableView *tableView = (UITableView *)[self view];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.cell);
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(moveBack==true) {
        [self.navigationController popToRootViewControllerAnimated:animated];
        NSLog(@"move to root");
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
}
- (void)dealloc
{
    self.searchDisplayController.delegate = nil;
    self.searchDisplayController.searchResultsDelegate = nil;
    self.searchDisplayController.searchResultsDataSource = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}


@end
