$(document).on( 'change', '#js-avatar-input', function(){
  var file = this.files[INDEX_OF_IMAGE_FILE];
  var img = $(this).siblings('img');
  var fileReader = new FileReader();

  fileReader.onload = function(event) {
      img.attr({"src": event.target.result});
  };

  fileReader.readAsDataURL(file);
});
