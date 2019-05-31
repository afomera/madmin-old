class Madmin::ControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../../../../../", __FILE__)

  def copy_controller
    copy_file(
      "app/controllers/madmin/#{file_name}_controller.rb",
      "app/controllers/madmin/#{file_name}_controller.rb"
    )
  end
end
