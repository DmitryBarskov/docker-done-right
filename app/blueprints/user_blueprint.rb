class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email

  field :fullName do |user|
    "#{user.first_name} #{user.last_name}"
  end
end
