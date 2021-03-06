//
//  ViewController.m
//  JSWheelView
//
//  Created by JoAmS on 2015. 4. 1..
//  Copyright (c) 2015년 jooam. All rights reserved.
//

#import "ViewController.h"
#import "JSWheelView.h"

@interface ViewController () <JSWheelViewDataSource, JSWheelViewDelegate>
{
    JSWheelView* _wheelView;
    NSMutableDictionary* _datas;
    
    UILabel* _informationLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatas];
    [self setupWheelView];
    [self setupInformationLabel];
}

- (void)setupDatas
{
    _datas = [NSMutableDictionary new];
    [_datas setObject:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17"] forKey:@"Section 1"];
    [_datas setObject:@[@"0", @"1", @"2", @"3"] forKey:@"Section 2"];
    [_datas setObject:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35"] forKey:@"Section 3"];
    [_datas setObject:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"] forKey:@"Section 4"];
    [_datas setObject:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"] forKey:@"Section 5"];
}

- (void)setupWheelView
{
    _wheelView = [[JSWheelView alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.height-100)];
    [_wheelView setAutoresizesSubviews:YES];
    [_wheelView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_wheelView setShowSectionAndRow:YES];
    [_wheelView setDataSource:self];
    [_wheelView setDelegate:self];
    [self.view addSubview:_wheelView];
}

- (void)setupInformationLabel
{
    _informationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _wheelView.frame.origin.y+_wheelView.frame.size.height, self.view.bounds.size.width, 80)];
    [_informationLabel setFont:[UIFont systemFontOfSize:20]];
    [_informationLabel setTextAlignment:NSTextAlignmentCenter];
    [_informationLabel setNumberOfLines:0];
    [self.view addSubview:_informationLabel];
}

#pragma mark - JSWheelViewDataSource
- (NSInteger)numberOfSectionsInWheelView:(JSWheelView *)wheelView
{
    return [[_datas allKeys] count];
}

- (NSString *)wheelView:(JSWheelView *)wheelView titleForSection:(NSInteger)section
{
    NSString* key = [[_datas allKeys] objectAtIndex:section];
    return key;
}

- (NSInteger)wheelView:(JSWheelView *)wheelView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = [[_datas allKeys] objectAtIndex:section];
    return [[_datas objectForKey:key] count];
}

- (id)wheelView:(JSWheelView *)wheelView dataForWheelIndexPath:(NSIndexPath *)indexPath
{
    NSString* key = [[_datas allKeys] objectAtIndex:indexPath.section];
    return [[_datas objectForKey:key] objectAtIndex:indexPath.row];
}

- (NSIndexPath*)indexPathForAfterLoad:(JSWheelView*)wheelView
{
    int section = 0;
    int row = 0;
    [_informationLabel setText:[NSString stringWithFormat:@"section : %d \nrow : %d \ndata : %@", section, row, @""]];
    return [NSIndexPath indexPathForRow:row inSection:section];
}

#pragma mark - JSWheelViewDelegate
- (void)wheelView:(JSWheelView*)wheelView didSelectDataWithIndexPath:(NSIndexPath*)indexPath withData:(id)data
{
    [_informationLabel setText:[NSString stringWithFormat:@"section : %d \nrow : %d \ndata : %@", indexPath.section, indexPath.row, data]];
}

- (void)wheelViewDidTrackingStart:(JSWheelView*)wheelView
{
    NSLog(@"Start Tracking!!!");
}

- (void)wheelViewDidTrackingEnd:(JSWheelView*)wheelView
{
    NSLog(@"End Tracking!!!");
}

@end
