//
//  MessangerTableViewCell.m
//  AlphaProTracker
//
//  Created by user on 26/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "MessangerTableViewCell.h"

@implementation MessangerTableViewCell
@synthesize SenderMsg;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)calculateMsgSize
{
    [SenderMsg invalidateIntrinsicContentSize];
    NSLog(@"TEXT %@ ",SenderMsg.text);
    CGSize size = SenderMsg.intrinsicContentSize;
    NSLog(@"calculateMsgSize %@",NSStringFromCGSize(size));
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:SenderMsg.text attributes:@{NSFontAttributeName:SenderMsg.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){SenderMsg.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    NSLog(@"SenderMsg height %@ ",NSStringFromCGRect(rect));
    
//    SenderMsg.layout

}

@end
