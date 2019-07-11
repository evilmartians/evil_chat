class ComponentGenerator < Rails::Generators::Base
  argument :name, required: true, desc: "Component name, e.g: button"

  def create_view_file
    create_file "#{component_path}/_#{component_name}.html.erb"
  end

  def create_css_file
    create_file "#{component_path}/#{component_name}.pcss"
  end

  def create_js_file
    create_file "#{component_path}/#{component_name}.js" do
      # require component's CSS inside JS automatically
      "import \"./#{component_name}.pcss\";\n"
    end
  end

  protected

  def component_name
    @component_name ||= name.underscore.dasherize
  end

  def component_path
    "frontend/components/#{component_name}"
  end
end
