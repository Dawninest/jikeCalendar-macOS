//
//  holidaySaverView.m
//  holidaySaver
//
//  Created by bq-mac on 2022/7/18.
//

#import "holidaySaverView.h"

#define jikeY [NSColor colorWithRed:1 green:0.894 blue:0.066 alpha:1.00]
#define ratio 0.618

@interface holidaySaverView()

@property (nonatomic, strong) NSTextField *canDoText;
@property (nonatomic, strong) NSTextField *daliyText;
@property (nonatomic, strong) NSTextField *holidayOne;
@property (nonatomic, strong) NSTextField *holidayTwo;
@property (nonatomic, strong) NSTextField *holidayThree;
@property (nonatomic, strong) NSTextField *holidayFour;


@property (nonatomic, strong) NSView *dateNumText;
@property (nonatomic, strong) NSTextField *dateNum_h;
@property (nonatomic, strong) NSTextField *dateNum_m;
@property (nonatomic, strong) NSTextField *dateNum_s;

@property (nonatomic, strong) NSView *lineOne;
@property (nonatomic, strong) NSView *lineTwo;

@end

@implementation holidaySaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    [self initUI:frame];
    [self getDate];
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    [self updateDate];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void)initUI:(NSRect)rect {
    
    if (rect.size.width < 300 && rect.size.height < 200) {
        
        CGFloat width = rect.size.width;
        CGFloat height = rect.size.height;
        
        NSTextField *tipTitle = [[NSTextField alloc]init];
        tipTitle.frame = CGRectMake(width * 0.05, height * 0.618 + 10, width * 0.9, 30);
        tipTitle.editable = NO;
        tipTitle.bordered = NO;
        tipTitle.drawsBackground = NO;
        tipTitle.font = [NSFont systemFontOfSize:20];
        tipTitle.textColor = jikeY;
        tipTitle.alignment = NSTextAlignmentCenter;
        tipTitle.stringValue = @"假期倒计时Mac屏保";
        [self addSubview:tipTitle];
        
        NSView *tipLine = [[NSView alloc] init];
        tipLine.frame = CGRectMake(width * 0.05, height * 0.618, width * 0.9, 1);
        tipLine.wantsLayer = YES;
        [tipLine.layer setNeedsLayout];
        tipLine.layer.backgroundColor = [jikeY CGColor];
        [self addSubview:tipLine];
        
        NSTextField *tipText = [[NSTextField alloc]init];
        tipText.frame = CGRectMake(width * 0.05, 10, width * 0.9, height * 0.618 - 20);
        tipText.editable = NO;
        tipText.bordered = NO;
        tipText.drawsBackground = NO;
        tipText.font = [NSFont systemFontOfSize:12];
        tipText.textColor = jikeY;
        tipText.alignment = NSTextAlignmentLeft;
        tipText.stringValue = @"注意:请勿点击下面的 '屏幕保护程序选项...' 按钮";
       
        [self addSubview:tipText];
        
    } else {
        
        CGFloat width = rect.size.width;//self.window.screen.frame.size.width;
        CGFloat height = rect.size.height;//self.window.screen.frame.size.height;
        
        CGFloat showWith = width * ratio;
        CGFloat widthPadding = width * (1 - ratio) / 2;
        CGFloat lineHeight = height * (1 - ratio);
        
       
        self.canDoText = [[NSTextField alloc] init];
        self.canDoText.frame = CGRectMake(widthPadding, lineHeight + 280, showWith, 80);
        self.canDoText.editable = NO;
        self.canDoText.bordered = NO;
        self.canDoText.drawsBackground = NO;
        self.canDoText.font = [NSFont systemFontOfSize:60];
        self.canDoText.textColor = jikeY;
        self.canDoText.alignment = NSTextAlignmentCenter;
        [self addSubview: self.canDoText];

        self.daliyText = [[NSTextField alloc] init];
        self.daliyText.frame = CGRectMake(widthPadding, lineHeight + 220, showWith, 50);
        self.daliyText.editable = NO;
        self.daliyText.bordered = NO;
        self.daliyText.drawsBackground = NO;
        self.daliyText.font = [NSFont systemFontOfSize:30];
        self.daliyText.textColor = jikeY;
        self.daliyText.alignment = NSTextAlignmentCenter;
        [self addSubview: self.daliyText];

        self.dateNumText = [[NSView alloc] init];
        self.dateNumText.frame = CGRectMake(widthPadding, lineHeight + 30, showWith, 200);

        CGFloat leftPadding = ( showWith - 840 ) / 2;

        self.dateNum_h = [[NSTextField alloc] init];
        self.dateNum_h.frame = CGRectMake(leftPadding, 0, 240, 200);
        self.dateNum_h.editable = NO;
        self.dateNum_h.bordered = NO;
        self.dateNum_h.drawsBackground = NO;
        self.dateNum_h.font = [NSFont systemFontOfSize:180];
        self.dateNum_h.textColor = jikeY;
        self.dateNum_h.alignment = NSTextAlignmentCenter;
        [self.dateNumText addSubview: self.dateNum_h];

        NSTextField *dateSignOne = [[NSTextField alloc] init];
        dateSignOne.frame = CGRectMake(leftPadding + 240, 0, 60, 200);
        dateSignOne.editable = NO;
        dateSignOne.bordered = NO;
        dateSignOne.drawsBackground = NO;
        dateSignOne.font = [NSFont systemFontOfSize:180];
        dateSignOne.textColor = jikeY;
        dateSignOne.stringValue = @":";
        dateSignOne.alignment = NSTextAlignmentCenter;
        [self.dateNumText addSubview: dateSignOne];

        self.dateNum_m = [[NSTextField alloc] init];
        self.dateNum_m.frame = CGRectMake(leftPadding + 300, 0, 240, 200);
        self.dateNum_m.editable = NO;
        self.dateNum_m.bordered = NO;
        self.dateNum_m.drawsBackground = NO;
        self.dateNum_m.font = [NSFont systemFontOfSize:180];
        self.dateNum_m.textColor = jikeY;
        self.dateNum_m.alignment = NSTextAlignmentCenter;
        [self.dateNumText addSubview: self.dateNum_m];

        NSTextField *dateSignTwo = [[NSTextField alloc] init];
        dateSignTwo.frame = CGRectMake(leftPadding + 540, 0, 60, 200);
        dateSignTwo.editable = NO;
        dateSignTwo.bordered = NO;
        dateSignTwo.drawsBackground = NO;
        dateSignTwo.font = [NSFont systemFontOfSize:180];
        dateSignTwo.textColor = jikeY;
        dateSignTwo.stringValue = @":";
        dateSignTwo.alignment = NSTextAlignmentCenter;
        [self.dateNumText addSubview: dateSignTwo];

        self.dateNum_s = [[NSTextField alloc] init];
        self.dateNum_s.frame = CGRectMake(leftPadding + 600, 0, 240, 200);
        self.dateNum_s.editable = NO;
        self.dateNum_s.bordered = NO;
        self.dateNum_s.drawsBackground = NO;
        self.dateNum_s.font = [NSFont systemFontOfSize:180];
        self.dateNum_s.textColor = jikeY;
        self.dateNum_s.alignment = NSTextAlignmentCenter;
        [self.dateNumText addSubview: self.dateNum_s];

        [self addSubview:self.dateNumText];
        
        self.lineOne = [[NSView alloc] init];
        self.lineOne.frame = CGRectMake(widthPadding, lineHeight + 5, showWith, 4);
        self.lineOne.wantsLayer = YES;
        [self.lineOne.layer setNeedsLayout];
        self.lineOne.layer.backgroundColor = [jikeY CGColor];
        [self addSubview: self.lineOne];

        self.lineTwo = [[NSView alloc] init];
        self.lineTwo.frame = CGRectMake(widthPadding, lineHeight, showWith, 1);
        self.lineTwo.wantsLayer = YES;
        [self.lineTwo.layer setNeedsLayout];
        self.lineTwo.layer.backgroundColor = [jikeY CGColor];
        [self addSubview: self.lineTwo];
        
        self.holidayOne = [[NSTextField alloc] init];
        self.holidayOne.frame = CGRectMake(widthPadding, lineHeight - 50, showWith, 40);
        self.holidayOne.editable = NO;
        self.holidayOne.bordered = NO;
        self.holidayOne.drawsBackground = NO;
        self.holidayOne.font = [NSFont systemFontOfSize:36];
        self.holidayOne.textColor = jikeY;
        self.holidayOne.alignment = NSTextAlignmentCenter;
        [self addSubview: self.holidayOne];
            
        self.holidayTwo = [[NSTextField alloc] init];
        self.holidayTwo.frame = CGRectMake(widthPadding, lineHeight - 90, showWith, 40);
        self.holidayTwo.editable = NO;
        self.holidayTwo.bordered = NO;
        self.holidayTwo.drawsBackground = NO;
        self.holidayTwo.font = [NSFont systemFontOfSize:36];
        self.holidayTwo.textColor = jikeY;
        self.holidayTwo.alignment = NSTextAlignmentCenter;
        [self addSubview: self.holidayTwo];
        
        self.holidayThree = [[NSTextField alloc] init];
        self.holidayThree.frame = CGRectMake(widthPadding, lineHeight - 130, showWith, 40);
        self.holidayThree.editable = NO;
        self.holidayThree.bordered = NO;
        self.holidayThree.drawsBackground = NO;
        self.holidayThree.font = [NSFont systemFontOfSize:36];
        self.holidayThree.textColor = jikeY;
        self.holidayThree.alignment = NSTextAlignmentCenter;
        [self addSubview: self.holidayThree];
        
        self.holidayFour = [[NSTextField alloc] init];
        self.holidayFour.frame = CGRectMake(widthPadding, lineHeight - 170, showWith, 40);
        self.holidayFour.editable = NO;
        self.holidayFour.bordered = NO;
        self.holidayFour.drawsBackground = NO;
        self.holidayFour.font = [NSFont systemFontOfSize:36];
        self.holidayFour.textColor = jikeY;
        self.holidayFour.alignment = NSTextAlignmentCenter;
        [self addSubview: self.holidayFour];
        
        
    }
}

