# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ping routing' do
  subject { { get: 'api/v1/ping' } }
  let(:controller) { 'api/v1/ping' }

  it { expect(get: api_v1_ping_path).to route_to('api/v1/ping#ping') }
  it do
    is_expected.to route_to(controller: controller,
                            action: 'ping')
  end
end
