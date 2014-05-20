//
//  WalletScore.m
//  Discount
//
//  Created by Sajith KG on 02/04/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "WalletScore.h"

@interface WalletScore () {

    IBOutlet UIView *topbarView,*segmentView,*dayView,*weekView,*monthView;
    IBOutlet UILabel *titleLbl;
    IBOutlet UISegmentedControl *segmentControl;
    
    IBOutlet UILabel *scoreHdrLbl;
    IBOutlet UICountingLabel *scoreValueLbl;
    IBOutlet UIView *scoreBarHolder,*scoreBarValue;
    
    IBOutlet UILabel *messageLbl1,*messageLbl2;
    IBOutlet UIButton *morePointsBtn;
    
    IBOutlet UIView *barChartView,*barTextView;
    IBOutlet UILabel *barRedeemCount,*barRedeemHdr;
    IBOutlet UILabel *period,*savingsAmount,*savingsHdr;
    IBOutlet UIView *amountView;
    
    IBOutlet BarChartView *barChart;
    
    UIColor *lightBlueColor,*mediumBlueColor;
    UIColor *labelColor;
    
    float scoreValue,redeemedDis,totalDis;
}

@end

@implementation WalletScore

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
-(IBAction) backBtnCall {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    topbarView.backgroundColor = TOPBAR_BG_COLOR;
    segmentView.backgroundColor = TOPBAR_BG_COLOR;
    titleLbl.font = LATO_REGULAR(18);
    segmentControl.tintColor=[UIColor whiteColor];
    
    lightBlueColor =RGB(100, 198, 243);
    mediumBlueColor =RGB(28, 158, 228);
    labelColor = RGB(62, 62, 62);
    
    scoreHdrLbl.font = LATO_REGULAR(23);
    scoreHdrLbl.textColor = RGB(31, 31, 31);
    
    scoreValueLbl.font = LATO_REGULAR(23);
    scoreValueLbl.textColor = STATUS_BAR_COLOR;
    
    scoreBarHolder.backgroundColor = STATUS_BAR_COLOR;
    scoreBarValue.backgroundColor =lightBlueColor;
    
    messageLbl1.font = LATO_REGULAR(18);
    messageLbl1.textColor = RGB(31, 31, 31);
    
    messageLbl2.font = LATO_REGULAR(11);
    messageLbl2.textColor = RGB(81, 81, 81);
    
    barRedeemCount.font = LATO_REGULAR(16);
    
    barRedeemHdr.font = LATO_REGULAR(8);
    barRedeemHdr.textColor = RGB(101, 101, 101);
    
    period.font = LATO_REGULAR(11);
    period.textColor = STATUS_BAR_COLOR;
    
    savingsAmount.font = LATO_BOLD(16);
    
    savingsHdr.font = LATO_REGULAR(10);
    
    messageLbl1.text=@"You saved $68.42 this week!";
    messageLbl2.text=@"Keep it up! You were able to earn 250 points this week!";
    
    scoreValueLbl.text=@"0";
    
    [morePointsBtn setTitleColor:RGB(42, 135, 191) forState:0];
    [morePointsBtn setTitle:@"Want to earn more points?" forState:0];
    morePointsBtn.titleLabel.font = LATO_REGULAR(11);
    
    barChartView.backgroundColor= RGB(235, 235, 241);
    
    CALayer *layer = [CALayer layer];
    layer.borderColor = [UIColor grayColor].CGColor;
    layer.borderWidth = 1.0;
    layer.frame = CGRectMake(0, 0, barChartView.frame.size.width, 1);
    [barChartView.layer addSublayer:layer];
    
    CALayer *layer1 = [CALayer layer];
    layer1.borderColor = [UIColor grayColor].CGColor;
    layer1.borderWidth = 0.5;
    layer1.frame = CGRectMake(60, 7, 0.5, 26);
    [amountView.layer addSublayer:layer1];
    
    [[UISegmentedControl appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                              LATO_REGULAR(13),NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [dayView setFrame:CGRectMake(dayView.frame.origin.x, 100, dayView.frame.size.width, dayView.frame.size.height)];
    [self.view addSubview:dayView];
    
    [weekView setFrame:CGRectMake(weekView.frame.origin.x, 100, weekView.frame.size.width, weekView.frame.size.height)];
    [self.view addSubview:weekView];
    
    [monthView setFrame:CGRectMake(monthView.frame.origin.x, 100, monthView.frame.size.width, monthView.frame.size.height)];
    [self.view addSubview:monthView];
    
    weekView.backgroundColor = RGB(211, 211, 211);
    
    segmentControl.selectedSegmentIndex=1;
    
    [scoreBarValue setFrame:CGRectMake(2, 2, 0, 20)];
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    [_slices addObject:[NSNumber numberWithInt:80]];
    [_slices addObject:[NSNumber numberWithInt:20]];
    
    self.pieChart.backgroundColor=[UIColor clearColor];
    barChart.backgroundColor = [UIColor clearColor];
    barChart.userInteractionEnabled=NO;
    
    [self.pieChart setDataSource:self];
    [self.pieChart setAnimationSpeed:1.3];
    [self.pieChart setShowLabel:NO];
    [self.pieChart setShowPercentage:YES];
    [self.pieChart setPieBackgroundColor:lightBlueColor];
    [self.pieChart setPieCenter:CGPointMake(38.5, 38.5)];
    [self.pieChart setUserInteractionEnabled:NO];
    [self.pieChart setLabelShadowColor:[UIColor blackColor]];
    [self.pieChart setPieRadius:38.5];
    
    [barTextView.layer setCornerRadius:31.5];
    
    self.sliceColors =[NSArray arrayWithObjects:STATUS_BAR_COLOR,
                       lightBlueColor,nil];
    
    [self loadBarChartUsingZeroArray];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChart reloadData];
    
    [scoreBarValue setFrame:CGRectMake(2, 2, 0, 20)];
    
    float totalValue = 5000.0;
    float currentValue = 3217.0;
    
    float barMaxWidth = 286.0;
    
    float barWidth = (currentValue/totalValue)*barMaxWidth;
    
    [UIView animateWithDuration:1.3f
                     animations:^{
                         [scoreBarValue setFrame:CGRectMake(2, 2, barWidth, 20)];
                     }
                     completion:^(BOOL finished){
                         NSLog( @"woo! Finished animating the frame of myView!" );
                     }];
    
   
    scoreValueLbl.method = UILabelCountingMethodLinear;
    scoreValueLbl.format = @"%d";
    [scoreValueLbl countFrom:1 to:currentValue withDuration:1.3];
    
    [self loadBarChartUsingArray];
    [barChart animateBars];
}

#pragma mark - Bar Chart Data Source

- (void)loadBarChartUsingZeroArray {
    
    NSArray *array = [barChart createChartDataWithTitles:[NSArray arrayWithObjects:@"M", @"T", @"W", @"TH",@"F", @"S", @"S", nil]
                                                  values:[NSArray arrayWithObjects:@"0", @"0", @"0", @"0",@"0", @"0", @"0",nil]
                                                  colors:[NSArray arrayWithObjects:STATUS_BAR_COLOR, mediumBlueColor, lightBlueColor, STATUS_BAR_COLOR,mediumBlueColor, lightBlueColor, STATUS_BAR_COLOR,nil]
                                             labelColors:[NSArray arrayWithObjects:labelColor, labelColor, labelColor, labelColor, labelColor, labelColor, labelColor,nil]];
    
    //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
    [barChart setupBarViewShape:BarShapeSquared];
    
    //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
    [barChart setupBarViewStyle:BarStyleFlat];
    
    //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
    [barChart setupBarViewShadow:BarShadowNone];
    
    //Generate the bar chart using the formatted data
    [barChart setDataWithArray:array
                      showAxis:DisplayOnlyXAxis
                     withColor:[UIColor clearColor]
       shouldPlotVerticalLines:NO];
}

- (void)loadBarChartUsingArray {

    NSArray *array = [barChart createChartDataWithTitles:[NSArray arrayWithObjects:@"M", @"T", @"W", @"TH",@"F", @"S", @"S", nil]
                                                  values:[NSArray arrayWithObjects:@"160", @"80", @"50", @"70",@"50", @"10", @"150",nil]
                                                  colors:[NSArray arrayWithObjects:STATUS_BAR_COLOR, mediumBlueColor, lightBlueColor, STATUS_BAR_COLOR,mediumBlueColor, lightBlueColor, STATUS_BAR_COLOR,nil]
                                             labelColors:[NSArray arrayWithObjects:labelColor, labelColor, labelColor, labelColor, labelColor, labelColor, labelColor,nil]];
    
    //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
    [barChart setupBarViewShape:BarShapeSquared];
    
    //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
    [barChart setupBarViewStyle:BarStyleFlat];
    
    //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
    [barChart setupBarViewShadow:BarShadowNone];
    
    //Generate the bar chart using the formatted data
    [barChart setDataWithArray:array
                      showAxis:DisplayOnlyXAxis
                     withColor:[UIColor clearColor]
       shouldPlotVerticalLines:NO];
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}


#pragma mark -
#pragma mark  Segment

-(IBAction) segmentControlValueChanged:(id)sender {
    
    UIView *selectedView;
    
    switch ([segmentControl selectedSegmentIndex]) {
        case 0:
            selectedView = dayView;
            break;
            
        case 1:
            selectedView = weekView;
            break;
            
        case 2:
            selectedView = monthView;
            break;
            
        default:
            break;
    }
    
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.3];
    dayView.alpha = 0.0;
    weekView.alpha = 0.0;
    monthView.alpha = 0.0;
    selectedView.alpha = 1.0;
    [UIView commitAnimations];
}

@end
