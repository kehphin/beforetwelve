FactoryGirl.define do
  factory :guest do
    first_name "MyString"
    last_name "MyString"
    checked_in false
    guestlist nil
    masterlist nil
  end
end