- (void)getDate {
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/Dawninest/DataSave/main/save.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString *workTime =  dict[@"workTime"];
            NSArray *holidayList = dict[@"data"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.canDoText.stringValue = workTime;
                    int dataCount = [holidayList count];
                    if (dataCount >= 1) {
                        self.holidayOne.stringValue = [NSString stringWithFormat:@"%@ | %@天假期 | 还有%@天",holidayList[0][@"name"], holidayList[0][@"length"],holidayList[0][@"fromNow"]];
                    }
                    if (dataCount >= 2) {
                        self.holidayTwo.stringValue = [NSString stringWithFormat:@"%@ | %@天假期 | 还有%@天",holidayList[1][@"name"], holidayList[1][@"length"],holidayList[1][@"fromNow"]];
                    }
                    if (dataCount >= 3) {
                        self.holidayThree.stringValue = [NSString stringWithFormat:@"%@ | %@天假期 | 还有%@天",holidayList[2][@"name"], holidayList[2][@"length"],holidayList[2][@"fromNow"]];
                    }
                    if (dataCount >= 4) {
                        self.holidayFour.stringValue = [NSString stringWithFormat:@"%@ | %@天假期 | 还有%@天",holidayList[3][@"name"], holidayList[3][@"length"],holidayList[3][@"fromNow"]];
                    }
            });
        } else {
            NSLog(@"%@",error);
        }
    }];
    [dataTask resume];
}

