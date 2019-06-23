require 'rails_helper'

describe "Search" do
  include LoginHelpers
  include ShoutHelpers

  describe 'nav search' do
    context 'when search term is set' do
      before do
        Shout.reindex
        feature_sign_up_and_login
        add_text_shout("Hello! This is a new text shout.")
        add_text_shout("What! Is there another shouter?")
        add_text_shout("Ere what!? Here is another one.")
        Shout.searchkick_index.refresh
      end

      it 'search bar finds the correct shout', js: true do
        visit '/dashboard'

        find('input[name="search[term]"]').set("hello")
        find('#search-form-submit').click()
        expect(page.body.include?("Hello! This is a new text shout.")).to eq(true)
        expect(page.body.include?("What! Is there another shouter?")).to eq(false)
        expect(page.body.include?("Ere what!? Here is another one.")).to eq(false)
      end
    end

    context 'when search term is not set' do
      before do
        Shout.reindex
        feature_sign_up_and_login
        add_text_shout("Hello! This is a new text shout.")
        add_text_shout("What! Is there another shouter?")
        add_text_shout("Ere what!? Here is another one.")
        Shout.searchkick_index.refresh
      end

      it 'empty search bar returns all shouts', js: true do
        visit '/dashboard'
        find('input[name="search[term]"]').reload
        fill_in('Search', with: '')
        find('#search-form-submit').click()
        expect(page.body.include?("Hello! This is a new text shout.")).to eq(true)
        expect(page.body.include?("What! Is there another shouter?")).to eq(true)
        expect(page.body.include?("Ere what!? Here is another one.")).to eq(true)
      end
    end
  end
end
