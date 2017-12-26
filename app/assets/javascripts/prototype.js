const MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE = 6;
const INDEX_OF_IMAGE_FILE = 0;

function appendSubImageForm(sub_image_id){
  var html = '<li class="sub-image-item col-md-4">'+
               '<div class="image-upload">' +
                 '<img>' +
                 '<input type="file" name="prototype[captured_images_attributes][' + sub_image_id + '][image]" id="prototype_captured_images_attributes_' + sub_image_id + '_image" class="js-sub-image-file js-image">' +
                 '<input type="hidden" name="prototype[captured_images_attributes][' + sub_image_id + '][status]" id="prototype_captured_images_attributes_' + sub_image_id + '_status" value="sub">' +
               '</div>' +
             '</li>';
  $('#js-proto-sub-list').append(html);
};

function appendSubImageFormButton(){
  var html = '<li class="sub-image-item col-md-4" id="js-image-plus">'+
               '<div class="image-upload-plus">' +
                 '<span> +' +
               '</div>' +
             '</li>';
  $("#js-proto-sub-list").append(html);
};

$(document).on('change', '.js-sub-image-file', function(){
  var file = this.files[INDEX_OF_IMAGE_FILE];
  var image = $(this).siblings('img');
  var fileReader = new FileReader();

  fileReader.onload = function(event) {
    image.attr({
      "src": event.target.result,
    });
  };
  fileReader.readAsDataURL(file);
});

$(document).on('click', '#js-image-plus', function(){
  var group_items_count = $(".sub-image-item").length;
  $(this).remove();
  if (group_items_count <= MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE){
    var sub_image_id = group_items_count;
    appendSubImageForm(sub_image_id);
    if (group_items_count < MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE){
      appendSubImageFormButton();
    }
  };
});
