//
//  DatePickerViewController.h
//  AlphaProTracker
//
//  Created by user on 25/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerProtocol <NSObject>

@required
-(void)selectedDate:(NSString *)Date;

@end

@interface DatePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *DatePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong,readwrite) NSString* datePickerFormat;
@property (strong,readwrite) NSString* datePickerStyle;
@property (strong,nonatomic) id<DatePickerProtocol> datePickerDelegate;

- (IBAction)ActionResignDatePicker:(id)sender;
@end
