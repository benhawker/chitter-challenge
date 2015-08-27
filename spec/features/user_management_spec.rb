include UserHelpers

feature "User sign up" do 
	let(:user) { FactoryGirl.build(:user) }

	scenario "I can sign up as a new user" do
		expect { sign_up(user) }.to change(User, :count).by(1)
		expect(page).to have_content ("Welcome, #{user.email}")
		expect(User.first.email).to eq(user.email)
	end

	scenario "with a password that does not match" do
		user.password = "wrong_password"
		expect {sign_up(user) }.not_to change(User, :count)
		expect(current_path).to eq("/users")
		expect(page).to have_content "Password does not match"
	end

	scenario "cannot sign up without providing valid email" do
		user.email = "fereqcv"
		expect {sign_up(user) }.not_to change(User, :count)
		expect(current_path).to eq("/users")
		expect(page).to have_content "Email has an invalid format"
	end

	scenario "cannot sign up with an existing email previously registered" do
		sign_up(user)
		expect { sign_up(user) }.to change(User, :count).by(0)
		expect(page).to have_content "Email is already taken"
	end

	scenario "cannot sign up with an existing username previously registered" do
		sign_up(user)
		expect { sign_up(user) }.to change(User, :count).by(0)
		expect(page).to have_content "Username is already taken"
	end

end

feature "User sign in" do
	let(:user) { FactoryGirl.create(:user) }

	scenario "user will be succesfully signed in (with correct credentials)" do
		sign_in(user)
		expect(page).to have_content("Welcome, #{user.email}")
	end
end

feature "User sign out" do
	let(:user) { FactoryGirl.create(:user) }

	scenario "user can sign out while signed in" do
		sign_in(user)
		click_button "Sign Out"
		expect(page).to have_content("You are now logged out")
		expect(page).not_to have_content("Welcome, #{user.email}")
	end
end

feature "Password recovery" do
	let(:user) { FactoryGirl.create(:user) }

	scenario "requesting a password reset" do
		visit "users/password_reset"
		fill_in "email", with: user.email
		click_button "Request New Password"
		user = User.first
		expect(user.password_token).not_to be_nil
		expect(page).to have_content "Check your email"
	end

	scenario "actually resetting the password" do
		user.update(password_token: 'token')
		visit "/users/password_reset_reset/#{user.password_token}"
		expect(page.status_code).to eq 200
		expect(page).to have_content "enter a new password"
	end
end





