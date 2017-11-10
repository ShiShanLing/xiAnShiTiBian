//
//  OrderTimeChooseView.m
//  timeSelectorView
//
//  Created by 石山岭 on 2017/1/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderTimeChooseView.h"
#import "UIView+SDAutoLayout.h" //第三方布局
#define kIphone6Width 375.0
#define kFit(x) (SScreen_Width*((x)/kIphone6Width))
#define SScreen_Width [UIScreen mainScreen].bounds.size.width
#define MColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0f]
@interface OrderTimeChooseView ()<UIPickerViewDelegate, UIPickerViewDataSource, UIPickerViewAccessibilityDelegate>

@property (nonatomic, strong)UIPickerView *customPicker;

@end

@implementation OrderTimeChooseView{
    
    NSMutableArray *yearArray;//存储从开店时间年到现在一共有多少年
    
    NSMutableArray *startMonthArray;//存储开始的月数
    NSMutableArray *monthMutableArray;//存储当前(结束)月数
    
    NSMutableArray *startDayMutableArray;//存储开始的天数
    NSMutableArray *DaysMutableArray;//存储当前(结束)天数
    
    NSArray *monthArray;//存储一年有多少月
    NSMutableArray *DaysArray;//存储一个月有多少天
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m ;
    int year;
    int month;
    int day;
    
    NSString *chooseYearStr;
    NSString *chooseMonthStr;
    NSString *chooseDayStr;
    
}


