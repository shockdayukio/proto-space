$(function(){
  $(document).on('change', '.js-image-file', function(){

    var file = this.files[0];
    var image = $(this).siblings('img');
    fileReader = new FileReader();

    fileReader.onload = function(event) {
      image.attr({
        "src": event.target.result,
      });
    };
    fileReader.readAsDataURL(file);
  });
});

