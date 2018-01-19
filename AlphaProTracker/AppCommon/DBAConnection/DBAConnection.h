//
//  DBAConnection.h
//  AlphaProTracker
//
//  Created by Mac on 20/10/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBAConnection : NSObject

-(NSMutableArray *)AssessmentTestType: (NSString *) clientCode :(NSString *) userCode:(NSString *) moduleCode;
-(NSMutableArray *)TestByAssessment: (NSString *) clientCode :(NSString *) AssessmentCode:(NSString *) moduleCode;
-(NSMutableArray *)AssessmentEntryByDate: (NSString *) AssessmentCode :(NSString *) Usercode:(NSString *) moduleCode:(NSString *) date:(NSString *) Clientcode;

-(NSMutableArray *)PlayersByCoach:(NSString *) Clientcode:(NSString *) Usercode;

-(NSString *)ScreenId:(NSString *) AssessmentCode:(NSString *) AssessmentTestCode;
-(NSString *)ScreenCount:(NSString *) AssessmentCode:(NSString *) AssessmentTestCode;

-(NSMutableArray *)AssementForm:(NSString *) ScreenId:(NSString *) clientcode :(NSString *) modulecode:(NSString *) AssessmentCode :(NSString *) AssessmentTestCode;
-(NSMutableArray *)AssessmentTeamListDetail :(NSString *) membercode;
-(NSMutableArray *)AssessmentPlayerListDetail :(NSString *) clientCode :(NSString *)userCode;
@end
