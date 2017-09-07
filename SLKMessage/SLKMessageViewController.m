//
//  SLKMessageViewController.m
//  SLKMessage
//
//  Created by saix on 2017/9/5.
//  Copyright © 2017年 sai. All rights reserved.
//

#import "SLKMessageViewController.h"
#import "SLKMessageCell.h"

@interface SLKMessageViewController ()
@property (nonatomic, strong)  SLKMessageCell *prototypeCell;
//@property (strong, nonatomic) NSCache *cache;
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation SLKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.prototypeCell = [[[NSBundle mainBundle] loadNibNamed:@"SLKMessageCell" owner:self options:nil] objectAtIndex:0];

    
    self.messages = [@[] mutableCopy];
    for(NSUInteger index = 0; index<100;++index){
        SLKMessageModel* model = [SLKMessageModel new];
        if(index%3 == 0) {
            model.message = [NSString stringWithFormat:@":copyright: `g` <@saix> :sweat_smile:\n%@ + ran `d` om :\n %@", @"&gt;&gt;&gt;&gt; &gt;&gt;  &gt;p\nA\n`AAA`\n&gt; *&gt;&gt;<@1234>* _&gt;<@1235>_ fdsfdsf dsfdsfdsfdsfdsfdsfdsfdsfdsfdsfdsfdsfdsf fdsfdsfds :smile::sweat_smile: :sweat_smile: \n_&gt;<@1235>_ ", @(rand())];

        }
        else if(index%3 == 1) {
            model.message = [NSString stringWithFormat:@":copyright: `g` <@saix> :sweat_smile: %@ + ran `d` om : %@", @"A\n&gt;&gt;&gt;p \n&gt;_B_ ~*_A_ ~C~* XXXX _B_~ _c_ kkkk _ZZZZ_ ~AAAAA _BBBBBB_~ * *A* * AAAAA \nC \n&gt;fdfd `code codecode codecodecodec odec odeco decodecodecode`\nA\n```if(a) `:smile_cat:`\nelse :sweat_smile: *A* ```\n:smile_cat: `*A*` `:smile_cat:`", @(rand())];

        }
        else {
            model.message = [NSString stringWithFormat:@":copyright: :woman-heart-woman:  :woman-heart-woman::skin-tone-2:\u200D\u2642 :woman-heart-woman::skin-tone-2:\u200D:skin-tone-2:"];

        }
        model.height = -1;
        [self.messages addObject:model];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SLKMessageModel* message = self.messages[indexPath.row];
//    if(message.height>0) {
//        return message.height;
//    }
//    return UITableViewAutomaticDimension;
//
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SLKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SLKMessageCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SLKMessageCell" owner:self options:nil] objectAtIndex:0];
        cell.tableView = tableView;
    }
    SLKMessageModel* message = self.messages[indexPath.row];

    cell.message = message;
//    [self.cache setObject:cell.message forKey:<#(nonnull id)#>]
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
