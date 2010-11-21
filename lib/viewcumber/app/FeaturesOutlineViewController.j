/*
 * FeaturesOutlineViewController..j
 * ViewCumber
 *
 * Implements dataSource and delegate methods for the
 * features CPOutlineView.
 */

@import <Foundation/CPObject.j>

@implementation FeaturesOutlineViewController : CPObject
{
  CPOutlineView _outlineView  @accessors(property=outlineView, readonly);
  CPArray       _featureFiles @accessors(property=featureFiles);
  id            _delegate     @accessors(property=delegate);
}

- (id)initWithOutlineView:(CPOutlineView)outlineView
{
  self = [super init];
  if (self) {
    _featureFiles = [CPArray arrayWithArray:[]];
    _outlineView = outlineView;
    [_outlineView setDelegate: self];
    [_outlineView setDataSource: self];
  }
  return self;
}

- (void)setFeatureFiles:(CPArray)newFeatureFiles
{
  _featureFiles = newFeatureFiles;
  [_outlineView reloadData];
}

- (id)outlineView:(CPOutlineView)outlineView child:(int)index ofItem:(id)item
{
    if (item == NULL) {
        return [_featureFiles objectAtIndex:index];
    } else {
      return [[item scenarios] objectAtIndex:index];
    }
}

- (BOOL)outlineView:(CPOutlineView)outlineView isItemExpandable:(id)item
{
    return [item isKindOfClass:[FeatureFile class]];
}

- (int)outlineView:(CPOutlineView)outlineView numberOfChildrenOfItem:(id)item
{
    if (item == NULL) {
        return [_featureFiles count];
    } else if([item isKindOfClass:[FeatureFile class]]) {
      return [item scenariosCount];
    }
}

- (id)outlineView:(CPOutlineView)outlineView objectValueForTableColumn:(CPTableColumn)tableColumn byItem:(id)item
{
    return [item title];   
}

// TODO: Get this working.
- (BOOL)outlineView:(CPOutlineView)outlineView shouldSelectItem:(id)item
{
  CPLog("Select item %@", item);
  return NO;
}

/*
  Emits the delegate method scenarioWasSelected:(Scenario)
*/
- (void)outlineViewSelectionDidChange:(CPNotification)notification
{
  var outlineView = [notification object];
  var selectedItem = [outlineView itemAtRow:[outlineView selectedRow]];
  if (_delegate && 
      [_delegate respondsToSelector:@selector(scenarioWasSelected:)] && 
      [selectedItem isKindOfClass:[Scenario class]]) {
    CPLog("Scenario is set to: %@", selectedItem);
    [_delegate scenarioWasSelected:selectedItem];
  }
}

@end
