namespace :db do
  desc "Erase and fill database with fake data"
  task populate: :environment do
    # require 'ffaker'
    # [Book].each(&:delete_all)
    # [Category].each(&:delete_all)
    # [Comment].each(&:delete_all)
    # [User].each(&:delete_all)

    path = './app/assets/images/categories'
    Dir.entries(path).map do |dir|
      @dir_name = Category.new
      @dir_name.name = dir
      files = Dir["./app/assets/images/categories/#{dir}/*.svg"]
      files.each do |file_name|
        if !File.directory? file_name
          File.open("#{file_name}") do |file|
            @dir_name.image = file
            @dir_name.save!
          end
        end
      end
    end

    # 50.times do
    #   Book.create(
    #     remote_image_url: FFaker::Book.orly_cover,
    #     title: FFaker::Book.title,
    #     author: FFaker::Book.author,
    #     description: FFaker::Book.description,
    #     status: true,
    #     user_id: User.where("master" == true).first.id,
    #     category_id: Category.all.sample.id
    #   # reader: User.where("master" == false).sample.id
    #     )
    # end
  end
end
