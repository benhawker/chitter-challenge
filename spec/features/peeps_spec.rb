feature "Viewing & Creating Peeps" do
	let!(:user) { create(:user) }

	scenario "User can create a new peep" do
	 	sign_in(user)
		visit "/peeps/new"
	 	fill_in "content", with: "I am a test peep"
	 	click_button "Tweet"
	 	expect(current_path).to eq "/"
	 	expect(page).to have_content "I am a test peep"
	end

	scenario "All Peeps are displayed on the homepage" do
	 	sign_in(user)
		visit "/peeps/new"
	 	fill_in "content", with: "I am a test peep"
	 	click_button "Tweet"
	 	visit "/"
	 	expect(page).to have_content "I am a test peep"
	end

	scenario "Associated username is displayed alongside the peep" do
	 	sign_in(user)
		visit "/peeps/new"
	 	fill_in "content", with: "I am a test peep"
	 	click_button "Tweet"
	 	visit "/"
	 	expect(page).to have_content user.username
	end
end