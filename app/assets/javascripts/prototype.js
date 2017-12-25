const MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE = 6;

function appendSubImageForm(sub_image_id){
  var html = '<li class="list-group-item col-md-4">'+
               '<div class="image-upload">' +
                 '<img>' +
                 '<input type="file" name="prototype[captured_images_attributes][' + sub_image_id + '][image]" id="prototype_captured_images_attributes_' + sub_image_id + '_image" class="js-image-file">' +
                 '<input type="hidden" name="prototype[captured_images_attributes][' + sub_image_id + '][status]" id="prototype_captured_images_attributes_' + sub_image_id + '_status" value="sub">' +
               '</div>' +
             '</li>';
  $('#js-proto-sub-list').append(html);
};

function appendButtonToAddSubImageForm(){
  var html = '<li class="list-group-item col-md-4" id="js-image-plus">'+
               '<div class="image-upload-plus">' +
                 '<span> +' +
               '</div>' +
             '</li>';
  $("#js-proto-sub-list").append(html);
};

$('.js-image-file').on('change', function(){
  var file;
  var image;
  var fileReader;
  file = this.files[0];
  image = $(this).siblings('img');
  fileReader = new FileReader();

  fileReader.onload = function(event) {
    image.attr({
      "src": event.target.result,
    });
  };
  fileReader.readAsDataURL(file);
});

$(document).on('click', '#js-image-plus', function(){
  $('#js-image-plus').remove();
  var sub_images_count = $("#js-proto-sub-list .js-image-file").length + 1;
  if (sub_images_count < MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE + 1){
    var sub_image_id = sub_images_count;
    appendSubImageForm(sub_image_id);
    if (sub_images_count < MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE){
      appendButtonToAddSubImageForm();
    }
  };
});
