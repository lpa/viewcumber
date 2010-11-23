@import <Foundation/CPObject.j>

@implementation ScenarioTableViewController : CPObject
{
  CPTableView tableView @accessors(readonly);
  CPArray _scenario @accessors(property=scenario);
  id _delegate @accessors(property=delegate); 
}

- (id)initWithTableView:(CPTableView)aTableView
{
  self = [self init];
  if (self) {
    tableView = aTableView;
    [tableView setDelegate: self];
    [tableView setDataSource: self];
    [tableView setTarget: self];
    [tableView setDoubleAction:@selector(rowDoubleClicked:)];
  }
  return self;
}

- (void)setScenario:(Scenario)scenario
{
  _scenario = scenario;
  [tableView reloadData];
  var firstRow = [CPIndexSet indexSetWithIndex:0];
  [tableView selectRowIndexes:firstRow byExtendingSelection:NO];
}

// Data Source Methods
- (int)numberOfRowsInTableView:(CPTableView)theTableView
{
  return [_scenario stepsCount];
}

- (id)tableView:(CPTableView)theTableView 
      objectValueForTableColumn:(CPTableColumn)column 
      row:(int)index
{
  var step = [[_scenario steps] objectAtIndex:index];
  if ([column identifier] === @"title") {
    return [step title];
  } else if ([column identifier] === @"keyword") {
    return [step keyword];
  }
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
  if (_delegate &&
      [_delegate respondsToSelector:(@selector(stepWasSelected:))]) {
    [_delegate stepWasSelected:[[_scenario steps] objectAtIndex:[tableView selectedRow]]];
  }
}

- (void)rowDoubleClicked:(id)sender
{
  if (_delegate &&
      [_delegate respondsToSelector:(@selector(stepWasDoubleClicked:))]) {
    [_delegate stepWasDoubleClicked:[[_scenario steps] objectAtIndex:[tableView selectedRow]]];
  }
}

@end
