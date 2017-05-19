//
//  DropDownListView.m
//  KDropDownMultipleSelection
//
//  Created by macmini17 on 03/01/14.
//  Copyright (c) 2014 macmini17. All rights reserved.
//

#import "DropDownListView.h"
#import "DropDownViewCell.h"
#import "CustomData.h"

#define DROPDOWNVIEW_SCREENINSET 0
#define DROPDOWNVIEW_HEADER_HEIGHT 0.
#define RADIUS 5.0f


@interface DropDownListView (private)
- (void)fadeIn;
- (void)fadeOut;
@end
@implementation DropDownListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)aTitle options:(NSMutableArray *)aOptions options1:(NSMutableArray *)aOptions1 xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    isMultipleSelection=isMultiple;
    float height = MIN(size.height, DROPDOWNVIEW_HEADER_HEIGHT+[aOptions count]*44);
   CGRect rect = CGRectMake(point.x, point.y, size.width, height);
    //CGRect rect = CGRectMake(50, 100, 320, 200);
    chekEro=size.width;
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2.5, 2.5);
        self.layer.shadowRadius = 2.0f;
        self.layer.shadowOpacity = 0.5f;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor =[[UIColor grayColor]CGColor];
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        
        arrayDemo = [[NSMutableArray alloc]init];
        _kTitleText = [aTitle copy];
        _kDropDownOption = [[NSMutableArray alloc]initWithArray:aOptions];
        arrayShort1 = [[NSMutableArray alloc]initWithArray:aOptions];

        arrayShort = [[NSMutableArray alloc]initWithArray:aOptions1];
        self.arryData=[[NSMutableArray alloc]init];
        UIImageView *TitleImg =  [[UIImageView alloc] initWithFrame:CGRectMake(1,  1, size.width-1 ,DROPDOWNVIEW_HEADER_HEIGHT-1)];
        TitleImg.image = [UIImage imageNamed:@"he.png"];
       // [self addSubview:TitleImg];
        
        UIView *TitleView =  [[UIView alloc] initWithFrame:CGRectMake(1,  1, size.width-1 ,DROPDOWNVIEW_HEADER_HEIGHT-1)];
        TitleView.backgroundColor=[UIColor clearColor];//[self colorWithHexString:@"fe7500"];
       // TitleView.layer.borderWidth = 1.0;
      //  TitleView.layer.borderColor =[[UIColor grayColor]CGColor];
       // TitleView.layer.cornerRadius = 5.0;
        //TitleView.layer.masksToBounds = YES;
 
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5,  0, size.width-10, 45)];
        lblTitle.text =_kTitleText;
         UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        lblTitle.font = font;
        lblTitle.textColor = [UIColor whiteColor];
        
       // [TitleView addSubview:lblTitle];
       // [self addSubview:TitleView];
        
        if (isMultipleSelection) {
            UIView *TitleSearch =  [[UIView alloc] initWithFrame:CGRectMake(1,  DROPDOWNVIEW_HEADER_HEIGHT, size.width-1 ,DROPDOWNVIEW_HEADER_HEIGHT)];
            
            TitleSearch.layer.borderWidth = 1.0;
            TitleSearch.layer.borderColor =  (__bridge CGColorRef _Nullable)([UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:A]);//=[[UIColor grayColor]CGColor];
            TitleSearch.backgroundColor=[self colorWithHexString:@"FFFFFF"];
           
            UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0,DROPDOWNVIEW_HEADER_HEIGHT-1, size.width, 1)];
            
            lblLine.backgroundColor = [self colorWithHexString:@"d1d1d1"];
            [TitleSearch addSubview:lblLine];
            
           // [TitleView addSubview:TitleSearch];
            UIButton *btnDone1=[UIButton  buttonWithType:UIButtonTypeCustom];
            // [btnDone setFrame:CGRectMake(rect.origin.x+182,rect.origin.y-45, 82, 31)];
            [btnDone1 setFrame:CGRectMake(size.width-72,(DROPDOWNVIEW_HEADER_HEIGHT-31)/2, 64, 32)];
            
            [btnDone1 setImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
            [btnDone1 addTarget:self action:@selector(Click_Don) forControlEvents: UIControlEventTouchUpInside];
            //   [self addSubview:btnDone1];
            [TitleView addSubview:btnDone1];
            
          
            
            UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
           // [btnDone setFrame:CGRectMake(rect.origin.x+182,rect.origin.y-45, 82, 31)];
             [btnDone setFrame:CGRectMake(size.width-72,((DROPDOWNVIEW_HEADER_HEIGHT-30)/2), 64, 32)];
            [btnDone setImage:[UIImage imageNamed:@"search-btn.png"] forState:UIControlStateNormal];
            [btnDone addTarget:self action:@selector(Click_Done) forControlEvents: UIControlEventTouchUpInside];
            //[self addSubview:btnDone];
             [TitleSearch addSubview:btnDone];
            
            
            
            txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(10, (DROPDOWNVIEW_HEADER_HEIGHT-31)/2,size.width -10-82, 31)];
            
            txtSearch.backgroundColor=[self colorWithHexString:@"f5f5f5"];//[UIColor grayColor];
            txtSearch.layer.borderWidth = 1.0;
            txtSearch.delegate  = self;
            txtSearch.layer.borderColor =[[self colorWithHexString:@"e9e9e9"] CGColor];
           // txtSearch.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:A]);//colorWithRed:R/255 green:G/255 blue:B/255 alpha:A] setFill];
          //  txtSearch.layer.borderColor =[[UIColor clearColor]CGColor];
            txtSearch.layer.cornerRadius = 5.0;
            txtSearch.layer.masksToBounds = YES;
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
            txtSearch.leftView = paddingView;
            txtSearch.leftViewMode = UITextFieldViewModeAlways;
            
            [txtSearch addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
            [TitleSearch addSubview:txtSearch];
            tblY = 0;//DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT+(DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT);
            tblH = rect.size.height - 2 * DROPDOWNVIEW_SCREENINSET - DROPDOWNVIEW_HEADER_HEIGHT - RADIUS-(DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT);
            lblTitle.textAlignment = NSTextAlignmentLeft;
            
            
            UIButton *btnReferesh1=[UIButton  buttonWithType:UIButtonTypeCustom];
            // [btnDone setFrame:CGRectMake(rect.origin.x+182,rect.origin.y-45, 82, 31)];
            [btnReferesh1 setFrame:CGRectMake((size.width -10-82)-15,((DROPDOWNVIEW_HEADER_HEIGHT-25)/2), 25, 25)];
            [btnReferesh1 setBackgroundColor:[UIColor clearColor]];
            //[btnReferesh1 setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
            [btnReferesh1 addTarget:self action:@selector(Click_Referesh) forControlEvents: UIControlEventTouchUpInside];
            //[self addSubview:btnDone];
            [TitleSearch addSubview:btnReferesh1];
            
            
            UIButton *btnReferesh=[UIButton  buttonWithType:UIButtonTypeCustom];
            // [btnDone setFrame:CGRectMake(rect.origin.x+182,rect.origin.y-45, 82, 31)];
            [btnReferesh setFrame:CGRectMake((size.width -10-82)-12,((DROPDOWNVIEW_HEADER_HEIGHT-12)/2), 12, 12)];
            
            [btnReferesh setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
            [btnReferesh addTarget:self action:@selector(Click_Referesh) forControlEvents: UIControlEventTouchUpInside];
            //[self addSubview:btnDone];
            [TitleSearch addSubview:btnReferesh];
            
             [self addSubview:TitleSearch];
        }
        else{
            tblY = 0;//DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT;
            tblH = rect.size.height - 2 * DROPDOWNVIEW_SCREENINSET - DROPDOWNVIEW_HEADER_HEIGHT - RADIUS-(DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT)+(DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT);
            lblTitle.textAlignment = NSTextAlignmentCenter;
        }
      //  [TitleView addSubview:lblTitle];
        //[self addSubview:TitleView];
        
        _kTableView = [[UITableView alloc] initWithFrame:CGRectMake(DROPDOWNVIEW_SCREENINSET+1,
                                                                   tblY,
                                                                   rect.size.width - 4 * DROPDOWNVIEW_SCREENINSET-5,tblH)];
        _kTableView.separatorColor = [UIColor colorWithWhite:1 alpha:.2];
        _kTableView.separatorInset = UIEdgeInsetsZero;
        _kTableView.backgroundColor = [UIColor clearColor];//[self colorWithHexString:@"f5f5f5"];//
        _kTableView.dataSource = self;
        _kTableView.delegate = self;
        [self addSubview:_kTableView];
                /*[textField addTarget:self
    action:@selector(textFieldDidChange:)
    forControlEvents:UIControlEventEditingChanged];
         */
    }
    NSLog(@"Refresh ");

    return self;
}

