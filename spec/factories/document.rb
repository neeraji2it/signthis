FactoryGirl.define do
  factory :document do
    architect factory: :user
    first_spouse_first_name 'Mike'
    first_spouse_last_name 'Jordan'
    second_spouse_first_name 'John'
    second_spouse_last_name 'Michles'
    price 1000
    terms 'Price is about 1000 +/- 12'
    first_spouse_detour_meeting true
    first_spouse_detour_meeting_description 'Desc'
    first_spouse_signature factory: :signature
    second_spouse_signature factory: :signature
    first_spouse_email { generate(:email) }
    second_spouse_email { generate :email }
    stripe_payment_id nil
  end
end
