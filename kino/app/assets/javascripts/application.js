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
function addCountry() {
    var currentCountry = $( "#country_select option:selected" );
    if (currentCountry.length > 0) {
        $( "#selected_countries").append('<span class="float-l ml-5 mt-5 label label-default" name="movie_countries[c_' + currentCountry.val() + ']" class="ml-5 label label-default">'+ currentCountry.text() +'</span>');
        currentCountry.remove();
    }
}

function addStar() {
    var stars = $( "#star_select" );
    if (stars.val().length > 0) {
        $( "#selected_stars").append('<li class="" name="movie_countries[c_' + stars.length + ']" class="ml-5 label label-default">'+ stars.val() +'</li>');
        stars.val("").focus();
    }
}