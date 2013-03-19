$(function(){
  $(".btn.btn-med.btn-warning").hide()
  $('form.guess').submit(function(e){
    e.preventDefault();
    console.log(this);
    $.ajax({
      type: "POST",
      data: $(this).serialize(),
      url: "/guess",
      dataType: "json"
    }).done(function(data){
      $(".btn.btn-med.btn-warning").show()
      if (data.last_try === true){
        $('span').html('Correct! Good Job!!');
      }
      else 
      {
        $('span').html('Not quite. The correct answer is: ' + data.answer);
      }
    })
    .fail(function(){
      alert("This shit failed!");
    });
  });
});