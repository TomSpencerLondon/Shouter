export default class startLightbox {

  static addImage(url, modalContent) {
    modalContent.attr('src', url)
  }
}

$('.modalImage').on('click', (e) => {
  let imageURL = $(e.target).attr("data-shout");
  let url = `http://localhost:3000${imageURL}`;
  let modalContent = $('#open-modal-image');

  startLightbox.addImage(url, modalContent);
});

