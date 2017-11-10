//
//  CallCarTimeChooseVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallCarTimeChooseVC.h"

@interface CallCarTimeChooseVC ()
/**
 *天
 */
@property (nonatomic, strong)NSArray *dayArray;
/**
 *时
 */
@property (nonatomic, strong)NSArray *hourArray;
/**
 *分
 */
@property (nonatomic, strong)NSArray *minuteArray;
@end

@interface CallCarTimeChooseVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *FPickerView;

@property (nonatomic, strong)NSString *dayStr;
@property (nonatomic, strong)NSString *hourStr;
@property (nonatomic, strong)NSString *minuteStr;
@end

@implementation CallCarTimeChooseVC

- (NSArray*)dayArray {
    if (!_dayArray) {
        _dayArray = @[@"今天", @"明天", @"后天"];
    }
    return _dayArray;
}
- (NSArray *)hourArray {
    if (!_hourArray) {
        _hourArray = @[@"00",@"01", @"02", @"03",@"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"];
    }
    return _hourArray;
}
- (NSArray *)minuteArray {
    if (!_minuteArray) {
        _minuteArray = @[@"00", @"10", @"20", @"30", @"40", @"50"];
    }
    return _minuteArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dayStr = @"今天";
        self.hourStr = @"00";
        self.minuteStr = @"00";
        self.backgroundColor = [UIColor whiteColor];
        UIButton *completionBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [completionBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        completionBtn.tag = 131;
        [completionBtn addTarget:self action:@selector(handledetermineBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:completionBtn];
        completionBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(kFit(54)).heightIs(kFit(39));
        
        UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        cancelBtn.tag = 132;
        [cancelBtn addTarget:self action:@selector(handledetermineBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];
        cancelBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(kFit(54)).heightIs(kFit(39));
        
        self.FPickerView = [UIPickerView new];
        _FPickerView.delegate = self;
        _FPickerView.dataSource = self;
        _FPickerView.backgroundColor = MColor(238, 238, 238);
        _FPickerView.showsSelectionIndicator = YES;
        [self addSubview:_FPickerView];
        _FPickerView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(completionBtn,0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.dayArray.count;
    }else if (component == 1){
        return self.hourArray.count;
    }else {
        return self.minuteArray.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return _dayArray[row];
    }else if (component == 1) {
        return _hourArray[row];
    }else {
        return _minuteArray[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.dayStr = _dayArray[row];
    }
    if (component == 1) {
        self.hourStr = _hourArray[row];
    }
    if (component == 2) {
        self.minuteStr = _minuteArray[row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:MColor(238, 238, 238)];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:kFit(18)]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//btn点击事件
- (void)handledetermineBtn:(UIButton *)sender {
    
    if (sender.tag == 132) {
        if ([_delegate respondsToSelector:@selector(deselect)]) {
            [_delegate deselect];
        }
    }
    if (sender.tag == 131) {
        if ([_delegate respondsToSelector:@selector(ChooseCallCarTime:)]) {
            int day = 0;
            if ([_dayStr isEqualToString:@"今天"]) {
                day = 0;
            }
            if ([_dayStr isEqualToString:@"明天"]) {
                day = 1;
            }
            if ([_dayStr isEqualToString:@"后天"]) {
                day = 2;
            }
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60*day sinceDate:currentDate];//后一天
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];//@"YYYY-MM-dd hh:mm"
            NSString *dateString = [dateFormatter stringFromDate:nextDay];
            NSLog(@"dateString:%@ %@:%@",dateString, _hourStr, _minuteStr);
            NSString *timeStr = [NSString stringWithFormat:@"%@ %@:%@", dateString, _hourStr, _minuteStr];
            [_delegate ChooseCallCarTime:timeStr];
            
        }
    }
}



@end
