//
//  ThirdViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 1. 26..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "CategoryViewController.h"
#import "MainNewsViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize itemlist;
@synthesize categoryCell;


- (void)viewDidLoad
{
    [super viewDidLoad];
     itemlist=[[NSMutableArray alloc]initWithObjects:@"전체기사",@"헤드라인",@"정치",@"자치행정",@"국제",@"사회",@"경제",@"문화",@"지역뉴스",@"스포츠,연예",@"사설,칼럼",@"특집",@"사람들", nil];
     num=0;
    
    UIImage* myImage = [UIImage imageNamed:@"kyoungbooklogo.png"];
    UIImageView* myImageView = [[UIImageView alloc] initWithImage:myImage];
    [myImageView setIsAccessibilityElement:YES];
    [myImageView setAccessibilityLabel:@"경북일보"];
    [myImageView setAccessibilityTraits:UIAccessibilityTraitStaticText];
    myImageView.frame=CGRectMake(0, 0, 10, 30);
    
    [self.navigationItem setTitleView:myImageView];
    [self.navigationItem setIsAccessibilityElement:YES];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    sectionName = @"카테고리별보기";
    return sectionName;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[itemlist objectAtIndex:indexPath.row];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"SecondeTableIdentifier"])
    {
        MainNewsViewController *viewController=[segue destinationViewController];
        NSIndexPath *currentIndexPath=[self.tableView indexPathForSelectedRow];
        
        num=(int)currentIndexPath.row;
        viewController.check = @"category";
        viewController.checkString =@"category";
        switch (num) {
                
            case 0:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/total.xml";
                break;
                
            case 1:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/headline.xml";
                break;
                
            case 2:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/politics.xml";
                break;
                
            case 3:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/self-government.xml";
                break;
                
            case 4:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/international.xml";
                break;
                
            case 5:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/national.xml";
                break;
                
            case 6:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/economy.xml";
                break;
                
            case 7:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/culture.xml";
                break;

            case 8:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/regionnews.xml";
                break;

            case 9:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/sportentertainment.xml";
                break;
            
            case 10:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/editorials.xml";
                break;
                
            case 11:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/special.xml";
                break;
                
            case 12:
                viewController.urldata=@"http://www.kyongbuk.co.kr/rss/people.xml";
                break;
                
            default:
                break;
        }
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
     //set focus 
 
    NSInteger row = 0;
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    //coloring
    [self performSelector:@selector(selectTableViewCell:) withObject:indexPath afterDelay:0.1];
    
    // focusing
    UITableView *tableView = (UITableView *)[self view];
    categoryCell = [tableView cellForRowAtIndexPath:indexPath];
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.categoryCell);
    
}

@end
