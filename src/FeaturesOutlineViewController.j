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
  CPSearchField _searchField  @accessors(property=searchField, readonly);
  CPArray       _featureFiles @accessors(property=featureFiles);
  CPArray       _allFeatures;
  BOOL          _isSearching;
  CPArray       _searchResults;
  id            _delegate     @accessors(property=delegate);
}

- (id)initWithOutlineView:(CPOutlineView)outlineView 
              searchField:(CPSearchField)searchField
{
  self = [super init];
  if (self) {
    _featureFiles = [CPArray arrayWithArray:[]];
    _isSearching = NO;

    // Setup the Search Field
    _searchField = searchField;
    [_searchField setTarget:self];
    [_searchField setAction:@selector(didTypeSearch:)];

    // Setup the Outline View
    _outlineView = outlineView;
    [_outlineView setDelegate: self];
    [_outlineView setDataSource: self];

    // Set the background color to blue
    [_outlineView setBackgroundColor:[CPColor colorWithHexString:@"eef2f8"]];    
    [[[_outlineView enclosingScrollView] superview] setBackgroundColor:[CPColor colorWithHexString:@"eef2f8"]];    

    // Setup the text in the outline view
    var nameColumn = [_outlineView tableColumnWithIdentifier:@"name"];
    var textFieldPrototype = [nameColumn dataView];

    // Set the default text color
    [textFieldPrototype setValue:[CPColor colorWithCalibratedRed:71/255 green:90/255 blue:102/255 alpha:1]
               forThemeAttribute:"text-color"
                         inState:CPThemeStateTableDataView];
    [textFieldPrototype setValue:[CPColor colorWithCalibratedWhite:1 alpha:1]
               forThemeAttribute:"text-shadow-color"
                         inState:CPThemeStateTableDataView];
    [textFieldPrototype setValue:CGSizeMake(0,1) 
               forThemeAttribute:"text-shadow-offset"
                         inState:CPThemeStateTableDataView];

    // Set the selected text color
    [textFieldPrototype setValue:[CPColor colorWithCalibratedWhite:1 alpha:1.0]
               forThemeAttribute:"text-color"
                         inState:CPThemeStateTableDataView | CPThemeStateSelectedTableDataView];
    [textFieldPrototype setValue:[CPColor colorWithCalibratedWhite:0 alpha:0.5]
               forThemeAttribute:"text-shadow-color"
                         inState:CPThemeStateTableDataView | CPThemeStateSelectedTableDataView];
    [textFieldPrototype setValue:CGSizeMake(0,-1)
               forThemeAttribute:"text-shadow-offset"
                         inState:CPThemeStateTableDataView | CPThemeStateSelectedTableDataView];    

    // Set the prototype back to the column
    [nameColumn setDataView:textFieldPrototype];

  }
  return self;
}

- (void)setFeatureFiles:(CPArray)newFeatureFiles
{
  _featureFiles = newFeatureFiles;
  var sort = [[CPSortDescriptor alloc] initWithKey:@"title" ascending:YES];
  [_featureFiles sortUsingDescriptors:[sort]];
  [self reloadAllFeatures];
  [_outlineView reloadData];
}

-(void)didTypeSearch:(CPSearchField)aSearchField
{
  var searchString = [_searchField stringValue];
  if(searchString == @"") {
    _isSearching = NO;
  } else {
    var searchResults = [];
    var totalCount = [_allFeatures count];
    console.log(totalCount);
    for(var i = 0; i < totalCount; i++) {
      var obj = [_allFeatures objectAtIndex:i];
      if([obj title].match(new RegExp(searchString, "i"))) {
        searchResults.push(obj)
      }
    }
    _searchResults = searchResults;
    _isSearching = YES;
  }
  [_outlineView reloadData];
}

// Keeps a cache of all the feature files for searching
- (void)reloadAllFeatures
{
  _allFeatures = [CPArray arrayWithArray:[]];

  for(var i = 0; i < [_featureFiles count]; i++) {
    [_allFeatures addObjectsFromArray:[[_featureFiles objectAtIndex:i] scenarios]];
  }

  // Sort Alpha
  var sort = [[CPSortDescriptor alloc] initWithKey:@"title" ascending:YES];
  [_allFeatures sortUsingDescriptors:[sort]];
}

//
// CPOutlineView data delegate methods
//

- (id)outlineView:(CPOutlineView)outlineView child:(int)index ofItem:(id)item
{
  if(_isSearching) {
    return [_searchResults objectAtIndex:index];
  } else {
    if (item == NULL) {
        return [_featureFiles objectAtIndex:index];
    } else {
      return [[item scenarios] objectAtIndex:index];
    }
  }
}

- (BOOL)outlineView:(CPOutlineView)outlineView isItemExpandable:(id)item
{
    return [item isKindOfClass:[FeatureFile class]];
}

- (int)outlineView:(CPOutlineView)outlineView numberOfChildrenOfItem:(id)item
{
  if(_isSearching) {
    return [_searchResults count];
  } else {
    if (item == NULL) {
        return [_featureFiles count];
    } else if([item isKindOfClass:[FeatureFile class]]) {
      return [item scenariosCount];
    }
  }
}

- (id)outlineView:(CPOutlineView)outlineView objectValueForTableColumn:(CPTableColumn)tableColumn byItem:(id)item
{
    return [item title];   
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
    [_delegate scenarioWasSelected:selectedItem];
  }
}

@end
