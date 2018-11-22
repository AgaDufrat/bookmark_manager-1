feature 'Update a bookmark' do
  scenario 'A user can update an existing bookmark' do
    Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit('/bookmarks')

    click_button('Update')

    fill_in :title, with: "New Academy"
    fill_in :url, with: "http://www.newacademy.com"

    click_button('Submit')

    expect(page).to have_link('New Academy', href: 'http://www.newacademy.com')
  end
end
