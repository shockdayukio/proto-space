$(function(){
  $('#js-avatar-input').change(function(e){
    var file = this.files[0],
        img = $(this).siblings('img'),
        fileReader = new FileReader();

    fileReader.onload = function(event) {
        img.attr({"src": event.target.result});
    };

    fileReader.readAsDataURL(file);
  });
});
