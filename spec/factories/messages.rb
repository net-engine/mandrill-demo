# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user nil
    subject "MyString"
    content "MyString"
  end
end
