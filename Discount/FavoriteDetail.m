//
//  FavoriteDetail.m
//  Discount
//
//  Created by Sajith KG on 21/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "FavoriteDetail.h"
#import "FavoriteDetailCell.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "DiscountDetail.h"

//static NSInteger unselectedRow = -1;

@interface FavoriteDetail () {

    NSMutableArray *dealsArray;
    NSInteger selectedRow;
}

@end

@implementation FavoriteDetail

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
    self.view.backgroundColor = STATUS_BAR_COLOR;
    self.dealTable.backgroundColor = [UIColor whiteColor];
    
    self.dealTable.backgroundColor = DETAIL_BG_COLOR;
    self.pictureView.backgroundColor = STATUS_BAR_COLOR;
    self.itemTitle.textColor = [UIColor whiteColor];
    self.itemDes.textColor = [UIColor whiteColor];
    
    selectedRow = unselectedRow;
    
    self.itemTitle.font = LATO_REGULAR(14);
    self.itemDes.font = LATO_REGULAR(12);
    
    self.itemTitle.text = @"Restaurants";
    self.itemDes.text = @"store 207";
    
    self.topView.backgroundColor = TOPBAR_BG_COLOR;
    self.titleLbl.font = LATO_REGULAR(18);
    
//    dealsArray=[[NSMutableArray alloc] initWithObjects:@"Deal 1",@"Deal 2",@"Deal 3",@"Deal 4",@"Deal 5",@"Deal 6",nil];
    
    NSArray *keysArray = @[@"discountTitle",@"discountPrice",@"originalPrice",@"percentageSavings",@"companyName",@"Expiration",@"whatsIncluded",@"storeID",@"address",@"city",@"state",@"zip",@"phoneNo",@"imageURL"];
    
    NSArray *valueArray1 = @[@"Half Off Ribs Month",@"10",@"25",@"56%",@"Better Burgers",@"5 Days",@"Come in and get any meal, drink or appetizer half off. Hurry in the offer is only availble for another 5 days.",@"9987553",@"217 Thayer St",@"Bolingbrook",@"RI",@"2906",@"(401) 228-7373",@"Burger.jpg"];
    
    NSArray *valueArray2 = @[@"Cheap Wings",@"2",@"10",@"80%",@"Midwest Motors ",@"3 Days",@"The time is near, Winter is here come on down to Motors and get a Speedy Oil Change. ",@"2231588",@"2553 W Chicago Ave",@"Chicago",@"IL",@"60622",@"(773) 235-6500",@"Mechanic.jpg"];
    
    NSArray *valueArray3 = @[@"Let Us Cater For You",@"150",@"200",@"75%",@"Bent",@"3 Days",@"Simply UNBEATABLE deals on your favorites tanks, tees, jeans and accessories. Deals go live daily, take advantage and shop. ",@"6458887",@"519 N. Milwaukee Avenue(near N. Damen/North Ave.)",@"Chicago",@"IL",@"60622",@"(773) 227-5300",@"store-interior.jpg"];
    
    NSArray *valueArray4 = @[@"A Pig on Every Grill",@"25",@"35",@"28%",@"Resort Spa",@"5 Days ",@"Partake in this opportuntity of a lifetime to dine, relax, and enjoy life. Come down to our fabulous hotel and spa to take a load off.",@"6213479",@"233 S Wacker Dr",@"Chicago",@"IL",@"60606",@"(312) 875-9696",@"beach.jpg"];
    
    NSArray *valueArray5 = @[@"Free Seasoned Fries with Purchase",@"0",@"5",@"100%",@"Slab Of Ribs",@"7 Days",@"Slab of Ribs will be hosting the biggest all you can each barbecue week. If you can eat what \"WE\" put on your plate your meal is on us.",@"2155479",@"1470 East Touhy Avenue",@"Des Planies",@"IL",@"60016",@"(847) 391-9860",@"BBQ.jpg"];
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjects:valueArray1 forKeys:keysArray];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:valueArray2 forKeys:keysArray];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjects:valueArray3 forKeys:keysArray];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjects:valueArray4 forKeys:keysArray];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjects:valueArray5 forKeys:keysArray];
    
    dealsArray = [[NSMutableArray alloc] initWithObjects:dict1,dict2,dict3,dict4,dict5,nil];
    
    [self.dealTable registerNib:[UINib nibWithNibName:@"FavoriteDetailCell" bundle:nil]
         forCellReuseIdentifier:@"FavoriteDetailCell"];
    
    [self.dealTable reloadData];
    
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isFavoriteMode) {
        return [dealsArray count]+1;
    }
    return [dealsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row==[dealsArray count]) {
        
        return 200;
        
    }else {
        
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==[dealsArray count]) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeleteCell"];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setFrame:CGRectMake(0, 60, 320, 44)];
        [deleteBtn setBackgroundColor:RGB(244, 243, 237)];
        [deleteBtn setTitleColor:RGB(224, 0, 7) forState:0];
        [deleteBtn.titleLabel setFont:LATO_REGULAR(16)];
        [deleteBtn setTitle:@"Unfavorite" forState:0];
        
        //deleteBtn.backgroundColor = DETAIL_BG_COLOR;
        
        deleteBtn.userInteractionEnabled=YES;
        deleteBtn.enabled=YES;
        
        [deleteBtn addTarget:self action:@selector(deleteBtnCall) forControlEvents:UIControlEventTouchUpInside];
        
        deleteBtn.layer.borderWidth = 0.5;
        deleteBtn.layer.borderColor = RGB(206, 205, 205).CGColor;
        
        [cell addSubview:deleteBtn];
        
        cell.backgroundColor = DETAIL_BG_COLOR;
        
        return cell;
        
    }else {
        
        FavoriteDetailCell *cell = (FavoriteDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"FavoriteDetailCell"];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        NSDictionary *currentDict=[dealsArray objectAtIndex:indexPath.row];
        
        cell.itemTitleLbl.text = [currentDict objectForKey:@"discountTitle"];
        cell.itemDesLbl.text = [NSString stringWithFormat:@"$%@ for $%@ (%@ off)",[currentDict objectForKey:@"discountPrice"],[currentDict objectForKey:@"originalPrice"],[currentDict objectForKey:@"percentageSavings"]];
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedRow = indexPath.row;
    [self.dealTable reloadData];
    
    if (indexPath.row<[dealsArray count]) {
        
        NSArray *keysArray = @[@"discountTitle",@"discountPrice",@"originalPrice",@"percentageSavings",@"companyName",@"Expiration",@"whatsIncluded",@"storeID",@"address",@"city",@"state",@"zip",@"phoneNo",@"imageURL",@"latitude",@"longitude",@"pinType",@"youtube_link"];
        
        NSArray *valueArray1 = @[@"Half Off Ribs Month",@"10",@"25",@"56%",@"Better Burgers",@"5 Days",@"Come in and get any meal, drink or appetizer half off. Hurry in the offer is only availble for another 5 days.",@"9987553",@"217 Thayer St",@"Bolingbrook",@"RI",@"2906",@"(401) 228-7373",@"Burger.jpg",@"41.6265",@"-87.3650",@"map_pin_hotel.png",@"http://www.youtube.com/v/zL0CCsdS1cE"];
        
        DiscountDetail *discountDetail = [[DiscountDetail alloc] init];
        [discountDetail setCurrentItem:[NSDictionary dictionaryWithObjects:valueArray1 forKeys:keysArray]];
        discountDetail.isSavedDeal=NO;
        discountDetail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:discountDetail animated:YES];
    }
}

- (void) deleteBtnCall {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                    message:[NSString stringWithFormat:@"Are you sure you want to remove %@ from your favorites?",self.itemTitle.text]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes",nil];
    alert.tag=1111;
    [alert show];
}

#pragma mark Alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        if (buttonIndex==1) {
            
            if (alertView.tag==1111) {  //logout
                
                [MY_APP_DELEGATE.discountViewController backButtonTapped:nil];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName
                                                                message:[NSString stringWithFormat:@"%@ has been removed from your favorites",self.itemTitle.text]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}


@end
