//
//  Utitliy.m
//  CAPScoringApp
//
//  Created by APPLE on 25/06/16.
//  Copyright © 2016 agaram. All rights reserved.
//

#import "Utitliy.h"
#import "AppDelegate.h"


//Public IP host
@implementation Utitliy

+(NSString *)getIPPORT{
   //return @"ioswebservice.upca.tv";
   // return  @"192.168.1.116:8065";
    return @"betaioswebservice.upca.tv";
    //return @"192.168.1.209:8011/CAPWEBSITE.svc";    //http://192.168.1.209:8101  internal testing
    
    
    //return @"192.168.1.191:8100";     //t.nagar
    
    
   // return @"192.168.1.200:8131";  //local
    
    //return @"123.201.63.168:8131"; // - static
    
    //return @"capios.agaraminfotech.com";
    
   //  return @"192.168.1.209:8023";  //testing
}


+(NSString *)getSyncIPPORT{
    
     return @"betaioswebservice.upca.tv";
   // return @"ioswebservice.upca.tv";
   // return  @"192.168.1.116:8065";   //192.168.1.49:8096 //@"192.168.1.116:8888";
    
    // return @"192.168.1.209:8011";
    
     //return @"192.168.1.191:8100";     //t.nagar
    
   // return @"192.168.1.200:8131";  //local
    
    //return @"123.201.63.168:8131"; // - static
    
   //return @"capios.agaraminfotech.com";
    
   // return @"192.168.1.209:8023";  //testing

}

+(NSString *)SecureId{
    return  @"SecureId";
}

+ (NSString *)syncId
{
    return @"Sync";
}

//+(NSString *)getIPPORT{
//    return  @"betaioswebservice.upca.tv";
//}
//
//
//+(NSString *)getSyncIPPORT{
//    return  @"betaioswebservice.upca.tv";
//}
//
//+(NSString *)SecureId{
//    return  @"SecureId";
//}




//NSNumber *basePMWidth = [NSNumber numberWithInt:295];
//NSNumber *basePMHeight = [NSNumber numberWithInt:380];
//
//NSNumber *deviceProWidth = [NSNumber numberWithInt:623];
//NSNumber *deviceProHeight = [NSNumber numberWithInt:700];
//
//NSNumber *deviceOtherWidth = [NSNumber numberWithInt:367];
//NSNumber *deviceOtherHeight = [NSNumber numberWithInt:406];

//PitchMap





@end

//@implementation Utitliy
//
//+(NSString *)getIPPORT{
//    return  @"182.74.23.197:8102";
//}192.168.1.191:8100
//
//
//+(NSString *)getSyncIPPORT{
//    return  @"182.74.23.197:8102";
//}
//
//+(NSString *)SecureId{
//    return  @"SecureId";
//}
//@end


//@"192.168.1.116:8888" - development
//@"192.168.1.151:8888" - testing
