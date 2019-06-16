require 'rails_helper'

describe "Shouts" do
  include LoginHelpers
  include ShoutHelpers

  before do
    feature_sign_up_and_login
  end

  context 'text_shout' do
    before do
      add_text_shout
    end

    it 'has links and content' do
      expect(page.body.include?("Hello! This is a new text shout.")).to eq(true)
      expect(page).to have_css('#primary-shout-user-link-1')
      expect(page).to have_css('#secondary-shout-user-link-1')
      expect(page).to have_css('#shout-link-1')
    end

    it '#primary-shout-user-link goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#secondary-shout-user-link-1 goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#shout-link-1 goes to user show page' do
      find('#shout-link-1').click()
      expect(page.body).to have_css('.shouts.show')
    end
  end

  context 'photo_shout' do
    before do
      add_photo_shout
    end

    it 'photo_shout submission succeeds' do
      expect(page).to have_xpath("//img[contains(@src,'dice.png')]")
      expect(page).to have_css('#photo-shout-1')
      expect(page).to have_css('#primary-shout-user-link-1')
      expect(page).to have_css('#secondary-shout-user-link-1')
      expect(page).to have_css('#shout-link-1')
    end

    it '#photo-shout-1 link shows modal' do
      find('#photo-shout-1').click()
      require 'pry'; binding.pry
      expect(page).to have_css('.modal-content')
    end

    it '#primary-shout-user-link goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#secondary-shout-user-link-1 goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#shout-link-1 goes to user show page' do
      find('#shout-link-1').click()
      expect(page.body).to have_css('.shouts.show')
    end
  end
end

# <div class="container">
#   <%= div_for shout do %>
#     <div class="row">
#       <div class="col-sm-12 strip">
#         <%= gravatar(shout.user) %>
#         <strong>
#           <%= link_to shout.user.username,
#                       shout.user,
#                       class:"shout-link", id: "primary-shout-user-link-#{shout.id}" %>
#         </strong>
#         <span class="light"> @<%= link_to shout.user.username,
#                                           shout.user,
#                                           class:"shout-link",
#                                           id: "secondary-shout-user-link-#{shout.id}" %> - <span class="time">
#                                               <%= link_to time_ago_in_words(shout.created_at),
#                                                           shout,
#                                                           class:"shout-link", id: "shout-link-#{shout.id}" %>
#                                             </span>
#                                             </span>
#                                           <br>
#         <%= render shout.content %><br>
        
#         <div class="summary">
#           <span class="buttons">
#             <% if shout.user == current_user %>
#               <%= link_to 'Delete Shout', shout, method: :delete, confirm: 'Are you sure?', class: 'btn btn-danger', id: 'delete-button' %>
#             <% end %>
#             <a href="#"><i class="fa fa-reply"></i> Reply</a>
#             <a href="#"><i class="fa fa-retweet"></i> Retweet</a>
#             <a href="#"><i class="fa fa-star"></i> Favourite</a>
#             <a href="#"><i class="fa fa-ellipsis-h"></i> More</a>
#           </span>
#         </div>
#       </div>
#     </div>
#   <% end %>
# </div>


