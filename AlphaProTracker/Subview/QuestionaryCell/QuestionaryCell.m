//
//  QuestionaryCell.m
//  AlphaProTracker
//
//  Created by Mac on 07/10/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "QuestionaryCell.h"
#import "QuestionaryVC.h"

@interface QuestionaryCell ()
{
   // NSMutableArray *retArray;
    //NSString *ansedit;
}

@end

@implementation QuestionaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.editTxt.layer.borderColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    self.editTxt.layer.borderWidth = 0.5f;
    
    self.retArray1 = [[NSMutableArray alloc]init];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
//-(bool)textFieldDidEndEditing:(UITextField *) textField {
//  
//    return YES;
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
