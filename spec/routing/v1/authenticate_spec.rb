# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'authenticate routing' do
  subject { { post: 'api/v1/authenticate' } }
  let(:controller) { 'api/v1/authentication' }

  it do
    is_expected.to route_to(controller: controller,
                            action: 'authenticate')
  end
end
