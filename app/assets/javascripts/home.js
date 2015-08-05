// $(function(){  // $(document).ready shorthand
// 	$('#homedesc').hide().delay(2500).fadeIn('slow');
// 	$('.btn').hide().delay(2500).fadeIn('slow');
// });
$(document).ready(function() {

    $("#homedesc").animate({left: "0"}, {
    duration: 2000       
    });
    $("#two").animate({left: "0"}, {
    duration: 2250
    });
    $("#three").animate({left: "0"}, {
    duration: 2500        
    });
});

var target = $("#target");
target.html(target.text().replace(/./g, "<span>$&</span>"));

jQuery(function($) {

  var target = $("#target");
  target.html(target.text().replace(/./g, "<span>$&</span>"));

  setTimeout(runAnimation, 250);

  function runAnimation() {
    var index, spans;

    index = 0;
    spans = target.children();
    doOne();

    function doOne() {
      var span = $(spans[index]);
      if (!$.trim(span.text())) {
        // Skip blanks
        next();
        return;
      }
 // Do this one
      span.css({
        position: "relative",
      }).animate({
        top: "-20"
      }, "fast").animate({
        top: "0"
      }, "fast", function() {
        span.css("position", "");
        next();
      });
    }


    function stop(){
        //does nothing
    }

    function next() {
      ++index;
      if (index < spans.length) {
        doOne();
      }
      else {
        stop();
      }
    }
  }

});