-(void)Click_Referesh{
    NSLog(@"Refresh ");
    [self testing];
    //arrayShort1 = [NSMutableArray arrayWithArray:_kDropDownOption];
    txtSearch.text = @"";
    strTemp= @"";
    [self shortText];
   // [_kTableView reloadData];
}

-(void)textFieldDidChange :(UITextField *) textField{
    NSLog(@"Change text %@",textField.text);
  //  NSString *searchText;
    strTemp = textField.text;
    /*
    searchText =textField.text;
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@ ",
                                    searchText];
    self.filltereList = (NSMutableArray *)[arrayShort filteredArrayUsingPredicate:resultPredicate];
    if ([@"Empty" isEqualToString:[self whitSpace:textField.text]]) {
        arrayShort1 = [NSMutableArray arrayWithArray:_kDropDownOption];
    }else
        [self shortText];
     */
 }
-(void)testing{
    for (int i=0; i<arrayDemo.count; i++) {
        for (int k=0; k<_kDropDownOption.count; k++) {
            if ([[arrayDemo objectAtIndex:i] isEqualToString:[[_kDropDownOption objectAtIndex:k]strPropertyAddress]]) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strPropertyAddress =[[_kDropDownOption objectAtIndex:k]strPropertyAddress];
                cmd.strId = [[_kDropDownOption objectAtIndex:k]strId];
                cmd.strDay = @"1";
                [_kDropDownOption replaceObjectAtIndex:k withObject:cmd];
            }
        }
    }
}

