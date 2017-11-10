
//
//  CitySelectionView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "CitySelectionView.h"

@interface CitySelectionView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, copy) NSString *province; // 省份
@property (nonatomic, copy) NSString *city;  // 城市
@property (nonatomic, copy) NSString *area;  // 地区

@property (nonatomic, strong) NSMutableArray *provinces;
@property (nonatomic, strong) NSMutableArray *cityArray;    // 城市数据
@property (nonatomic, strong) NSMutableArray *areaArray;    // 区信息
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation CitySelectionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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

        self.pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = MColor(238, 238, 238);
        _pickerView.showsSelectionIndicator = YES;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:path];
        [provinceArray enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.provinces addObject:obj[@"state"]];
        }];
        NSMutableArray *citys = [NSMutableArray arrayWithArray:[provinceArray firstObject][@"cities"]];
        [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityArray addObject:obj[@"city"]];
        }];
        self.areaArray = [NSMutableArray arrayWithArray:[citys firstObject][@"areas"]];
        
        [self addSubview:_pickerView];
        _pickerView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(completionBtn, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}

// returns the # of rows in each component..
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
    
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces.count;
    }else if (component == 1) {
        return self.cityArray.count;
    }else{
        return self.areaArray.count;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:path];
    if (component == 0) {
        self.selectedArray = provinceArray[row][@"cities"];
        [self.cityArray removeAllObjects];
        //NSLog(@"%@",   self.selectedArray);
        [self.selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityArray addObject:obj[@"city"]];
        }];
        self.areaArray = [NSMutableArray arrayWithArray:[self.selectedArray firstObject][@"areas"]];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1) {
        if (self.selectedArray.count == 0) {
            self.selectedArray = [provinceArray firstObject][@"cities"];
            
        }
        self.areaArray = [NSMutableArray arrayWithArray:[self.selectedArray objectAtIndex:row][@"areas"]];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else{
        
        
    }
    NSInteger index = [_pickerView selectedRowInComponent:0];
    NSInteger index1 = [_pickerView selectedRowInComponent:1];
    NSInteger index2 = [_pickerView selectedRowInComponent:2];
    self.province = self.provinces[index];
    self.city = self.cityArray[index1];
    if (self.areaArray.count != 0) {
        self.area = self.areaArray[index2];
    }else{
        self.area = @"";
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.provinces[row];
    }else if (component == 1){
        return self.cityArray[row];
    }else{
        if (self.areaArray.count != 0) {
            return self.areaArray[row];
        }else{
            return nil;
        }
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

    if ([_delegate respondsToSelector:@selector(CitySelectionConfirmOrCancel:cityName:regionName:)]) {
        [_delegate CitySelectionConfirmOrCancel:sender cityName:self.province regionName:[NSString stringWithFormat:@"%@%@", self.city, self.area]];
    }
    

}

- (NSMutableArray *)provinces{
    if (!_provinces) {
        self.provinces = [@[] mutableCopy];
    }
    return _provinces;
}

- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        self.cityArray = [@[] mutableCopy];
    }
    return _cityArray;
}
- (NSMutableArray *)areaArray{
    if (!_areaArray) {
        self.areaArray = [@[] mutableCopy];
    }
    return _areaArray;
}
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        self.selectedArray = [@[] mutableCopy];
    }
    return _selectedArray;
}

@end
