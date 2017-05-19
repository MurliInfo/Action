//
//  CustomDataform.m
//  ActionLog
//
//  Created by Hardik Davda on 4/17/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import "CustomDataform.h"

@implementation CustomDataform
{
    NSMutableArray *arrayDashboardAdvanceSearch;
}
//-(NSMutableArray *)ADSDSuperAdmin;
//-(NSMutableArray *)ADSDAdmn;
//-(NSMutableArray *)ADSDStaff;
//-(NSMutableArray *)ADSDFSuperAdmin;

-(NSMutableArray *)ADSDSuperAdmin{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];
    
    // 1
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 1;
   cmd.isSingal = YES;
    cmd.strPlaceholder = @"Companies";
    cmd.strSelectedValue = @"Companies";
    cmd.strParameter = @"&company_id=";
    cmd.strValue = @"";
    cmd.isDate =  NO;
    cmd.btnTag = 1;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"NO DATA";
    cmd.strSelectedValue1 = @"NO DATA";
    cmd.strParameter1 = @"&No Data=";
    cmd.strValue1 = @"";
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 00;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //2
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 2;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Departments";
    cmd.strSelectedValue = @"Departments";
    cmd.strParameter = @"&department_id=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 2;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    
    cmd.strPlaceholder1 = @"Created By";
    cmd.strSelectedValue1 = @"Created By";
    cmd.strParameter1 = @"&created_by=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 3;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //3
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 3;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Assign To";
    cmd.strSelectedValue = @"Assign To";
    cmd.strParameter = @"&assign_to=";
    cmd.strValue = @"";
    
    
    cmd.isDate =  NO;
    cmd.btnTag = 4;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Status";
    cmd.strSelectedValue1 = @"Status";
    cmd.strParameter1 = @"&status=";
    cmd.strValue1 = @"";
    
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 5;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //4
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self Due];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //5
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self WorkDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //6
    
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self DueDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self Buttons];
    [arrayDashboardAdvanceSearch addObject:cmd];
    return arrayDashboardAdvanceSearch ;
}

-(NSMutableArray *)ADSDFSuperAdmin{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];

// 1
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd = [self CompanyDepartment];
    [arrayDashboardAdvanceSearch addObject:cmd];
//2
//3
    cmd = [[CustomDataform alloc]init];
    cmd = [self CreatedAssignTo];
    [arrayDashboardAdvanceSearch addObject:cmd];
//4
    cmd = [[CustomDataform alloc]init];
    cmd = [self Due];
    [arrayDashboardAdvanceSearch addObject:cmd];
//5
    cmd = [[CustomDataform alloc]init];
    cmd = [self WorkDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
//6
    cmd = [[CustomDataform alloc]init];
    cmd = [self DueDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self Buttons];
    [arrayDashboardAdvanceSearch addObject:cmd];

    return arrayDashboardAdvanceSearch ;
}

-(NSMutableArray *)ADSDAdmn{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];
    
    // 1
    CustomDataform *cmd = [[CustomDataform alloc]init];
//    cmd.strPlaceholder = @"Companies";
//    cmd.strSelectedValue = @"Companies";
//    cmd.isDate =  NO;
//    cmd.btnTag = 1;
//    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
//    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //2
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 2;
    cmd.strPlaceholder = @"Departments";
    cmd.strSelectedValue = @"Departments";
    cmd.strParameter = @"&department_id=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 2;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Created By";
    cmd.strSelectedValue1 = @"Created By";
    cmd.strParameter1 = @"&created_by=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 3;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //3
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 3;
    cmd.strPlaceholder = @"Assign To";
    cmd.strSelectedValue = @"Assign To";
    cmd.strParameter = @"&assign_to=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 4;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Status";
    cmd.strSelectedValue1 = @"Status";
    cmd.strParameter1 = @"&status=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 5;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //4
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 4;
    cmd.strPlaceholder = @"Due Date";
    cmd.strSelectedValue = @"Due Date";
    cmd.strParameter = @"&overdue=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 6;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Work Date";
    cmd.strSelectedValue1 = @"Work Date";
    cmd.strParameter1 = @"&workdatefilter=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 7;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //5
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 5;
    cmd.strPlaceholder = @"Work From Date";
    cmd.strSelectedValue = @"Work From Date";
    cmd.strParameter = @"&work_date=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 8;
    cmd.imgAerro =  [UIImage imageNamed:@"Date.png"];
    
    cmd.strPlaceholder1 = @"Work To Date";
    cmd.strSelectedValue1 = @"Work To Date";
    cmd.strParameter1 = @"&work_date=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 9;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Date.png"];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //6
    
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 6;
    cmd.strPlaceholder = @"Due From Date";
    cmd.strSelectedValue = @"Due From Date";
    cmd.strParameter = @"&due_date=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 10;
    cmd.imgAerro =  [UIImage imageNamed:@"Date.png"];
    
    cmd.strPlaceholder1 = @"Due To Date";
    cmd.strSelectedValue1 = @"Due To Date";
    cmd.strParameter1 = @"&due_date=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 11;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Date.png"];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 00;
    [arrayDashboardAdvanceSearch addObject:cmd];
    //    cmd.btnSelectIteam = @"";
    return arrayDashboardAdvanceSearch ;
}

