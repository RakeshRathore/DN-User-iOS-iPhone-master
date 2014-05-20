//
//  WalletScore.h
//  Discount
//
//  Created by Sajith KG on 02/04/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "UICountingLabel.h"
#import "BarChartView.h"

@interface WalletScore : UIViewController <XYPieChartDelegate, XYPieChartDataSource>

@property (strong, nonatomic) IBOutlet XYPieChart *pieChart;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;


@end
