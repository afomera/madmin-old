class Madmin::PageGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def copy_template
    template(
      "template.rb.erb",
      Rails.root.join("app/controllers/madmin/#{file_name}_controller.rb"),
    )

    template(
      "template.html.erb",
      Rails.root.join("app/views/madmin/#{file_name}/index.html.erb"),
    )

    inject_into_file(
      Rails.root.join("config/routes.rb"),
      after: "namespace :madmin do\n"
    ) { "    get \"#{file_name}\", to: \"#{file_name}#index\"\n" }
  end
end
