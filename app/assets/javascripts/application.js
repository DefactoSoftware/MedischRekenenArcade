// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.ui.draggable
//= require twitter/bootstrap
//= require turbolinks
//= require calculator

$(document).on('mouseenter', '#badges_block a.thumb-link', function(e) {
  var $inner = $(this).find('.caption .inner');
  $inner.css( 'bottom', $inner.children('.more').outerHeight(true) );

}).on('mouseleave', '#badges_block a.thumb-link', function(e) {
  $(this).find('.caption .inner').css('bottom', 0);
});

$("#calculator").ready(function() {
  $("#calculator").draggable();
})

//Functions for making answering view interactive
$(".unit_select").ready(function() {
  $(".unit_select").on("click", function(element){
    $("#selectedUnit").html($(element.target)[0].dataset.sign + " ▼");
  });
  if($(".unit_select").length > 0) {
    $(".unit_select")[0].click();
  }
});

var update_profile_picture = function(event) {
  $("#preview_profile_picture").attr("src", event.fpfile.url)
}

$("#change_password_block").ready(function() {
  $("#change_password_link").on("click", function() {
    $("#change_password_block").toggle();
  });
});

$("#add_user_group_link").ready(function() {
  $("#add_user_group_link").on("click", function() {
    $("#add_user_group_block").toggle();
    $("#add_user_group_background").toggle();
  });
  $("#add_user_group_background").on("click", function(){
    $("#add_user_group_block").toggle();
    $("#add_user_group_background").toggle();
  })
});

$(".thumb-link").ready(function() {
  $(".thumb-link").popover({html: true, trigger: "hover", placement: "right"});
});

$("#skipQuestion").ready(function() {
  $("#skipQuestion").on("click", function(e) {
    event.preventDefault();
    location.reload();
  });
});

$("#helpQuestion").ready(function() {
  $("#helpQuestion").on("click", function(e) {
    event.preventDefault();
    elements = $(".help");
    for(var i = 0; i < elements.length; i++) {
      $(elements[i]).toggle()
    }
  })
});

$("#close_calculator").ready(function() {
  $("#close_calculator").on("click", function(e) {
    event.preventDefault();
    elements = $(".help");
    for(var i = 0; i < elements.length; i++) {
      $(elements[i]).hide()
    }
  })
});

$("#new_user_group").ready(function() {
  $("#submit_user_group").on("click", function() {
    $("#new_user_group").submit();
  });
  $("#user_group_name").on("keypress", function(e){
    var code = e.keyCode || e.which;
    if(code == 13) {
      e.preventDefault();
      $("#new_user_group").submit();
    }
  })
})

//Submitting answer form
$("#answer_value").ready(function() {
  $("#answer_value").focus()
  $("#submit_answer").on("click", function() {
    $("#answer_value").parent().parent().parent().submit();
  })
  $("#answer_value").on("keypress", function(e){
    var code = e.keyCode || e.which;
    if(code == 13) {
      e.preventDefault();
      $("#answer_value").parent().parent().parent().submit();
    }
  })
});

$("#time_left").ready(function reload_time() {
  if($("#time_left").length > 0) {
    var time=$("#time_left").html();
    var minutes = time.split(":")[0];
    var seconds = time.split(":")[1];
    if(seconds > 0) {
      seconds--;
    }
    else if(seconds <= 0 && minutes > 0) {
      seconds = 60;
      minutes--;
    }
    else {
      window.alert("Time is up!");
      location.reload();
    }
    $("#time_left").html(trailing_zero(minutes)+":"+trailing_zero(seconds))
    setTimeout(reload_time, 1000);
  }
});

var trailing_zero = function(n) {
  if (n.length < 2) {
    return "0"+n;
  }
  else {
    return n;
  }
}

$("#toggle_feedback").ready(function() {
  $("#toggle_feedback").on("click", function(){
    $("#feedback_background").toggle();
    $("#feedback_report").toggle();
  });
  $("#feedback_background").on("click", function(){
    $("#feedback_report").toggle();
    $("#feedback_background").toggle();
  })
})

//Functions to close alerts and notices
$(document).ready(function() {
  setTimeout(function () { closeNotices(); closeAlerts(); }, 10000);
});

$(document).ready(function() {
  setTimeout(function () { $("#notification").fadeOut() }, 5000 );
});

var closeNotices = function() {
  elements = $(".notice_block");
  for(var i =0; i<elements.length; i++) {
    $(elements[i]).css('display', 'none');
  }
}

var closeAlerts = function() {
  elements = $(".alert");
  for(var i =0; i<elements.length; i++) {
    $(elements[i]).css('display', 'none');
  }
}

//Function for highlighting variables
var color_vars = function(element) {
  var html = $(element).html();
  var split = html.split(" ");
  var newhtml = "";
  for(var i = 0; i < split.length; i++) {
    var part = "";
    if(hasNumbers(split[i])) {
      part = " <span class='highlight'>"+split[i]+"</span> ";
    }
    else {
      part = " "+split[i];
    }
    newhtml = newhtml + part;
  }
  $(element).html(newhtml);
};

$(document).ready(function() {
  if($("#theory").lenght > 0) {
    color_vars($("#theory"));
  }
});

function hasNumbers(t) {
  return /\d/.test(t);
}

$("#_problem").ready(function() {
  $("#_problem").on("change", function() {
    $("#problem_picker").submit();
  })
})
