# frozen_string_literal: true

class JsonSchemaService
  def initialize(action, controller, json_params)
    @action = action
    @controller = controller
    @json_params = json_params
  end

  def validate
    JSON::Validator.validate!(json_schema, json_to_validate)
  rescue JSON::Schema::ValidationError => e
    { data: e.message, status: :unprocessable_entity }
  end

  private

  def json_schema
    json = File.read(json_path)
    JSON.parse(json)
  end

  def json_path
    Rails.root.join('app', 'controllers', 'api', 'v1', 'schemas', 'users', "#{json_name}.json").to_s
  end

  def json_name
    "#{@action}_#{@controller}"
  end

  def json_to_validate
    { @controller.singularize => @json_params.to_hash }
  end
end
