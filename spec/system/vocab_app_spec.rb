# spec/system/vocab_app_spec.rb
require 'rails_helper'

RSpec.describe "WordBooks", type: :system do
  it "トップページにアクセスできる" do
    visit root_path
    expect(page).to have_content("登録済み単語一覧")
  end
end
