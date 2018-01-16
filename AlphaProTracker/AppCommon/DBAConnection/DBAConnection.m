//
//  DBAConnection.m
//  AlphaProTracker
//
//  Created by Mac on 20/10/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "DBAConnection.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import "getimageRecord.h"
#import "Utitliy.h"
#import "TestAssessmentViewVC.h"


@implementation DBAConnection

static NSString *SQLITE_FILE_NAME = @"agapt_database.sqlite";

//Copy database to application document
-(void) copyDatabaseIfNotExist{
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:SQLITE_FILE_NAME];
    
    //NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {//If file not exist
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:SQLITE_FILE_NAME];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

//Get database path
-(NSString *) getDBPath
{
    [self copyDatabaseIfNotExist];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:SQLITE_FILE_NAME];
}

-(NSString *) getValueByNull: (sqlite3_stmt *) statement : (int) position{
    return [ NSString stringWithFormat:@"%@",((const char*)sqlite3_column_text(statement, position)==nil)?@"":[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, position)]];
}


-(NSNumber *) getNumberValueByNull: (sqlite3_stmt *) statement : (int) position{
    return [NSNumber numberWithInt: [ NSString stringWithFormat:@"%@",((const char*)sqlite3_column_text(statement, position)==nil)?@"0":[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, position)]].intValue];
}

//MATCHREGISTRATION