-(void)shortText{
    [self testing];
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@ ",
                                    strTemp];
    
    self.filltereList = (NSMutableArray *)[arrayShort filteredArrayUsingPredicate:resultPredicate];
    if ([@"Empty" isEqualToString:[self whitSpace:strTemp]]) {
        
        arrayShort1 = [NSMutableArray arrayWithArray:_kDropDownOption];
    }else
    {
        
    arrayShort1 = [[NSMutableArray alloc]init];
    for (int j = 0;j<self.filltereList.count;j++){
        NSString *test;
        NSString *tesFilter = [self.filltereList objectAtIndex:j];
        for (int i=0; i<_kDropDownOption.count; i++) {
            test = [[_kDropDownOption objectAtIndex:i]strPropertyAddress];
            if ([test isEqualToString:tesFilter]) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strPropertyAddress = [[_kDropDownOption objectAtIndex:i]strPropertyAddress];
                cmd.strId = [[_kDropDownOption objectAtIndex:i]strId];
                cmd.strDay = [[_kDropDownOption objectAtIndex:i]strDay];
                NSLog(@"COUNT SELECTED %lul",(unsigned long)arrayDemo.count);

               /* for (int k=0; k<arrayDemo.count; k++) {
                    if ([[arrayDemo objectAtIndex:k] isEqualToString:test]) {
                        cmd.strDay = @"1";
                    }else{
                    }
                }
 */
                [arrayShort1 addObject:cmd];

                //NSLog(@"find  : == %@",[[_kDropDownOption objectAtIndex:i]strPropertyAddress]);
            }
        }
    }
    }
    arrayDemo = [[NSMutableArray alloc]init];
    [_kTableView reloadData];
}

