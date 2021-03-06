require 'spec_helper'

describe "Sending an email via the contact form" do

  before do
    sign_in :user_with_fixtures
  end

  it "should send mail" do
    ContactForm.any_instance.stub(:deliver).and_return(true)
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_name", with: "Test McPherson" 
    fill_in "contact_form_email", with: "archivist1@example.com"
    fill_in "contact_form_message", with: "I am contacting you regarding ScholarSphere."
    fill_in "contact_form_subject", with: "My Subject is Cool"
    select "Depositing content", from: "contact_form_category"
    click_button "Send"
    page.should have_content "Thank you"
    # this step allows the delivery to go back to normal
    ContactForm.any_instance.unstub(:deliver)
  end

  it "should give an error when I don't provide a contact type" do
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_name", with: "Test McPherson" 
    fill_in "contact_form_email", with: "archivist1@example.com"
    fill_in "contact_form_message", with: "I am contacting you regarding ScholarSphere."
    fill_in "contact_form_subject", with: "My Subject is Cool"
    click_button "Send"
    page.should have_content "Sorry, this message was not sent successfully"
  end

  it "should give an error when I don't provide a valid email" do
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_name", with: "Test McPherson" 
    fill_in "contact_form_email", with: "archivist1"
    fill_in "contact_form_message", with: "I am contacting you regarding ScholarSphere."
    fill_in "contact_form_subject", with: "My Subject is Cool"
    select "Depositing content", from: "contact_form_category"
    click_button "Send"
    page.should have_content "Sorry, this message was not sent successfully"
  end

  it "should give an error when I don't provide a name" do
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_email", with: "archivist1@example.com"
    fill_in "contact_form_message", with: "I am contacting you regarding ScholarSphere."
    fill_in "contact_form_subject", with: "My Subject is Cool"
    select "Depositing content", from: "contact_form_category"
    click_button "Send"
    page.should have_content "Sorry, this message was not delivered"
  end

  it "should give an error when I don't provide a subject" do
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_name", with: "Test McPherson" 
    fill_in "contact_form_email", with: "archivist1@example.com"
    fill_in "contact_form_message", with: "I am contacting you regarding ScholarSphere."
    select "Depositing content", from: "contact_form_category"
    click_button "Send"
    page.should have_content "Sorry, this message was not sent successfully"
  end

  it "should give an error when I don't provide a message" do
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_name", with: "Test McPherson" 
    fill_in "contact_form_email", with: "archivist1@example.com"
    fill_in "contact_form_subject", with: "My Subject is Cool"
    select "Depositing content", from: "contact_form_category"
    click_button "Send"
    page.should have_content "Sorry, this message was not sent successfully"
  end

  it "should give an error when I provide an invalid captcha" do
    visit '/'
    click_link "Contact"
    page.should have_content "Contact Form"
    fill_in "contact_form_contact_method", with: "My name is" 
    fill_in "contact_form_name", with: "Test McPherson" 
    fill_in "contact_form_email", with: "archivist1@example.com"
    fill_in "contact_form_subject", with: "My Subject is Cool"
    fill_in "contact_form_message", with: "I am contacting you regarding ScholarSphere."
    select "Depositing content", from: "contact_form_category"
    click_button "Send"
    page.should have_content "Sorry, this message was not sent successfully"
  end
end
