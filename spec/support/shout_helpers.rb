module ShoutHelpers
  def add_photo_shout
    file_name = "dice.png"
    file_path = Rails.root.join('spec', 'fixtures', file_name)
    page.attach_file("image", file_path)
    find('#photo-shout-submit').click()
  end

  def add_text_shout(text)
    find('input[name="text_shout[body]"]').set(text)
    find('#text-shout-submit').click()
  end
end