-(NSString *)whitSpace:(NSString *)param{
    NSString *rawString = param;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0)
        return @"Empty";
    else
        return @"NotEmpty";
}

-(void)Click_Don{
    //[self shortText];
    [txtSearch resignFirstResponder];
    
     if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownListView:Datalist:)]) {
     NSMutableArray *arryResponceData=[[NSMutableArray alloc]init];
     //  NSLog(@"%@",self.arryData);
     for (int k=0; k<arrayShort1.count; k++) {
         if ([[[arrayShort1 objectAtIndex:k]strDay] isEqualToString:@"1"]) {
             CustomData *cmd = [[CustomData alloc]init];
             cmd.strPropertyAddress = [[arrayShort1 objectAtIndex:k]strPropertyAddress];
             cmd.strId = [[arrayShort1 objectAtIndex:k]strId];
             cmd.strDay = [[arrayShort1 objectAtIndex:k]strDay];
             [arryResponceData addObject:cmd];
         }
    // NSIndexPath *path=[self.arryData objectAtIndex:k];
     //[arryResponceData addObject:[_kDropDownOption objectAtIndex:path.row]];
     //     NSLog(@"pathRow=%ld",(long)path.row);
     }
     
     [self.delegate DropDownListView:self Datalist:arryResponceData];
     
     }
     // dismiss self
     [self fadeOut];
   
}


-(void)Click_Done{
    [self shortText];
    /*
    if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownListView:Datalist:)]) {
        NSMutableArray *arryResponceData=[[NSMutableArray alloc]init];
      //  NSLog(@"%@",self.arryData);
        for (int k=0; k<self.arryData.count; k++) {
            NSIndexPath *path=[self.arryData objectAtIndex:k];
            [arryResponceData addObject:[_kDropDownOption objectAtIndex:path.row]];
       //     NSLog(@"pathRow=%ld",(long)path.row);
        }
    
        [self.delegate DropDownListView:self Datalist:arryResponceData];
        
    }
    // dismiss self
    [self fadeOut];
     */
}
#pragma mark - Private Methods
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // arrayDemo = [[NSMutableArray alloc]init];
    [nomatchesView removeFromSuperview];
    if (arrayShort1.count ==0) {
        [self noDataFound];
    }else{
        [nomatchesView removeFromSuperview];
    }
    return [arrayShort1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"DropDownViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    cell = [[DropDownViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor blackColor];
    [cell.textLabel setFont: [cell.textLabel.font fontWithSize: 12]];

    int row = (int)[indexPath row];
    UIImageView *imgarrow=[[UIImageView alloc]init ];
    
   
    if ([[[arrayShort1 objectAtIndex:indexPath.row]strDay] isEqualToString:@"1"]){
        imgarrow.frame=CGRectMake(chekEro-35,12, 22, 22);
        imgarrow.image=[UIImage imageNamed:@"tick.png"];
	} else
        imgarrow.image=nil;
    
    [cell addSubview:imgarrow];
    cell.textLabel.text = [[arrayShort1 objectAtIndex:row]strPropertyAddress] ;
    if (isMultipleSelection) {
        
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"";
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, chekEro-10, 43)];
        lbl.text =[[arrayShort1 objectAtIndex:row]strPropertyAddress];
        
        lbl.textAlignment = NSTextAlignmentCenter;
       // [lbl setFont:[UIFont fontWithName:@"System" size:8]];
        [lbl setFont: [lbl.font fontWithSize: 12]];

        [cell addSubview:lbl];
    }
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0,43, chekEro+2, 1)];
    
    lblLine.backgroundColor = [self colorWithHexString:@"d1d1d1"];
    [cell addSubview:lblLine];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"id of row path %@",[[arrayShort1 objectAtIndex:indexPath.row]strPropertyAddress]);
    if (isMultipleSelection) {
        if ([[[arrayShort1 objectAtIndex:indexPath.row]strDay] isEqualToString:@"0"]) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd.strPropertyAddress = [[arrayShort1 objectAtIndex:indexPath.row]strPropertyAddress];
            cmd.strId = [[arrayShort1 objectAtIndex:indexPath.row]strId];
            cmd.strDay = @"1";
            [arrayShort1 replaceObjectAtIndex:indexPath.row withObject:cmd];
            [arrayDemo addObject:cmd.strPropertyAddress];

        }else{
            CustomData *cmd = [[ CustomData alloc]init];
            cmd.strPropertyAddress = [[arrayShort1 objectAtIndex:indexPath.row]strPropertyAddress];
            cmd.strId = [[arrayShort1 objectAtIndex:indexPath.row]strId];
            cmd.strDay = @"0";
            [arrayShort1 replaceObjectAtIndex:indexPath.row withObject:cmd];
            [arrayDemo removeObject:cmd.strPropertyAddress];

           //   [arrayDemo removeObjectAtIndex:indexPath.row];
        }
        /*
        if([self.arryData containsObject:indexPath]){
            [self.arryData removeObject:indexPath];
        } else {
            [self.arryData addObject:indexPath];
        }
         */
        [tableView reloadData];

    } else {
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownListView:didSelectedIndex:)]) {
            [self.delegate DropDownListView:self didSelectedIndex:[indexPath row]];
        }
        // dismiss self
        [self fadeOut];
    }
	
}

