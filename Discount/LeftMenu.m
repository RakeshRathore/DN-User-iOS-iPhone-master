//
//  LeftMenu.m
//  Discount
//
//  Created by Sajith KG on 30/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "LeftMenu.h"
#import "AppDelegate.h"
#import "RootVC.h"
#import "CategoryCell.h"

@interface LeftMenu (){
    
    NSMutableArray *categoryAry,*subCategoryAry;
    NSInteger selectedRow;
}

@end

@implementation LeftMenu


- (void) setSelectedNoOfSubCategories:(NSInteger)selectedNoOfSubCategories {

    _selectedNoOfSubCategories = selectedNoOfSubCategories;
    [self.menuTable reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedRow = unselectedRow;
    
    self.selectedNoOfSubCategories = 0;
    
//    categoryAry = [[NSMutableArray alloc] initWithObjects:@"Restaurants",@"Entertainment",@"Events",@"Home",@"Automative", nil];
    
    subCategoryAry = [[NSMutableArray alloc] init];
    
    NSDictionary *temp1 = @{ @"category": @"Restaurants",@"categoryPicture": @"menu_restaurent.png", @"subCategories": @[@"American",@"Asian",@"BBQ",@"Bakery",@"Breakfast",@"Coffee and Tea",@"Deli",@"Dessert",@"Dinner"]};
    NSDictionary *temp2 = @{ @"category": @"Entertainment",@"categoryPicture": @"menu_entertainment.png",  @"subCategories": @[@"Entertainment_1",@"Entertainment_2",@"Entertainment_3"]};
    NSDictionary *temp3 = @{ @"category": @"Events" ,@"categoryPicture": @"menu_events.png" ,@"subCategories": @[@"Events_1",@"Events_2",@"Events_3"]};
    NSDictionary *temp4 = @{ @"category":@"Home" ,@"categoryPicture": @"menu_home.png" ,@"subCategories": @[@"Home_1",@"Home_2",@"Home_3",@"Home_4",@"Home_5",@"Home_6"]};
    NSDictionary *temp5 = @{ @"category":@"Services" ,@"categoryPicture": @"menu_service.png" ,@"subCategories": @[@"Services_1",@"Services_2",@"Services_3",@"Services_4",@"Services_5",@"Services_6"]};
    NSDictionary *temp6 = @{ @"category":@"Automotive" ,@"categoryPicture": @"menu_automative.png" ,@"subCategories": @[@"Automotive 1",@"Automotive 2",@"Automotive 3",@"Automotive 4"]};
    NSDictionary *temp7 = @{ @"category":@"Travel" ,@"categoryPicture": @"menu_travel.png" ,@"subCategories": @[@"Travel 1",@"Travel 2",@"Travel 3",@"Travel 4",@"Travel 5",@"Travel 6"]};
    NSDictionary *temp8 = @{ @"category":@"Business" ,@"categoryPicture": @"menu_business.png" ,@"subCategories": @[@"Business 1",@"Business 2",@"Business 3"]};
    NSDictionary *temp9 = @{ @"category":@"Retail" ,@"categoryPicture": @"menu_reatil.png" ,@"subCategories": @[@"Retail 1",@"Retail 2",@"Retail 3",@"Retail 4",@"Retail 5",@"Retail 6"]};
    NSDictionary *temp10 = @{ @"category":@"Health" ,@"categoryPicture": @"menu_health.png" ,@"subCategories": @[@"Health 1",@"Health 2",@"Health 3",@"Health 4",@"Health 5",@"Health 6"]};
    
    categoryAry = [[NSMutableArray alloc] initWithObjects:temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10, nil];
    
    self.menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.menuTable registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil]
       forCellReuseIdentifier:@"CategoryCell"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoryAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.categoryName.textColor = [UIColor colorWithRed:182/255.0f green:211/255.0f blue:253/255.0f alpha:1.0f];
    
    cell.categoryName.text = [[categoryAry objectAtIndex:indexPath.row] objectForKey:@"category"];
    
    cell.iconImg.image = [UIImage imageNamed:[[categoryAry objectAtIndex:indexPath.row] objectForKey:@"categoryPicture"]];
    
    if (indexPath.row == selectedRow) {
        [cell.contentView setBackgroundColor:RGB(19, 29, 41)];
        
        if (self.selectedNoOfSubCategories>0) {
            cell.categoryName.text = [NSString stringWithFormat:@"%@ (%ld)",[[categoryAry objectAtIndex:indexPath.row] objectForKey:@"category"],self.selectedNoOfSubCategories];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedRow = indexPath.row;

    [tableView reloadData];
    
    [MY_APP_DELEGATE.rootVC showSubCategoryView:[categoryAry objectAtIndex:indexPath.row]];
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"willShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"didShowMenuViewController");
    
    [self.menuTable reloadData];
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"willHideMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"didHideMenuViewController");
}



@end
