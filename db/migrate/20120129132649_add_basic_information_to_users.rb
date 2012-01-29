class AddBasicInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :basic_information_title, :string
    add_column :users, :basic_information_second_title, :string
    add_column :users, :basic_information_birth_last_name, :string
    add_column :users, :basic_information_photo, :string
    add_column :users, :basic_information_telephone_number, :string
    add_column :users, :basic_information_email, :string
    add_column :users, :basic_information_web, :string
    add_column :users, :basic_information_blog, :string
    add_column :users, :basic_information_im, :string
    add_column :users, :basic_information_social_network, :text
    add_column :users, :basic_information_about_me, :text
    add_column :users, :basic_information_county, :string
    add_column :users, :basic_information_district, :string
    add_column :users, :basic_information_address_city, :string
    add_column :users, :basic_information_address_address, :string
    add_column :users, :basic_information_address_zipcode, :string
    add_column :users, :basic_information_note, :string
  end
end