-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
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

        self.customPicker = [UIPickerView new];
        _customPicker.delegate = self;
        _customPicker.dataSource = self;
        _customPicker.backgroundColor = MColor(238, 238, 238);
        _customPicker.showsSelectionIndicator = YES;
        [self addSubview:_customPicker];
        _customPicker.sd_layout.leftSpaceToView(self, 0).topSpaceToView(completionBtn,0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
        firstTimeLoad = YES;
        NSDate *date = [NSDate date];
        // 获取当前年
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSLog(@"-----%@", formatter);
        [formatter setDateFormat:@"yyyy"];
        NSString *currentyearString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        year =[currentyearString intValue];
        // 获取当前月
        [formatter setDateFormat:@"MM"];
        currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
        month=[currentMonthString intValue];
        // 获取当前日
        [formatter setDateFormat:@"dd"];
        NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        day =[currentDateString intValue];
        yearArray = [[NSMutableArray alloc]init];
        monthMutableArray = [[NSMutableArray alloc]init];
        DaysMutableArray= [[NSMutableArray alloc]init];
        startMonthArray =[[NSMutableArray alloc]init];
        startDayMutableArray =[[NSMutableArray alloc]init];
        for (int i = 2005; i <= year ; i++){
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        // PickerView -  Months data
        monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
        
        
        for (int i = 5; i <13; i ++) {
            [startMonthArray addObject:[NSString stringWithFormat:@"%d", i]];//存储开始的那一年月份
        }
        NSLog(@"startMonthArray%@", startMonthArray);
        
        for (int i=1; i<month+1; i++) {
            [monthMutableArray addObject:[NSString stringWithFormat:@"%d",i]];//存储当前年的月数
        }
        
        DaysArray = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 31; i++){
            [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        for (int i = 15;i < 31 ; i ++) {
            [startDayMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        NSLog(@"startDayMutableArray%@", startDayMutableArray);
        for (int i = 1; i <day+1; i++){
            [DaysMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        // PickerView - Default Selection as per current Date
        // 设置初始默认值
        [self.customPicker selectRow:20 inComponent:0 animated:YES];
        // [pickerView selectRow:30 inComponent:0 animated:NO];
        [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
        [self.customPicker selectRow:0 inComponent:2 animated:YES];

        
        
    }
    return self;
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    m=row;
    if (component == 0){
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }else if (component == 1){
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }else if (component == 2){
        selectedDayRow = row;
        
        [self.customPicker reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    NSInteger selectRow =  [pickerView selectedRowInComponent:0];//获取是第几个第一排的第几个选择器
    int n;
    n= year-2005;
    NSInteger selectRow1 =  [pickerView selectedRowInComponent:1];//获取第二排的第几个选择器
    //  NSLog(@"选择视图赋值%ld------%d", selectRow, n);
    
    
    // Custom View created for each component
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:MColor(238, 238, 238)];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:kFit(18)]];
    }
    if (component == 0){
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1){
        if (selectRow == 0) {//如果是开店月份
            pickerLabel.text =  [startMonthArray objectAtIndex:row];
        }else {//否者
            pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
        }
    }
    else if (component == 2){
        if (selectRow == 0 && selectRow1 == 0) {//如果是看日期
            pickerLabel.text =  [startDayMutableArray objectAtIndex:row];
        }else {
            pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        }
    }
    return pickerLabel;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
         // chooseMonthStr =
    
    if (component == 0){
        NSInteger yearRow =  [pickerView selectedRowInComponent:0];
        NSLog(@"component == 0选择视图赋值------%ld", yearRow);
        chooseYearStr = [NSString stringWithFormat:@"%ld", 2005 + yearRow];
        return [yearArray count];
    }else if (component == 1){
        NSInteger monthRow =  [pickerView selectedRowInComponent:1];
        NSInteger yearRow =  [pickerView selectedRowInComponent:0];
        NSLog(@"component == 1选择视图赋值------年%ld----月%ld", yearRow, monthRow);
        int n;
        n= year-2005;
        if (yearRow==n) {
            chooseMonthStr = [NSString stringWithFormat:@"%@", monthMutableArray[monthRow]];
            return [monthMutableArray count];
        }else if(yearRow == 0){
            chooseMonthStr = [NSString stringWithFormat:@"%@", startMonthArray[monthRow]];
            return [startMonthArray count];
        }else{
            chooseMonthStr = [NSString stringWithFormat:@"%@", monthArray[monthRow]];
            return [monthArray count];
        }
    }else{
        int n;
        n= year-2005;
        NSInteger yearRow =  [pickerView selectedRowInComponent:0];
        NSInteger selectRow =  [pickerView selectedRowInComponent:1];
        NSInteger dayRow =  [pickerView selectedRowInComponent:2];
        NSLog(@"component == 2选择视图赋值------年%ld----月%ld----日%ld", yearRow, selectRow, dayRow);
        if (selectRow== month-1 &yearRow==n) {
            chooseDayStr = [NSString stringWithFormat:@"%ld",dayRow+1];
            return day;
        }else if (yearRow == 0 && selectRow == 0){
            chooseDayStr = [NSString stringWithFormat:@"%@", startDayMutableArray[dayRow]];
            return [startDayMutableArray count];
        }else{
            chooseDayStr = [NSString stringWithFormat:@"%@",DaysArray[dayRow]];
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11){
                return 31;
            }else if (selectedMonthRow == 1){
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }else{
                    return 28; // or return 29
                }
            }else {
                return 30;
            }
        }
    }
}

#pragma mark - UITextFieldDelegate



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return  YES;
    
}


//btn点击事件
- (void)handledetermineBtn:(UIButton *)sender {


    NSLog(@"%@---%@----%@",chooseYearStr,chooseMonthStr,chooseDayStr);
    
    if (sender.tag == 132) {
        if ([_delegate respondsToSelector:@selector(deselect)]) {
            [_delegate deselect];
        }
    }
    
    if (sender.tag == 131) {
        if ([_delegate respondsToSelector:@selector(ChooseOrderTime:)]) {
            NSString *timeStr = [NSString stringWithFormat:@"%@-%@-%@",chooseYearStr,chooseMonthStr,chooseDayStr];
            [_delegate ChooseOrderTime:timeStr];
            
        }
    }
}


@end