-(NSMutableArray *)ADSDStaff{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];
    
    // 1
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 3;
    cmd.strPlaceholder = @"Created By";
    cmd.strSelectedValue = @"Created By";
    cmd.strParameter = @"&created_by=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 3;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Status";
    cmd.strSelectedValue1 = @"Status";
    cmd.strParameter1 = @"&status=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 5;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //4
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 4;
    cmd.strPlaceholder = @"Due Date";
    cmd.strSelectedValue = @"Due Date";
    cmd.strParameter = @"&overdue=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 6;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Work Date";
    cmd.strSelectedValue1 = @"Work Date";
    cmd.strParameter1 = @"&workdatefilter=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 7;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //5
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 5;
    cmd.strPlaceholder = @"Work From Date";
    cmd.strSelectedValue = @"Work From Date";
    cmd.strParameter = @"&work_date=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 8;
    cmd.imgAerro =  [UIImage imageNamed:@"Date.png"];
    
    cmd.strPlaceholder1 = @"Work To Date";
    cmd.strSelectedValue1 = @"Work To Date";
    cmd.strParameter1 = @"&work_date=";
    cmd.strValue1 = @"";
    
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 9;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Date.png"];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    //6
    
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 6;
    cmd.strPlaceholder = @"Due From Date";
    cmd.strSelectedValue = @"Due From Date";
    cmd.strParameter = @"&due_date=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 10;
    cmd.imgAerro =  [UIImage imageNamed:@"Date.png"];
    
    cmd.strPlaceholder1 = @"Due To Date";
    cmd.strSelectedValue1 = @"Due To Date";
    cmd.strParameter1 = @"&due_date=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 11;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Date.png"];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd.Id = 00;
    [arrayDashboardAdvanceSearch addObject:cmd];
    //    cmd.btnSelectIteam = @"";
    return arrayDashboardAdvanceSearch ;
}

-(NSMutableArray *)ADSASuperAdmin{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];
    
    // 1
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd = [self CompanyDepartment];
    [arrayDashboardAdvanceSearch addObject:cmd];
    //2
    //3
    cmd = [[CustomDataform alloc]init];
    cmd = [self CreatedAssignTo];
    [arrayDashboardAdvanceSearch addObject:cmd];
    //4
//    cmd = [[CustomDataform alloc]init];
//    cmd = [self Due];
//    [arrayDashboardAdvanceSearch addObject:cmd];
    //5
    cmd = [[CustomDataform alloc]init];
    cmd = [self WorkDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    //6
    cmd = [[CustomDataform alloc]init];
    cmd = [self DueDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self Buttons];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    return arrayDashboardAdvanceSearch ;
}

-(NSMutableArray *)ADSAAdmin{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];
    
    // 1
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 1;
    cmd.isSingal = YES;
    cmd.strPlaceholder = @"Departments";
    cmd.strSelectedValue = @"Departments";
    cmd.strParameter = @"&department_id=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 2;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"NO DATA";
    cmd.strSelectedValue1 = @"NO DATA";
    cmd.strParameter1 = @"&No Data=";
    cmd.strValue1 = @"";
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 00;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    [arrayDashboardAdvanceSearch addObject:cmd];
    //2
    //3
    cmd = [[CustomDataform alloc]init];
    cmd = [self CreatedAssignTo];
    [arrayDashboardAdvanceSearch addObject:cmd];
    //4
    //    cmd = [[CustomDataform alloc]init];
    //    cmd = [self Due];
    //    [arrayDashboardAdvanceSearch addObject:cmd];
    //5
    cmd = [[CustomDataform alloc]init];
    cmd = [self WorkDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    //6
    cmd = [[CustomDataform alloc]init];
    cmd = [self DueDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self Buttons];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    return arrayDashboardAdvanceSearch ;
}

