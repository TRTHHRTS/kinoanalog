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
    var currentCountry = $( "select#country_select option:selected" );
    if (currentCountry.length > 0) {
        var selectedCountries = $("#selected_countries");
        selectedCountries.addClass("h30");
        cVal = currentCountry.val();
        cName = currentCountry.text();
        selectedCountries.append('<span class="float-l ml-5 mt-5 label label-default" class="ml-5 label label-default">'+ cName +'</span>');

        selectedCountries.append($('<input type="hidden" value="' + cName + '" name="countries[]" readonly/>'));

        currentCountry.remove();
    }
}

function addDirector() {
    var director = $( "#director_select" );
    var director_url = $( "#director_url_select" );
    var director_ul =  $( "ul#selected_directors");
    if (director.val().length > 0) {
        if (director_url.val().length > 0) {
            director_ul.append('<a target="_blank" name="movie_director_urls[d_' + director_ul.children("li").length + ']" href="' + director_url.val() + '">' +
                '<li class="" name="directors[d_' + director_ul.children("li").length + ']" class="ml-5 label label-default">'+ director.val() +'</li></a>');
            director_url.val("");
        } else {
            director_ul.append('<li class="" name="directors[d_' + director_ul.children("li").length + ']" class="ml-5 label label-default">'+ director.val() +'</li>');
        }
        director.val("").focus();
    }
}

function addProducer() {
    var producer = $( "#producer_select" );
    var producer_url = $( "#producer_url_select" );
    var producer_ul =  $( "ul#selected_producers");
    if (producer.val().length > 0) {
        if (producer_url.val().length > 0) {
            producer_ul.append('<a target="_blank" name="movie_producer_urls[p_' + producer_ul.children("li").length + ']" href="' + producer_url.val() + '">' +
                '<li class="" name="movie_producers[p_' + producer_ul.children("li").length + ']" class="ml-5 label label-default">'+ producer.val() +'</li></a>');
            producer_url.val("");
        } else {
            producer_ul.append('<li class="" name="movie_producers[p_' + producer_ul.children("li").length + ']" class="ml-5 label label-default">'+ producer.val() +'</li>');
        }
        producer.val("").focus();
    }
}

function addWriter() {
    var writer = $( "#writer_select" );
    var writer_url = $( "#writer_url_select" );
    var writer_ul =  $( "ul#selected_writers");
    if (writer.val().length > 0) {
        if (writer_url.val().length > 0) {
            writer_ul.append('<a target="_blank" name="movie_writer_urls[w_' + writer_ul.children("li").length + ']" href="' + writer_url.val() + '">' +
                '<li class="" name="movie_writers[w_' + writer_ul.children("li").length + ']" class="ml-5 label label-default">'+ writer.val() +'</li></a>');
            writer_url.val("");
        } else {
            writer_ul.append('<li class="" name="movie_writers[w_' + writer_ul.children("li").length + ']" class="ml-5 label label-default">'+ writer.val() +'</li>');
        }
        writer.val("").focus();
    }
}

function addStar() {
    var star = $( "#star_select" );
    var star_url = $( "#star_url_select" );
    var star_ul =  $( "ul#selected_stars");
    if (star.val().length > 0) {
        if (star_url.val().length > 0) {
            star_ul.append('<a target="_blank" name="movie_star_urls[s_' + star_ul.children("li").length + ']" href="' + star_url.val() + '">' +
                '<li class="" name="movie_stars[s_' + star_ul.children("li").length + ']" class="ml-5 label label-default">'+ star.val() +'</li></a>');
            star_url.val("");
        } else {
            star_ul.append('<li class="" name="movie_stars[s_' + star_ul.children("li").length + ']" class="ml-5 label label-default">'+ star.val() +'</li>');
        }
        star.val("").focus();
    }
}