var Cucumber = {
  // Gets set to the a tag of the current cuke
  current: null,


  currentScenarioTitle: function(){
    return this.current.closest(".scenario").find("h3:first").text();
  },

  currentFeatureTitle: function(){
    return this.current.closest(".feature").find("h2:first").text();
  },

  currentTitle: function(){
    return this.currentFeatureTitle() + ": " + this.currentScenarioTitle();
  },

  // Accepts the a object for the step to move to
  moveTo: function(step){
    $(".cucumber").slideUp();
    $("#viewport").show();
    $("#navigator").show();

    step = $(step);
    var newPath = step.find("a")[0] ? step.find("a")[0].href : "viewless.html";
    window.frames["viewport"].location.href = newPath;

    if(this.current) this.current.removeClass("current");
    this.current = step;
    this.current.addClass("current");

    // Setup the title
    $("#navigator #step-name").html(this.current.text());
    $("#navigator #step-title").html(this.currentTitle());

    // Toggle Prev Button
    if(this.current[0] == this.current.closest("ol").find("li:first")[0]) {
      $("#prev-btn").hide();
    } else {
      $("#prev-btn").show();
    }

    // Toggle Next Button
    if(this.current[0] == this.current.closest("ol").find("li:last")[0]) {
      $("#next-btn").hide();
    } else {
      $("#next-btn").show();
    }
  },

  next: function(){
    // Find the next list item
    var nextLi = this.current.next()[0];

    // Assuming ther's a next list item
    if(nextLi) {
      this.moveTo(nextLi);
    }

    // TODO: if current step is null
    // TODO: Move to the next scenario
    // TODO: Move to the next feature
  },

  previous: function(){
    var prevLi = this.current.prev()[0];
    if(prevLi) {
      this.moveTo(prevLi);
    }
  },

  changeScenario: function(){
    $(".cucumber").slideToggle();
  }
}

$(function(){
  $(".scenario h3, .background h3").click(function(){
    Cucumber.moveTo($(this).closest("li").find(".step:first")[0]);
  });
  $(".step").click(function(){
    Cucumber.moveTo(this);
  });
});