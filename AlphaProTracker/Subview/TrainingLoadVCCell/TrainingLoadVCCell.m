//
//  TrainingLoadVCCell.m
//  AlphaProTracker
//
//  Created by Lexicon on 21/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "TrainingLoadVCCell.h"

@interface TrainingLoadVCCell ()

@end

@implementation TrainingLoadVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.borderview.layer.borderWidth=1.0f;
    self.borderview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    self.teamview.layer.borderWidth=0.5f;
    self.teamview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview.layer.borderWidth=0.5f;
    self.playerview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview.layer.borderWidth=0.5f;
    self.dateview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview.layer.borderWidth=0.5f;
    self.actview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview.layer.borderWidth=0.5f;
    self.rpeview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview.layer.borderWidth=0.5f;
    self.timeview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview.layer.borderWidth=0.5f;
    self.ballslblview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
