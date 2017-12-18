$(function(){
  $('.js-image-file').change(function(){
    var file = this.files[0];
    var type = $(this).siblings('.js-image-hidden').val();
    var object = $(this).parent('div');
    fileReader = new FileReader();

    fileReader.onload = function(event) {
      object.css({
        "background": `url(${event.target.result}) no-repeat center center `,
        "background-size": "cover"
      });
    };
    fileReader.readAsDataURL(file);
  });
});