-(NSMutableArray *)ADSAStaff{
    arrayDashboardAdvanceSearch = [[NSMutableArray alloc]init];
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 3;
    cmd.isSingal = YES;
    cmd.strPlaceholder = @"Created By";
    cmd.strSelectedValue = @"Created By";
    cmd.strParameter = @"&created_by=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 3;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    
    cmd.strPlaceholder1 = @"NO DATA";
    cmd.strSelectedValue1 = @"NO DATA";
    cmd.strParameter1 = @"&No Data=";
    cmd.strValue1 = @"";
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 00;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self WorkDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    //6
    cmd = [[CustomDataform alloc]init];
    cmd = [self DueDates];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    cmd = [[CustomDataform alloc]init];
    cmd = [self Buttons];
    [arrayDashboardAdvanceSearch addObject:cmd];
    
    return arrayDashboardAdvanceSearch;
}

-(CustomDataform *)CompanyDepartment{
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 1;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Companies";
    cmd.strSelectedValue = @"Companies";
    cmd.strParameter = @"&company_id=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 1;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    //    cmd.Id = 2;
    cmd.strPlaceholder1 = @"Departments";
    cmd.strSelectedValue1 = @"Departments";
    cmd.strParameter1 = @"&department_id=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 2;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];

    
    return cmd;
}

-(CustomDataform *)CreatedAssignTo{
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 3;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Created By";
    cmd.strSelectedValue = @"Created By";
    cmd.strParameter = @"&created_by=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 3;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    

    cmd.strPlaceholder1 = @"Assign To";
    cmd.strSelectedValue1 = @"Assign To";
    cmd.strParameter1 = @"&assign_to=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 4;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];

    return cmd;
}
-(CustomDataform *)Due{
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 4;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Due Date";
    cmd.strSelectedValue = @"Due Date";
    cmd.strParameter = @"&overdue=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 6;
    cmd.imgAerro =  [UIImage imageNamed:@"Down-aerrow.png"];
    
    cmd.strPlaceholder1 = @"Work Date";
    cmd.strSelectedValue1 = @"Work Date";
    cmd.strParameter1 = @"&workdatefilter=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 7;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Down-aerrow.png"];
    return cmd;
}
-(CustomDataform *)WorkDates{
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 5;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Work From Date";
    cmd.strSelectedValue = @"Work From Date";
    cmd.strParameter = @"&work_date=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 8;
    cmd.imgAerro =  [UIImage imageNamed:@"Date.png"];
    
    cmd.strPlaceholder1 = @"Work To Date";
    cmd.strSelectedValue1 = @"Work To Date";
    cmd.strParameter1 = @"&work_date=";
    cmd.strValue1 = @"";
    
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 9;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Date.png"];
    return cmd;
}
-(CustomDataform *)DueDates{
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.Id = 6;
    cmd.isSingal = NO;
    cmd.strPlaceholder = @"Due From Date";
    cmd.strSelectedValue = @"Due From Date";
    cmd.strParameter = @"&due_date=";
    cmd.strValue = @"";
    
    cmd.isDate =  NO;
    cmd.btnTag = 10;
    cmd.imgAerro =  [UIImage imageNamed:@"Date.png"];
    
    cmd.strPlaceholder1 = @"Due To Date";
    cmd.strSelectedValue1 = @"Due To Date";
    cmd.strParameter1 = @"&due_date=";
    cmd.strValue1 = @"";
    
    cmd.isDate1 =  NO;
    cmd.btnTag1 = 11;
    cmd.imgAerro1 =  [UIImage imageNamed:@"Date.png"];
    return cmd;
}
-(CustomDataform *)Buttons{
    CustomDataform *cmd = [[CustomDataform alloc]init];
    cmd.isSingal = NO;
    cmd.Id = 00;
    return cmd;
}



@end
