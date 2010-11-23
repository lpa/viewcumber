@import <AppKit/CPViewController.j>
@import "Step.j"

@implementation MailViewController : CPViewController
{
  CPTableView tableView;
  CPWebView   webView;
  Step        _step     @accessors(property=step);
}

- (id)init
{
  [self initWithCibName:@"MailView" bundle: nil];
}

- (void)setStep:(Step)newStep
{
  console.log("Setting step: " + [newStep emails]);
  _step = newStep;
  [tableView reloadData];
}

// TableView Delegate Methods
- (int)numberOfRowsInTableView:(CPTableView)aTableView
{
  return [[_step emails] count];
}

- (id)tableView:(CPTableView)aTableView
      objectValueForTableColumn:(CPTableColumn)column
      row:(int)index
{
  var value;
  var email = [[_step emails] objectAtIndex:index]; 
  var cid = [column identifier];

  console.log([email htmlURL]);

  if (cid === @"to") {
    value = [email toStringValue];
  } else if (cid === @"from") {
    value = [email fromStringValue];
  } else if (cid === @"subject") {
    value = [email subject];
  }
  return value;
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
  var email = [[_step emails] objectAtIndex:[tableView selectedRow]];
  [webView setMainFrameURL:[email htmlURL]];
}

@end
