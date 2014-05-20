//
//  Preferences.m
//  Discount
//
//  Created by Sajith KG on 05/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "Preferences.h"
#import "ProfileCell.h"
#import "PushEmailPref.h"

@interface Preferences (){
    
    NSMutableArray *itemsArray;
}

@end

@implementation Preferences

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
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.myTable.backgroundColor = DETAIL_BG_COLOR;
    
    self.viewHdr.font = LATO_REGULAR(18);
    
    itemsArray = [[NSMutableArray alloc] initWithObjects:@"Push Notification Settings",@"Email Alert Settings",nil];
    
    [self.myTable registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil]
       forCellReuseIdentifier:@"ProfileCell"];
    
    [self.myTable reloadData];
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCell *cell = (ProfileCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.itemTitleLbl.textColor = [UIColor whiteColor];
    cell.arrowImg.hidden=NO;
    cell.itemTitleLbl.text = [itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PushEmailPref *pushEmailPref = [[PushEmailPref alloc] init];
    
    switch (indexPath.row) {
        case 0:
            [pushEmailPref setPushMode:YES];
            break;
            
        case 1:
            [pushEmailPref setPushMode:NO];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:pushEmailPref animated:YES];
}



@end
