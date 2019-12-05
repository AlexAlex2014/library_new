namespace :db do
  desc "Erase and fill database with fake data"
  task populate: :environment do
    require 'ffaker'
    [Book].each(&:delete_all)

    50.times do
      Book.create(
        remote_image_url: FFaker::Book.orly_cover,
        title: FFaker::Book.title,
        author: FFaker::Book.author,
        description: FFaker::Book.description,
        status: true,
        user_id: User.where("master" == true).first.id,
        reader: User.where("master" == false).sample.id
        )
    end
  end
end
