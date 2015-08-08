//
//  ThirdViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 1. 26..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//
//  Edited by 김지웅 on 2015. 6. 8


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
     itemlist=[[NSMutableArray alloc]initWithObjects:@"전체기사",@"경북 대구 울산",@"지방의회",@"정치",@"경제",@"사회",@"국제",@"문화",@"스포츠",@"오피니언",@"특집",@"사람들", nil];
     num=0;
    
    
    UIImage* myImage = [UIImage imageNamed:@"kyongbuklogo.png"];
    //[[UINavigationBar appearance] setBackgroundImage:myImage forBarMetrics:UIBarMetricsDefault];
    
    
    UIImageView* myImageView = [[UIImageView alloc] initWithImage:myImage];
    [myImageView setIsAccessibilityElement:YES];
    [myImageView setAccessibilityLabel:@"경북일보"];
    [myImageView setAccessibilityTraits:UIAccessibilityTraitStaticText];
    myImageView.frame=CGRectMake(0, 0, 10, 30);
    [self.navigationItem setTitleView:myImageView];
    [self.navigationItem setIsAccessibilityElement:YES];
    

    // 보이스오버에서 뒤로가기 버튼 2번 읽는 부분을 공백처리함으로써 한번만 읽음
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"   "
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    
    
    [backItem release];
    

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
                
            case 0:                     // 전체기사
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/01.xml";
                break;
                
            case 1:                     // 경북 대구 울산
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855002.xml";
                break;
                
            case 2:                     // 지방의회
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855016.xml";
                break;
                
            case 3:                     // 정치
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855024.xml";
                break;
                
            case 4:                     // 경제
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855029.xml";
                break;
                
            case 5:                     // 사회
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855033.xml";
                break;
                
            case 6:                     // 국제
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855066.xml";
                break;
                
            case 7:                     // 문화
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855037.xml";
                break;

            case 8:                     // 스포츠
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855040.xml";
                break;
            
            case 9:                    // 오피니언
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855052.xml";
                break;
                
            case 10:                    // 기획,특집
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855056.xml";
                break;
                
            case 11:                    // 사람들
                viewController.urldata=@"http://ph.kyongbuk.co.kr/rss/1424855049.xml";
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
