require 'spec_helper'

describe "signing up", :type => :feature do

  before :each do
    User.create( name: 'Joe', :email => 'user@example.com', :password => 'hello')
  end

  it "signs in" do
    visit '/profile'
    within( "#login" ) do
      fill_in 'email', :with => 'user@example.com'
      fill_in 'password', :with => 'hello'
    end
    click_on 'Log On!'
    page.should have_button 'Play!'
  end

end

