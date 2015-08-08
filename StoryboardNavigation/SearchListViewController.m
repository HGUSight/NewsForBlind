//
//  SearchListViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 4. 3..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//
//  Edited by 김지웅 on 2015. 6. 8


#import "SearchListViewController.h"
#import "NewsArticleViewController.h"
#import "News.h"
#import "Fliter.h"
#import "HtmlParserclass.h"
#import "GetDataClass.h"

@interface SearchListViewController ()

@end

@implementation SearchListViewController

@synthesize elementType;
@synthesize xmlValue;
@synthesize receiveData;
@synthesize xmlParseData;
@synthesize currectItem;
@synthesize newsdata;
@synthesize currentindex;
@synthesize urldata;
@synthesize check;
@synthesize cell;
@synthesize searchResult;
@synthesize searchtext;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    resultcheck=0;
    
    xmlParseData = [[NSMutableArray alloc] init];
    xmlValue = [[NSMutableString alloc] init];
    currectItem = [[NSMutableDictionary alloc] init];
    receiveData = [[NSMutableData alloc] init];
    newsdata = [[NSMutableArray alloc] init];
    aNews=[[News alloc]init];
    fliter=[[Fliter alloc]init];
    searchResult=[[NSMutableArray alloc]init];
    getdata=[[GetDataClass alloc]init];
    
    moveback=true;
    searchvalue=[searchtext description];
    
    
    UIImage* myImage = [UIImage imageNamed:@"kyongbuklogo.png"];
    //[[UINavigationBar appearance] setBackgroundImage:myImage forBarMetrics:UIBarMetricsDefault];
    
    
    UIImageView* myImageView = [[UIImageView alloc] initWithImage:myImage];
    [myImageView setIsAccessibilityElement:YES];
    [myImageView setAccessibilityLabel:@"경북일보"];
    [myImageView setAccessibilityTraits:UIAccessibilityTraitStaticText];
    myImageView.frame=CGRectMake(0, 0, 10, 30);
    [self.navigationItem setTitleView:myImageView];
    [self.navigationItem setIsAccessibilityElement:YES];
    
     
     
}
-(void)viewWillAppear:(BOOL)animated {
    
    NSMutableString *appenddata = [[NSMutableString alloc]init];
    
    for (int i=0; i<totaldataarray.count; i++) {

        // euc-kr encoding:-2147481280]
        NSString *str = [[NSString alloc] initWithData: totaldataarray[i] encoding: NSUTF8StringEncoding];
//        str = [str stringByReplacingOccurrencesOfString:@"euc-kr" withString:@"utf-8"];
        str = [str stringByReplacingOccurrencesOfString:@"</rss>" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"</channel>" withString:@""];
        NSRange rssteg = [str rangeOfString:@"<rss[^<]*>" options:NSRegularExpressionSearch];
        if(rssteg.location != NSNotFound) {
            [(NSMutableString*)str deleteCharactersInRange:rssteg];
        }
        NSRange rssteg1 = [str rangeOfString:@"<?[^<]*?>" options:NSRegularExpressionSearch];
        if(rssteg1.location != NSNotFound) {
            [(NSMutableString*)str deleteCharactersInRange:rssteg1];
        }
        
        if (str!=NULL) {
            [appenddata appendString:str];
        }
        
    }
    
    receiveData=[[NSMutableData alloc]initWithData:[appenddata dataUsingEncoding:NSUTF8StringEncoding]];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receiveData];
    parser.delegate=(id)self;
	[parser parse];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    UITableView *tableView = (UITableView *)[self view];
	[tableView reloadData];
    
    moveback=true;
    
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
        // NSLog(@"기사제목=%@",aNews.category);
        
	} else if ([elementName isEqualToString:@"pubDate"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.pubData=[NSMutableString stringWithString:xmlValue];
       
        
	} else if ([elementName isEqualToString:@"item"]) {
        
		[xmlParseData addObject:[NSDictionary dictionaryWithDictionary:currectItem]];
        [newsdata addObject:aNews];
        searchrange=[aNews.title rangeOfString:searchvalue];
        if(searchrange.location!= NSNotFound) {
    
            [searchResult addObject:aNews];
        }
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
    
    moveback=false;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    sectionName = @"검색결과리스트";
    return sectionName;
    
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
    
}

-(void)viewDidDisappear:(BOOL)animated{
    if (moveback) {
       [self.navigationController popToRootViewControllerAnimated:animated];
    }
}


@end
