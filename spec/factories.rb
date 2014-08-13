FactoryGirl.define do
  factory :user do
    password = "YouWillNeverGue$$"
    dom1 = %w(This That Those Them All Other Not)
    dom2 = %w(Fire Room Group Firm Out Green Sue Govment)
    dom3 = %w(com org us gov tv de uk fr co.nz)
    name = Faker::Name.name
    name_no_blanks = name.gsub(/\s+/, "")
    email = "#{name_no_blanks}@#{dom1.sample}#{dom2.sample}.#{dom3.sample}"
    
    name     "David E. Smyth"
    email    "Capt.David.Smyth@gmail.com"
    password "Lets Go Sailing"
    password_confirmation "Lets Go Sailing"
  end
end