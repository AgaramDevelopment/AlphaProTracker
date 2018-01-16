//
//  QuestionaryCell.h
//  AlphaProTracker
//
//  Created by Mac on 07/10/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionaryCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *sno;
@property (nonatomic,strong) IBOutlet UILabel *q1;
@property (nonatomic,strong) IBOutlet UITextField *editTxt;
@property (nonatomic,strong) IBOutlet NSMutableArray *retArray;
@property (nonatomic,strong) IBOutlet NSMutableArray *retArray1;

@property (nonatomic,strong) IBOutlet NSString *ansedit;

@end
