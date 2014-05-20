//
//  MyRating.m
//  Discount
//
//  Created by Sajith KG on 24/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "About.h"
#import "ProfileCell.h"
#import "WebController.h"

@interface About (){
    
    NSArray *itemsArray;
}

@end

@implementation About

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
    self.viewHdr.font = LATO_REGULAR(18);
    
    self.myTable.backgroundColor = DETAIL_BG_COLOR;
    
    self.viewHdr.font = LATO_REGULAR(18);
    
    itemsArray = [[NSArray alloc] initWithObjects:@"Version",@"Privacy policy ",@"Terms and conditions",@"Mobile terms and conditions",nil];
    
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
    
    if (indexPath.row==0) {
        cell.arrowImg.hidden=YES;
        UILabel *versionLbl = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 80, 40)];
        versionLbl.textAlignment = NSTextAlignmentRight;
        versionLbl.backgroundColor = [UIColor clearColor];
        versionLbl.font = LATO_BOLD(16);
        versionLbl.textColor = [UIColor lightGrayColor];
        versionLbl.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        [cell.contentView addSubview:versionLbl];
    }
    
    cell.itemTitleLbl.text = [itemsArray objectAtIndex:indexPath.row];

    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        return;
    }
    
    WebController *help = [[WebController alloc] init];
    help.titleStr = [itemsArray objectAtIndex:indexPath.row];
    
    switch (indexPath.row) {

        case 1:
            help.webPageType = kPrivacyPolicy;
            break;
            
        case 2:
             help.webPageType = kTerms;
            break;
            
        case 3:
             help.webPageType = kMobileTerms;
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:help animated:YES];
}

@end
