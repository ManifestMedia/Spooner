//Turn off logs
var loging = true

//Toggle loader animation 
var loader = function (state) {
  if (state == "hide") {
    $('.loader').hide()
    $('.shadow').css("opacity" , "1")
    $(".settings").children().unbind('click');
  }
  else {
    $('.loader').show()
    $('.shadow').css("opacity" , "0.7")
    $(".settings").children().bind('click', function(){ return false; });
  }
}

var Log = function (content){
  if (loging)
    console.log(content)
}

var files;

$( document ).ready(function() {

	//Open settings bar
  $('.open-settings').click(function(event){
    Log("Open settings: " + this.id)
    if ($('.settings').is(':visible')) {
      $('.settings').slideUp();
      $('.spooners-alert').hide()  
    };
    $('.settings.'+this.id).slideDown();
    event.preventDefault();
  })

  //Close settings bar
  $('.close-settings-button').click(function(event){
    $('.settings').slideUp();
    $('.spooners-alert').hide()
    event.preventDefult()
  })

  //Hide alerts/notifications
  $('.close-notification-button').click(function(e){
    $('.spooners-alert').hide()
  })

  //Inviting spooners
  $('#invite_spooner').click(function(event){
    event.preventDefault()
    spooner_id = $(this).attr("spooner-id").val()
    $.post('/invite_spooner', {"spooner_id" : spooner_id}, function(response){
      if (response.success) {
        $(this).replace("<p>"+response.message+"</p>")
      }
      else {
        alert("Oops a problem: " + response)
      }
    }, 'json')
  })

  //Logout
  $('#logout').click(function(event){
    $.post("/logout", {}, function(response){
      if (response.success) {
        $('#login').removeClass("hidden")
        $('#profile, #logout, #active_session').addClass("hidden")
      };
    })
  })

  //File upload
  $('input[type=file]').on('change', function(event){
    files = event.target.files;
    Log("Files prepared " + files);
  });

  //Submiting forms
  $('form').submit(function(){
    loader("show")
    var form = "#"+this.id
    var url = this.id.replace('-form','');    
    Log("Form id: "+form)
    Log("Form url: "+url)
    Log("Serialized data: "+$(form).serialize())

    if (url == "upload-img") {
      Log("File upload!")
      event.stopPropagation(); 
      event.preventDefault(); 
      var data = new FormData();
      $.each(files, function(key, value){
        data.append("profile-img", value);
      });
      $.ajax({
        url: url,
        type: 'POST',
        data: data,
        cache: false,
        dataType: 'json',
        processData: false, // Don't process the files
        contentType: false, // Set content type to false as jQuery will tell the server its a query string request
        success: function(response){
          Log(response)
          loader("hide")
          if(response.success){
            $(".profile-pic img").attr("src", "uploads/"+response.filename)
          }
          else {
            $('.spooners-alert p').text("There was a problem with the upload, please try again!")
            $('.spooners-alert').show() 
          }
        }
      }, 'json');
    }
    else {
      $.ajax({
        type: "POST",
        url: url,
        data: $(form).serialize(), 
        success: function(response){
          loader("hide")
          if (response.success) {
            Log("success "+response)
            $('#login').addClass("hidden")
            $('#profile, #logout, #active_session').removeClass("hidden")
            $('.spooners-alert p').text(response.message)
            $('.spooners-alert').show()
            $(form)[0].reset();
          }
          else{
            Log("failure "+response)
            $('.spooners-alert p').text(response.message)
            $('.spooners-alert').show() 
          }
        }
      }, 'json');
    }
    return false; 
  })

  // $('#username').rules("add", {required:true})
  // $("#register-form").validate({  
  //   submitHandler: function(form) {
  //     form.submit(function(){
  //       loader("show")
  //       var url = "/register"; 
  //       $.ajax({
  //         type: "POST",
  //         url: url,
  //         data: $("#register-form").serialize(), 
  //         success: function(response){
  //           response = jQuery.parseJSON(response);
  //           alert(response.message); 
  //           loader("hide")
  //         }
  //       }, 'json');
  //       return false; 
  //     })
  //   }
  // });
})