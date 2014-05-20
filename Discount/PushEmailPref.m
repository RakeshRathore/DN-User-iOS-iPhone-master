//
//  PushEmailPref.m
//  Discount
//
//  Created by Boopathi on 07/05/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "PushEmailPref.h"
#import "SocialMediaCell.h"
#import "AppDelegate.h"

@interface PushEmailPref () {

    IBOutlet UIView *topbarView;
    IBOutlet UITableView *myTable;
    IBOutlet UILabel *viewHdr;
    
    NSMutableArray *itemsArray;
}

@end

@implementation PushEmailPref

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

-(IBAction)backBtnCall:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = VIEW_BG_COLOR;
    topbarView.backgroundColor = TOPBAR_BG_COLOR;
    myTable.backgroundColor = DETAIL_BG_COLOR;
    viewHdr.font = LATO_REGULAR(18);
    
    itemsArray = [[NSMutableArray alloc] initWithArray:@[@"New discount from favorite business",@"New discount Dibb'd business",@"Change in discount dibb'd",@"WalletScore update",@"Discount expiration alert",@"Friend dibs shared discount",@"Featured discount of the day"]];
    
    if (self.isPushMode) {
        viewHdr.text = @"Push Notification Settings";
        
    }else {
        viewHdr.text = @"Email Alert Settings";
       
    }
    
    [myTable registerNib:[UINib nibWithNibName:@"SocialMediaCell" bundle:nil]
       forCellReuseIdentifier:@"SocialMediaCell"];
    
    [myTable reloadData];
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SocialMediaCell *cell = (SocialMediaCell *)[tableView dequeueReusableCellWithIdentifier:@"SocialMediaCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.socialSwitch.tag = indexPath.row;
    [cell.socialSwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    
    cell.lineImg.hidden=NO;
    cell.iconImg.hidden=YES;
    
    cell.lineImg.frame = CGRectMake(0, cell.frame.size.height-1, 320, 1);
    
    [cell enableCell:YES];
    [cell.itemTitleLbl setFrame:CGRectMake(10, 10, 250, cell.itemTitleLbl.frame.size.height)];
    
    cell.itemTitleLbl.text = [itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) switchToggled:(id)sender {
    
    UISwitch *mySwitch = (UISwitch *)sender;
    mySwitch.selected = !mySwitch.isSelected;
}



@end