-(NSMutableArray *)AssessmentTestType: (NSString *) clientCode :(NSString *) userCode:(NSString *) moduleCode{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        if(retVal ==0){
            
            NSString *query=[NSString stringWithFormat:@"SELECT ASSM.CLIENTCODE, ASSM.MODULECODE, ASSM.ASSESSMENTCODE,ASSM.ASSESSMENTNAME,ASSM.RECORDSTATUS,ASSM.CREATEDBY,ASSM.CREATEDDATE,ASSM.MODIFIEDBY,ASSM.MODIFIEDDATE,MDMODULE.METASUBCODEDESCRIPTION AS MODULENAME FROM  ASSESSMENT ASSM INNER JOIN METADATA MDMODULE  ON MDMODULE.METASUBCODE=ASSM.MODULECODE WHERE ASSM.CLIENTCODE = '%@' AND ASSM.RECORDSTATUS = 'MSC001' AND CREATEDBY = '%@' AND MODULECODE = '%@'",clientCode,userCode,moduleCode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
//                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//                    f.numberStyle = NSNumberFormatterDecimalStyle;
//                    // [f numberFromString:
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    NSString *	setAssessmentCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                    NSString *	setAssessmentName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                    
                    [dic setObject:setAssessmentCode forKey:@"AssessmentCode"];
                    [dic setObject:setAssessmentName forKey:@"AssessmentName"];
                    
                    [assessment addObject:dic];
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", assessment);
    
        return assessment;
    }
}

-(NSMutableArray *)TestByAssessment: (NSString *) clientCode :(NSString *) AssessmentCode:(NSString *) moduleCode{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        if(retVal ==0){
            
            
            
            //NSString * rd = @"MSC001";
            
            
            //(CASE WHEN MR.TEAMACODE='%@' THEN MR.TEAMBCODE ELSE MR.TEAMACODE END)
            NSString *query=[NSString stringWithFormat:@"SELECT TESTCODE, TESTNAME FROM ASSESSMENTTESTMASTER WHERE CLIENTCODE = '%@' AND MODULECODE = '%@' AND ASSESSMENTCODE = '%@'",clientCode,moduleCode,AssessmentCode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
                    
                    
                    //                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    //                    f.numberStyle = NSNumberFormatterDecimalStyle;
                    //                    // [f numberFromString:
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    NSString *	setTestCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    NSString *	setTestName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    
                    
                    [dic setObject:setTestCode forKey:@"TestCode"];
                    [dic setObject:setTestName forKey:@"TestName"];
                    
                    [assessment addObject:dic];
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", assessment);
        
        return assessment;
    }
}

-(NSMutableArray *)AssessmentEntryByDate: (NSString *) AssessmentCode :(NSString *) Usercode:(NSString *) moduleCode:(NSString *) date:(NSString *) Clientcode{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        if(retVal ==0){
            
            
            
            //NSString * rd = @"MSC001";
            
            //(CASE WHEN MR.TEAMACODE='%@' THEN MR.TEAMBCODE ELSE MR.TEAMACODE END)
            NSString *query=[NSString stringWithFormat:@"SELECT * FROM ASSESSMENTENTRY WHERE ASSESSMENTCODE = '%@' AND CREATEDBY = '%@' AND  DATE(ASSESSMENTENTRYDATE) = DATE('%@') AND  MODULECODE = '%@' AND CLIENTCODE = '%@' AND RECORDSTATUS = 'MSC001'",AssessmentCode,Usercode,date,moduleCode,Clientcode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
                    
                    
                    //                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    //                    f.numberStyle = NSNumberFormatterDecimalStyle;
                    //                    // [f numberFromString:
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    NSString *	setAssessmentCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                    NSString *	setTestCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                    NSString *	setTestTypeCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                    NSString *	setAthleteCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                    
                    
                    [dic setObject:setAssessmentCode forKey:@"AssessmentCode"];
                    [dic setObject:setTestCode forKey:@"TestCode"];
                    [dic setObject:setTestTypeCode forKey:@"TestTypeCode"];
                    [dic setObject:setAthleteCode forKey:@"AthleteCode"];

                    
                    [assessment addObject:dic];
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", assessment);
        
        return assessment;
    }
}

-(NSMutableArray *)PlayersByCoach:(NSString *) Clientcode:(NSString *) Userref{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        if(retVal ==0){
            
            
            
            //NSString * rd = @"MSC001";
            
            //(CASE WHEN MR.TEAMACODE='%@' THEN MR.TEAMBCODE ELSE MR.TEAMACODE END)
            NSString *query=[NSString stringWithFormat:@"SELECT AIT.ATHLETECODE,COALESCE(AMR.FIRSTNAME,'')||' '||COALESCE(AMR.LASTNAME,'') AS PLAYERNAME FROM ATHLETEINFOTEAM AIT INNER JOIN  ASSOCIATIONMEMBERREGISTRATION AMR ON AMR.ASSOCIATIONMEMBERID = AIT.ATHLETECODE AND AMR.CLIENTCODE=AIT.CLIENTCODE WHERE TEAMCODE IN (SELECT DISTINCT TEAMCODE FROM SUPPORTSTAFFTEAMS AIT WHERE AIT.CODE = '%@' AND AIT.CLIENTCODE = '%@') UNION SELECT AIT.ATHLETECODE,    COALESCE(AMR.FIRSTNAME,'')||' '||COALESCE(AMR.LASTNAME,'') AS PLAYERNAME FROM ATHLETEINFOTEAM AIT INNER JOIN  ASSOCIATIONMEMBERREGISTRATION AMR ON AMR.ASSOCIATIONMEMBERID = AIT.ATHLETECODE AND AMR.CLIENTCODE=AIT.CLIENTCODE WHERE TEAMCODE IN (SELECT DISTINCT TEAMCODE FROM ATHLETEINFOTEAM AIT WHERE AIT.ATHLETECODE = '%@' AND AIT.CLIENTCODE = '%@')",Userref,Clientcode,Userref,Clientcode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
                    
                    
                    //                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    //                    f.numberStyle = NSNumberFormatterDecimalStyle;
                    //                    // [f numberFromString:
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    NSString *	setPlayerCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    NSString *	setPlayerName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    
                    
                    [dic setObject:setPlayerCode forKey:@"PlayerCode"];
                    [dic setObject:setPlayerName forKey:@"PlayerName"];
                    
                    [assessment addObject:dic];
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", assessment);
        
        return assessment;
    }
}


-(NSString *)ScreenId:(NSString *) AssessmentCode:(NSString *) AssessmentTestCode{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        NSString *	result;
        if(retVal ==0){
            
            
            //NSString * rd = @"MSC001";
            
            //(CASE WHEN MR.TEAMACODE='%@' THEN MR.TEAMBCODE ELSE MR.TEAMACODE END)
            NSString *query=[NSString stringWithFormat:@"SELECT ASSESSMENTTESTTYPESCREENCODE FROM ASSESSMENTREGISTER WHERE ASSESSMENTCODE= '%@' AND ASSESSMENTTESTCODE= '%@' GROUP BY ASSESSMENTTESTTYPESCREENCODE",AssessmentCode,AssessmentTestCode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
                    
                    
                    //                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    //                    f.numberStyle = NSNumberFormatterDecimalStyle;
                    //                    // [f numberFromString:
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    result=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    
                    
                    
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", result);
        
        return result;
    }
}

-(NSString *)ScreenCount:(NSString *) AssessmentCode:(NSString *) AssessmentTestCode{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        NSString *	result;
        int re;
        if(retVal ==0){
            
            
        NSString *query=[NSString stringWithFormat:@"SELECT COUNT(ASSESSMENTTESTTYPESCREENCODE) FROM ASSESSMENTREGISTER WHERE ASSESSMENTCODE ='%@' AND ASSESSMENTTESTCODE='%@'",AssessmentCode,AssessmentTestCode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
                    result=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                 
                    
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", result);
        
        return result;
    }
}


-(NSMutableArray *)AssementForm:(NSString *) ScreenId:(NSString *) clientcode :(NSString *) modulecode:(NSString *) AssessmentCode :(NSString *) AssessmentTestCode{
    
    @synchronized ([Utitliy syncId])  {
        int retVal;
        NSString *dbPath = [self getDBPath];
        sqlite3 *dataBase;
        const char *stmt;
        sqlite3_stmt *statement;
        retVal=sqlite3_open([dbPath UTF8String], &dataBase);
        NSMutableArray *assessment = [[NSMutableArray alloc]init];
        
        if(retVal ==0){
  
            NSString *query=[NSString stringWithFormat:@"SELECT(CASE WHEN '%@'='ASTT001' THEN TRM.TESTCODE WHEN '%@'='ASTT002' THEN TS.TESTCODE WHEN '%@'='ASTT003'  THEN MMT.TESTCODE  WHEN '%@'='ASTT004' THEN TG.TESTCODE WHEN '%@'='ASTT005' THEN TP.TESTCODE WHEN '%@'='ASTT006' THEN SC.TESTCODE  WHEN '%@'='ASTT007' THEN TC.TESTCODE END )   AS TESTTYPECODE, (CASE WHEN '%@'='ASTT001' THEN IFNULL(TRM.JOINT,'')||'-'||IFNULL(TRM.MOVEMENT,'') WHEN '%@'='ASTT002' THEN IFNULL(TS.TESTNAME,'(empty)') WHEN '%@'='ASTT003' THEN IFNULL(MMT.JOINT,'')||'-'||IFNULL(MMT.MOTION,'')||IFNULL(MMT.MUSCLE,'')  WHEN '%@'='ASTT004' THEN IFNULL(TG.PLANE,'')||'-'||IFNULL(TG.TESTNAME,'(empty)') WHEN '%@'='ASTT005' THEN IFNULL(TP.VIEW,'')||'-'||IFNULL(TP.REGION,'') WHEN '%@'='ASTT006' THEN IFNULL(SC.COMPONENT,'')||'-'||IFNULL(SC.TESTNAME,'') WHEN '%@'='ASTT007' THEN IFNULL(TC.KPI,'')||'-'||IFNULL(TC.DESCRIPTION,'') END )   AS TESTTYPENAME  FROM   ASSESSMENTREGISTER  ATM  LEFT JOIN TESTRANGEOFMOTION TRM ON TRM.TESTCODE=ATM.ASSESSMENTTESTTYPECODE  LEFT JOIN TESTSPECIAL TS ON TS.TESTCODE=ATM.ASSESSMENTTESTTYPECODE  LEFT JOIN TESTMMT MMT ON MMT.TESTCODE=ATM.ASSESSMENTTESTTYPECODE LEFT JOIN TESTPOSTURE TP ON TP.TESTCODE=ATM.ASSESSMENTTESTTYPECODE LEFT JOIN TESTGAINT TG ON TG.TESTCODE=ATM.ASSESSMENTTESTTYPECODE  LEFT JOIN TESTSC SC ON SC.TESTCODE=ATM.ASSESSMENTTESTTYPECODE LEFT JOIN TESTCOACHING TC ON TC.TESTCODE=ATM.ASSESSMENTTESTTYPECODE WHERE ATM.ASSESSMENTTESTTYPESCREENCODE='%@'  AND  ATM.CLIENTCODE='%@'  AND    ATM.MODULECODE='%@' AND ATM.RECORDSTATUS= 'MSC001' AND ATM.ASSESSMENTCODE = '%@' AND ATM.ASSESSMENTTESTCODE = '%@'",ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,ScreenId,clientcode,modulecode,AssessmentCode,AssessmentTestCode];
            
            
            
            
            NSLog(@"%@",query);
            stmt=[query UTF8String];
            if(sqlite3_prepare(dataBase, stmt, -1, &statement, NULL)==SQLITE_OK)
            {
                while(sqlite3_step(statement)==SQLITE_ROW){
                    NSLog(@"Success");
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    
                    NSString *	setTestTypeCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    NSString *	setTestTypeName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    
                    
                    [dic setObject:setTestTypeCode forKey:@"TestTypeCode"];
                    [dic setObject:setTestTypeName forKey:@"TestTypeName"];
                    
                    [assessment addObject:dic];

                    
                    
                }
                sqlite3_reset(statement);
                sqlite3_finalize(statement);
            }
            sqlite3_close(dataBase);
        }
        NSLog(@"%@", assessment);
        
        return assessment;
    }
}







@end