- (void)updateDate {
    NSArray *weekArr = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSDate *now = [[NSDate alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSString *monthStr = [self timeAddZero:month];
    NSInteger day = [dateComponent day];
    NSString *dayStr = [self timeAddZero:day];
    NSInteger week = [dateComponent weekday];
    NSString *weekStr = weekArr[week - 1];
    NSString *showDaliy = [NSString stringWithFormat:@"%ld 年 %@ 月 %@ 日 %@",(long)year,monthStr,dayStr,weekStr];
    self.daliyText.stringValue = showDaliy;
    
    NSInteger hour = [dateComponent hour];
    NSString *hourStr = [self timeAddZero:hour];
    NSInteger minute = [dateComponent minute];
    NSString *minuteStr = [self timeAddZero:minute];
    NSInteger second = [dateComponent second];
    NSString *secondStr = [self timeAddZero:second];
    
    self.dateNum_h.stringValue = hourStr;
    self.dateNum_m.stringValue = minuteStr;
    self.dateNum_s.stringValue = secondStr;
    
}

- (NSString*) timeAddZero:(NSInteger) timeNum {
    if (timeNum >= 10) {
        return [NSString stringWithFormat: @"%ld", (long)timeNum];
    } else {
        return [NSString stringWithFormat: @"0%ld", (long)timeNum];
    }
}



@end
