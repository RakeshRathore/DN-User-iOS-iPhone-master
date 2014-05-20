//
//  FavoriteList.m
//  Discount
//
//  Created by Sajith KG on 20/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "FavoriteList.h"
#import "FavoriteItemCell.h"
#import "DiscountViewController.h"
#import "AppDelegate.h"

@interface FavoriteList () {
    
    NSMutableArray *itemsArray;
}

@end

@implementation FavoriteList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    [discountViewController hideLeftButton:YES];
}

//- (void) viewWillDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    
//    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
//    [discountViewController hideLeftButton:NO];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.myTable.backgroundColor = RGB(244, 243, 237);
    
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.titleLbl.font = LATO_REGULAR(20);
    
    [self.myTable registerNib:[UINib nibWithNibName:@"FavoriteItemCell" bundle:nil]
                  forCellReuseIdentifier:@"FavoriteItemCell"];
    
//    itemsArray=[[NSMutableArray alloc] initWithObjects:@"Picture 1",@"Picture 2",@"Picture 3",@"Picture 4",@"Picture 5",@"Picture 6",@"Picture 7",@"Picture 8",@"Picture 9",@"Picture 10",nil];
    
    NSArray *keysArray = @[@"bussinessName",@"imageURL"];
    
    NSArray *valueArray1 = @[@"Azari Consulting",@"sAzari_Consulting.jpg"];
    NSArray *valueArray2 = @[@"Voodoo BBQ",@"bbqfav.jpg"];
    NSArray *valueArray3 = @[@"Blu Jeans",@"sBlu_Jeans.jpg"];
    NSArray *valueArray4 = @[@"Azari Consulting",@"sAzari_Consulting.jpg"];
    NSArray *valueArray5 = @[@"IT Solutions",@"scomputer_man.jpg"];
    NSArray *valueArray6 = @[@"Corner Club",@"sCorner_Club.jpg"];
    NSArray *valueArray7 = @[@"Sandies Pastries",@"sDessert.jpg"];
    NSArray *valueArray8 = @[@"Emerald Casino",@"sEmerald_Casino.jpg"];
    NSArray *valueArray9 = @[@"Focused Imaging",@"sFocused_Imaging.jpg"];
    NSArray *valueArray10 = @[@"Grease Pack Auto",@"sGrease_Pack_Auto.jpg"];
    NSArray *valueArray11 = @[@"Guitar Universe",@"sGuitar_Universe.jpg"];
    NSArray *valueArray12 = @[@"IT for U",@"sIT_for_U.jpg"];
    
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjects:valueArray1 forKeys:keysArray];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:valueArray2 forKeys:keysArray];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjects:valueArray3 forKeys:keysArray];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjects:valueArray4 forKeys:keysArray];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjects:valueArray5 forKeys:keysArray];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjects:valueArray6 forKeys:keysArray];
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjects:valueArray7 forKeys:keysArray];
    NSDictionary *dict8 = [NSDictionary dictionaryWithObjects:valueArray8 forKeys:keysArray];
    NSDictionary *dict9 = [NSDictionary dictionaryWithObjects:valueArray9 forKeys:keysArray];
    NSDictionary *dict10 = [NSDictionary dictionaryWithObjects:valueArray10 forKeys:keysArray];
    NSDictionary *dict11 = [NSDictionary dictionaryWithObjects:valueArray11 forKeys:keysArray];
    NSDictionary *dict12 = [NSDictionary dictionaryWithObjects:valueArray12 forKeys:keysArray];
    
    itemsArray = [[NSMutableArray alloc] initWithObjects:dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8,dict9,dict10,dict11,dict12,nil];
    
    [self.myTable reloadData];
}

//- (IBAction)favoriteBtnTapped:(id)sender {
//
//    UINavigationController *favNavi = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteNav"];
//    [self.view addSubview:favNavi.view];
//}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsArray count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FavoriteItemCell *cell = (FavoriteItemCell *)[tableView dequeueReusableCellWithIdentifier:@"FavoriteItemCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell.selectionBtn1 addTarget:self action:@selector(favItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectionBtn2 addTarget:self action:@selector(favItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    // NSDictionary *currentDict=[itemsArray objectAtIndex:indexPath.row];
    
//    cell.itemView1.itemTitle.text = [itemsArray objectAtIndex:indexPath.row];
//    
//    cell.itemView1.itemPic.image = [UIImage imageNamed:@"sample1.png"];
//    cell.itemView2.itemPic.image = [UIImage imageNamed:@"sample2.jpg"];
    
    for (int i=0; i<2; i++)
    {
        long int itemNo = (indexPath.row*2)+i;
        if (itemNo<[itemsArray count]) {
            
            NSDictionary *currentDict=[itemsArray objectAtIndex:itemNo];
            
            switch (i) {
                case 0:
                    cell.favTitleLbl1.text = [currentDict objectForKey:@"bussinessName"];
                    [cell.businessImage1 setImage:[UIImage imageNamed:[currentDict objectForKey:@"imageURL"]]];
                    break;
                case 1:
                    cell.favTitleLbl2.text = [currentDict objectForKey:@"bussinessName"];
                    [cell.businessImage2 setImage:[UIImage imageNamed:[currentDict objectForKey:@"imageURL"]]];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void) favItemSelected:(UIButton*) sender {
    
    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    [discountViewController showBackButton:YES];

    FavoriteDetail *favoriteDetail = [[FavoriteDetail alloc] init];
    favoriteDetail.isFavoriteMode=YES;
    favoriteDetail.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:favoriteDetail animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
