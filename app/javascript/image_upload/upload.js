export default class ImageUpload {

  static changeFileName(button) {
    let fileName = button.val().split('\\').pop(); 
    button.next('.custom-file-label').addClass("selected").html(fileName);
  }
}

$('.custom-file-input').on('change', (e) => {
  console.log("hello");
  var $this = $(e.currentTarget);
  ImageUpload.changeFileName($this);
});

