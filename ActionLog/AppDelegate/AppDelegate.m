//  AppDelegate.m
//  ActionLog
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.

#import "AppDelegate.h"
#import "Dashboard.h"
#import "DashboardNavigationViewController.h"
//#import "Macro.h"
@interface AppDelegate (){
    AllMethods *Methods;
    NSString *urlTagList;
}

@end

@implementation AppDelegate

@synthesize STRDATEFORMATE,STRWEBDATEFORMATE,WEBPATH,STRUSERTYPE,STRTOKEN,STRUSERNAME,ISAPPROVE,STRUSERID,STRCOMPANYID,ARRAYTAG,ARRAYASSIGNTO,ARRAYCREATEDBY,ARRAYDEPARTMENT,ARRAYOVERDUE,ARRAYCOMPANY,ARRAYTAGVALUE,LOG,sesson1,STRCREATEDBY,ARRAYFULLASSIGNTO,ARRAYUSERLIST,ARRAYWORKDATE;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
   //idt = 40;
    ARRAYTAG = [[NSMutableArray alloc]init];
    ARRAYTAGVALUE = [[NSMutableArray alloc]init];
    ARRAYCREATEDBY = [[NSMutableArray alloc]init];
    ARRAYASSIGNTO = [[NSMutableArray alloc]init];
    ARRAYFULLASSIGNTO = [[NSMutableArray alloc]init];
    ARRAYDEPARTMENT = [[NSMutableArray alloc]init];
    ARRAYOVERDUE = [[NSMutableArray alloc]init];
    ARRAYCOMPANY = [[NSMutableArray alloc]init];
    ARRAYUSERLIST = [[NSMutableArray alloc]init];
    ARRAYWORKDATE = [[NSMutableArray alloc]init];
    ISAPPROVE = @"NO";//http://test1.rettest.com/action_log/api
    
    bool isLive = NO;
    
    if (isLive){
        WEBPATH = @"https://retptyltd.com/action_log/api/";//Live
    }else{
        WEBPATH= @"https://test1.rettest.com/action_log_final/api/";//Test server
    }
    
    NSString *version1;
    version1 = @"v3/";
    WEBPATH = [WEBPATH stringByAppendingString:version1];
    
   
    STRUSERTYPE = @"SuperAdmin";
    STRWEBDATEFORMATE =@"yyyy-MM-dd HH:mm:ss";
    STRDATEFORMATE = @"dd-MMM-yyyy hh:mm a";
    sesson = [NSUserDefaults standardUserDefaults];

    NSString *email = [sesson objectForKey:@"stuts"];
    NSString *userName = [sesson objectForKey:@"usename"];
    NSString *userId = [sesson objectForKey:@"userid"];
    NSString *useremail = [sesson objectForKey:@"email"];
    NSString *userToken = [sesson objectForKey:@"token"];
    NSString *userType = [sesson objectForKey:@"Type"];
    NSString *companyId =[sesson objectForKey:@"companyId"];
    [sesson synchronize];
     UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if([email isEqualToString:@"login"]){
        NSLog(@"Insaid login Use Name:=%@",useremail);
        NSLog(@"Insaid login UseId:=%@",userId);
        NSLog(@"TOKEN %@",userToken);
        STRUSERID = userId;
        STRUSERNAME = userName;
        STRTOKEN = userToken;
        STRUSERTYPE = userType;
        STRCOMPANYID = companyId;
        DashboardNavigationViewController *secondViewController = [storyBoard instantiateViewControllerWithIdentifier:@"dashboardN"];
        self.window.rootViewController = secondViewController;
    }
    
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"version := %@",version);
//    Methods = [[AllMethods alloc]init];
//    NSDictionary *dataDictionary = [Methods WebServerData:@"https://retptyltd.com/action_log/api/v2/version/getVersion" andPostParameter:@"ver_type=ios"];
//    
//    //NSDictionary *dataDictionary = [Methods WebServerDataOld:@"https://test1.rettest.com/webservice_ios_devind/versions_portal/view_api.php" andPostParameter:@"ver_type=ios"];
//    NSLog(@"Data Dictionary %@",dataDictionary);
//    NSArray *arrayData = [dataDictionary valueForKey:@"info"];
//    //arrayBussinessGroup = [[NSMutableArray alloc]init];
//    NSString *VERSION;
//    for (NSDictionary *dic in arrayData) {
//        VERSION = [dic valueForKey:@"ver_name"];
//    }
//    
//    if(![VERSION isEqualToString:version]){
//        NSLog(@"Both viersion are same");
//        //MESSAGE =1;
//        UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@"Update Available!"
//                                                   message:@"This app is out dated. New version is available on Appstore. Kindly update this app to latest version for better experience."
//                                                  delegate:self
//                                         cancelButtonTitle:@"Cancel"
//                                         otherButtonTitles:@"Update" ,nil];
//        [obj show];
//        
//        //[self showUiAlertWithMessage1:@"This app is out dated new version is available on Appstore kindly update this to use thi App" andtitle:@"New version update"];
//        //  NSString *iTunesLink = @"itms://itunes.apple.com/us/app/apple-store/id1199866689";
//        //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
//    }

    
    return YES;
}

-(void)webServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    NSMutableArray *array = [web WebDashboard];
    NSLog(@"Web Data%@",array);
    //urlCompany = [[array objectAtIndex:0]webCompany];
   // urlDepartment = [[array objectAtIndex:0]webDepartment];
   // urlCreatedBy= [[array objectAtIndex:0]webCreatedBy];
   // urlAssignTo= [[array objectAtIndex:0]webAssignTo];
   // urlStatus= [[array objectAtIndex:0]webStatus];
    //urlDueDate= [[array objectAtIndex:0]webDueDate];
   // urlDueFrom= [[array objectAtIndex:0]webDueFrom];
   // urlDueTo= [[array objectAtIndex:0]webDueTo];
   // urlDashboard = [[array objectAtIndex:0]webDashboard];
    //urlSearch= [[array objectAtIndex:0]webSearchFilter];
    urlTagList = [[array objectAtIndex:0]webTagList];
    //urlChangeActionStatus = [[array objectAtIndex:0]webChangeActionStatus];
    //urlLogOut = [[array objectAtIndex:0]webLogOut];

}

-(void)GetTag{
   // if(appDelegate.ARRAYTAG.count==0 || appDelegate.ARRAYTAGVALUE.count ==0)
    {
        Methods = [[AllMethods alloc]init];

        NSDictionary *dataDictionary = [Methods  WebServerData:urlTagList];
        ARRAYTAG = [[NSMutableArray alloc]init];
        ARRAYTAGVALUE = [[NSMutableArray alloc]init];
        
        NSArray *keys;
        int i, count;
        id key, value;
        NSDictionary *dict = [dataDictionary objectForKey:@"info"];
        keys = [dict allKeys];
        count =(int)[keys count];
        for (i = 0; i < count; i++){
            CustomData *cmd = [[CustomData alloc]init];
            key = [keys objectAtIndex: i];
            value = [dict objectForKey: key];
            cmd.strKey =[NSString stringWithFormat:@"%@",key];
            cmd.strStatus =[NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
            [ARRAYTAG addObject:cmd];
            [ARRAYTAGVALUE addObject:value];
            
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
