@import <Foundation/CPObject.j>
@import "Step.j"

@implementation Scenario : CPObject
{
  CPString _title @accessors(property=title);
  CPArray _steps @accessors(property=steps);
}

+ (CPArray)scenariosFromCucumberJSON:(Object)json
{
  var scenarios = [CPArray arrayWithArray:[]];
  for(var i = 0; i < json.length; i++) {
    [scenarios addObject:[Scenario scenarioFromCucumberJSON:json[i]]];
  }
  return scenarios;
}

+ (id)scenarioFromCucumberJSON:(Object)json
{
  var steps = [Step stepsFromCucumberJSON:json.steps];
  var scenario = [[Scenario alloc] init];
  [scenario setTitle:json.name];
  [scenario setSteps:steps];
  return scenario;
}

- (int)stepsCount
{
  return [_steps count];
}
@end