#pragma mark - TouchTouchTouch
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // tell the delegate the cancellation
}

#pragma mark - DrawDrawDraw
/*
- (void)drawRect:(CGRect)rect {
    CGRect bgRect = CGRectInset(rect, DROPDOWNVIEW_SCREENINSET, DROPDOWNVIEW_SCREENINSET);
    CGRect titleRect = CGRectMake(DROPDOWNVIEW_SCREENINSET + 10, DROPDOWNVIEW_SCREENINSET + 10 + 5,
                                  rect.size.width -  2 * (DROPDOWNVIEW_SCREENINSET + 10), 30);
    CGRect separatorRect = CGRectMake(DROPDOWNVIEW_SCREENINSET, DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT - 2,
                                      rect.size.width - 2 * DROPDOWNVIEW_SCREENINSET, 2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Draw the background with shadow
    [[UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:A] setFill];
    
    float x = DROPDOWNVIEW_SCREENINSET;
    float y = DROPDOWNVIEW_SCREENINSET;
    float width = bgRect.size.width;
    float height = bgRect.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, x, y + RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y, x + RADIUS, y, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y, x + width, y + RADIUS, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y + height, x + width - RADIUS, y + height, RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y + height, x, y + height - RADIUS, RADIUS);
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
    
    // Draw the title and the separator with shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(1, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithWhite:1 alpha:1.] setFill];
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        UIColor *cl=[UIColor whiteColor];
        
        NSDictionary *attributes = @{ NSFontAttributeName: font,NSForegroundColorAttributeName:cl};
        [_kTitleText drawInRect:titleRect withAttributes:attributes];
    }
    else
        [_kTitleText drawInRect:titleRect withFont:[UIFont systemFontOfSize:16.]];
    CGContextFillRect(ctx, separatorRect);
    

}
*/

-(void)noDataFound{
    nomatchesView = [[UIView alloc] initWithFrame:CGRectMake(0,0,_kTableView.frame.size.width,_kTableView.frame.size.height)];
    nomatchesView.backgroundColor = [UIColor clearColor];
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,_kTableView.frame.size.width,_kTableView.frame.size.height)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    //   matchesLabel.minimumFontSize = 12.0f;
    matchesLabel.numberOfLines = 1;
    [matchesLabel setFont: [matchesLabel.font fontWithSize: 16]];
    matchesLabel.lineBreakMode = NSLineBreakByWordWrapping;
    matchesLabel.textAlignment = NSTextAlignmentCenter;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor clearColor];
    matchesLabel.text = @"No Record Found";
    [nomatchesView addSubview:matchesLabel];
    [_kTableView insertSubview:nomatchesView belowSubview:_kTableView];
}


-(UIColor*)colorWithHexString:(NSString*)hex{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



-(void)SetBackGroundDropDown_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alph {
    R=r;
    G=g;
    B=b;
    A=alph;
}

@end
