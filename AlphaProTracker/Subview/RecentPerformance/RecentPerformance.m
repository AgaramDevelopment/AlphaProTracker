//
//  RecentPerformance.m
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "RecentPerformance.h"

@interface RecentPerformance ()
{
    BOOL isOdi;
    BOOL isT20;
    BOOL isMultiday;
}

@end

@implementation RecentPerformance

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ODI sendActionsForControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)odiBtn:(id)sender {
    [self setInningsBySelection:@"1"];
    
    }
- (IBAction)t20Btn:(id)sender {
    [self setInningsBySelection:@"2"];
    
}
- (IBAction)multiDayBtn:(id)sender {
    [self setInningsBySelection:@"3"];
    }
-(void) setInningsBySelection: (NSString*) innsNo{
    
    [self setInningsButtonUnselect:self.ODI];
    [self setInningsButtonUnselect:self.T20];
    [self setInningsButtonUnselect:self.MULTIDAY];
    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonSelect:self.ODI];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonSelect:self.T20];
    }
    else if([innsNo isEqualToString:@"3"]){
        
        [self setInningsButtonSelect:self.MULTIDAY];
    }

}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}

-(void) setInningsButtonSelect : (UIButton*) innsBtn{
    // innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#0073FF"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    
}

-(void) setInningsButtonUnselect : (UIButton*) innsBtn{
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#FFFFFF"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
