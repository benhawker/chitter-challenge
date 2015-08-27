	
module UserHelpers
	def sign_up(user)
		visit "/users/new"
		expect(page.status_code).to eq(200)
		fill_in :email, with: user.email
		fill_in :username, with: user.username
		fill_in :password, with: user.password
		fill_in :password_confirmation, with: user.password_confirmation
		click_button "Sign Up"
	end

	def sign_in(user)
		visit "/sessions/new"
		fill_in :email, with: "bob@test.com"
		fill_in :password, with: "password"
		click_button "Sign In"
	end
end